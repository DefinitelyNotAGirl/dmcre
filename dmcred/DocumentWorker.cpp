#include "DocumentWorker.h"
#include "core.h"

#include <clang/Frontend/TextDiagnosticPrinter.h>
#include <clang/Lex/Lexer.h>
#include <clang/AST/RecursiveASTVisitor.h>
#include <clang/AST/Mangle.h>
#include <clang/Serialization/ASTWriter.h>
#include <clang/Serialization/ModuleCache.h>

#include <llvm/Support/raw_ostream.h>

#include <forward_list>

namespace dmcred {
	std::mutex DocumentWorkerQueueMutex;
	std::deque<DocumentWorker*> DocumentWorkers;
	std::map<std::string,DocumentWorker*> ActiveWorkers;

	DocumentWorker::DocumentWorker(std::string path): path(path),version(0),PreambleBounds(0,false) {
		std::cerr << "add " << path << std::endl;
	}

	DocumentWorker::~DocumentWorker() {
		std::cerr << "drop " << path << std::endl;
		this->stop();
	}

	void DocumentWorker::QueueTask(std::function<void()> task) {
		std::lock_guard lock(TaskMutex);
		TaskQueue.push(task);
		TaskConditionVariable.notify_all();
	}

	void DocumentWorker::start() {
		StopWorkerThread.store(false);
		WorkerThread = new std::thread([this]{
			std::mutex mtx;
			try {
				while(true) {
					if(TaskQueue.empty()) {
						std::unique_lock lock(mtx);
						TaskConditionVariable.wait(lock);
					};

					if(StopWorkerThread.load()) {
						break;
					}

					auto task = TaskQueue.front();
					TaskQueue.pop();

					task();
				}
			} catch(std::runtime_error& e) {
				std::cerr << "[" << path << "]: " << e.what() << std::endl;
			} catch(std::logic_error& e) {
				std::cerr << "[" << path << "]: " << e.what() << std::endl;
			} catch(std::exception& e) {
				std::cerr << "[" << path << "]: " << e.what() << std::endl;
			}
			StopWorkerThread.store(true);
		});
	}

	void DocumentWorker::stop() {
		if(WorkerThread != nullptr) {
			StopWorkerThread.store(true);
			WorkerThread->join();
			delete WorkerThread;
			WorkerThread = nullptr;
		}
	}

	std::string TranslateDeclToTokenType(clang::Decl* decl) {
		if(auto CXXRecordDecl = llvm::dyn_cast<clang::CXXRecordDecl>(decl)) {
			if(CXXRecordDecl->getTagKind() == clang::CXXRecordDecl::TagKind::Class) return "class";
			if(CXXRecordDecl->getTagKind() == clang::CXXRecordDecl::TagKind::Enum) return "enum";
			if(CXXRecordDecl->getTagKind() == clang::CXXRecordDecl::TagKind::Struct) return "struct";
			if(CXXRecordDecl->getTagKind() == clang::CXXRecordDecl::TagKind::Interface) return "interface";
			if(CXXRecordDecl->getTagKind() == clang::CXXRecordDecl::TagKind::Union) return "struct";
			return "class";
		}

		if(llvm::isa<clang::NamespaceDecl>(decl)) return "namespace";

		if(llvm::isa<clang::CXXMethodDecl>(decl)) return "method";

		if(llvm::isa<clang::FunctionDecl>(decl)) return "function";

		if(llvm::isa<clang::ParmVarDecl>(decl)) return "parameter";
		if(llvm::isa<clang::VarDecl>(decl)) return "variable";

		return "unknown";
	}

	#define CALLBACK_FORWARDER(name, result, parameters, arguments) \
    	__public std::function<result parameters> m_##name;\
    	__public result name parameters {\
    	    return this->m_##name arguments;\
    	}

	#define CALLBACK_FORWARDER_VOID(name, parameters, arguments) \
    	__public std::function<void parameters> m_##name;\
    	__public void name parameters {\
    	    if(this->m_##name)this->m_##name arguments;\
    	}

	#define CALLBACK_FORWARDER_DEFAULT(name, result, parameters, arguments, _default) \
    	__public std::function<result parameters> m_##name;\
    	__public result name parameters {\
    	    if(not this->m_##name) return _default;\
			return this->m_##name arguments;\
    	}

	class ASTConsumer : public clang::ASTConsumer {
		__public ASTConsumer() {
		}

		CALLBACK_FORWARDER_VOID(HandleTranslationUnit,(clang::ASTContext& ctx),(ctx))
	};
	
	class DiagnosticConsumer : public clang::DiagnosticConsumer {
		__public DiagnosticConsumer() {
		}

		CALLBACK_FORWARDER_VOID(HandleDiagnostic,(clang::DiagnosticsEngine::Level DiagLevel,const clang::Diagnostic& Info),(DiagLevel,Info))
	};

	class RecursiveASTVisitor : public clang::RecursiveASTVisitor<RecursiveASTVisitor> {
		__public RecursiveASTVisitor() {
		}

		CALLBACK_FORWARDER_DEFAULT(VisitDecl,bool,(clang::Decl* decl),(decl),true);
		CALLBACK_FORWARDER_DEFAULT(VisitDeclRefExpr,bool,(clang::DeclRefExpr* decl),(decl),true);
	};

	#if false
	static inline void ____() {
		clang::RecursiveASTVisitor<RecursiveASTVisitor>::VisitDecl
	}
	#endif

	static std::string getDeclIdentifier(clang::Decl* decl) {
		return "decl@"+std::to_string(uint64_t(decl));
	}

	void DocumentWorker::BuildPreamble() {
		std::cerr << "BuildPreamble: " << path << std::endl;

		DiagnosticConsumer diagnosticConsumer;

		auto compiler = getCompiler(llvm::StringRef(path),&diagnosticConsumer);

		IPC::Object diagnostics(new std::vector<IPC::Object>);

		diagnosticConsumer.m_HandleDiagnostic = [&](clang::DiagnosticsEngine::Level DiagLevel,const clang::Diagnostic& Info){
			if(not compiler->getContext()->SourceManager->isInMainFile(Info.getLocation())) {
				//std::cerr << "diagnostic ignored: not in main file" << std::endl;
				return;
			}

			std::cerr << "diagnostic | level: " << DiagLevel << std::endl;

			IPC::Object diagnostic = new std::vector<IPC::Object>({
				new std::vector<IPC::Object>()
			});

			llvm::SmallVector<char,16> llvmStr;
			Info.FormatDiagnostic(llvmStr);
			auto str = new std::string();
			str->resize(llvmStr.size());
			std::memcpy(str->data(),llvmStr.data(),str->size());

			auto& sourceManager = *compiler->getContext()->SourceManager;

			auto& ranges = diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>();
			for(auto& range : Info.getRanges()) {
				auto begin = range.getBegin();
				auto end = clang::Lexer::getLocForEndOfToken(
					range.getEnd(),
					0, 
					sourceManager,
					*compiler->getLanguageOptions()
				);
				if(end.isInvalid()) {
					end = range.getEnd();
				}
				if(begin.isInvalid() or end.isInvalid()) {
					return;
				}

				auto beginLine = sourceManager.getLineNumber(begin);
				auto beginColumn = sourceManager.getColumnNumber(begin);
				auto endLine = sourceManager.getLineNumber(end);
				auto endColumn = sourceManager.getColumnNumber(end);
				diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>().push_back(
					new std::vector<IPC::Object>({
						new double(beginLine),
						new double(beginColumn),
						new double(endLine),
						new double(endColumn)
					})
				);
			}
			if(ranges.empty()) {
				auto begin = Info.getLocation();
				auto end = clang::Lexer::getLocForEndOfToken(
					Info.getLocation(),
					0,
					sourceManager,
					*compiler->getLanguageOptions()
				);
				if(end.isInvalid()) {
					end = Info.getLocation();
				}
				if(begin.isInvalid() or end.isInvalid()) {
					return;
				}

				auto beginLine = sourceManager.getLineNumber(begin);
				auto beginColumn = sourceManager.getColumnNumber(begin);
				auto endLine = sourceManager.getLineNumber(end);
				auto endColumn = sourceManager.getColumnNumber(end);
				diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>().push_back(
					new std::vector<IPC::Object>({
						new double(beginLine),
						new double(beginColumn),
						new double(endLine),
						new double(endColumn)
					})
				);
			}

			diagnostic.as<std::vector<IPC::Object>>().push_back(str);

			diagnostics.as<std::vector<IPC::Object>>().push_back(diagnostic);
		};

		IPC::Object Tokens = new std::vector<IPC::Object>;
		IPC::Object Hovers(new std::vector<IPC::Object>);

		RecursiveASTVisitor RecursiveASTVisitor;

		std::forward_list<clang::Decl*> ReferencedDeclarations;
		auto OnDeclarationReference = [&](clang::Decl* decl){
			for(auto i : ReferencedDeclarations) if(i == decl) return;
			ReferencedDeclarations.push_front(decl);

			std::string Hover_vscode_markdownWithHtmlAndIcons = [&]{
				std::stringstream out;

				out << "declared in " << compiler->getSourceManager()->getFilename(decl->getLocation()).str() << " on line " << compiler->getSourceManager()->getLineNumber(decl->getLocation()) << std::endl;				

				return out.str();
			}();

			Hovers.as<std::vector<IPC::Object>>().push_back(new std::vector<IPC::Object>({
				new std::string(getDeclIdentifier(decl)),
				new std::string(Hover_vscode_markdownWithHtmlAndIcons)
			}));
		};

		RecursiveASTVisitor.m_VisitDeclRefExpr = [&](clang::DeclRefExpr* DeclRefExpr) -> bool {
			if(not DeclRefExpr->getLocation().isValid()) return true;
			if(not compiler->getSourceManager()->isInMainFile(DeclRefExpr->getLocation())) return true;

			const clang::SourceLocation& location = DeclRefExpr->getLocation();

			clang::Decl* decl = DeclRefExpr->getDecl();

			OnDeclarationReference(decl);

			long long column = compiler->getSourceManager()->getColumnNumber(location);
			long long line = compiler->getSourceManager()->getLineNumber(location);
			long long length = DeclRefExpr->getNameInfo().getAsString().length();
			Tokens.as<std::vector<IPC::Object>>().push_back(new std::vector<IPC::Object>({
				new std::string(TranslateDeclToTokenType(decl)),
				new double(line),
				new double(column),
				new double(length),
				new std::string(getDeclIdentifier(decl))
			}));

			return true;
		};

		ASTConsumer astConsumer;
		astConsumer.m_HandleTranslationUnit = [&](clang::ASTContext& astContext){
			RecursiveASTVisitor.TraverseTranslationUnitDecl(astContext.getTranslationUnitDecl());
		};

		std::shared_ptr<clang::ModuleCache> moduleCache = clang::createCrossProcessModuleCache();

		PreamblePCHBuffer = std::make_shared<clang::PCHBuffer>();

		clang::PCHGenerator pchGenerator(
			*compiler->getPreprocessor(),
			*moduleCache,
			"",
			"",
			PreamblePCHBuffer,
			*compiler->getCodeGenOptions(),
			{}
		);

		compiler->addASTConsumer(&astConsumer);
		compiler->addASTConsumer(&pchGenerator);

		compiler->InitializeSema();

		compiler->setMainFile(path, llvm::MemoryBuffer::getMemBufferCopy(PreambleContent->getBuffer()));

		diagnosticConsumer.BeginSourceFile(*compiler->getLanguageOptions(),compiler->getPreprocessor());

		compiler->compile();

		delete compiler;
	}

	void DocumentWorker::update(std::string content,long long version) {
		if(version <= this->version) {
			return;
		}
		this->version = version;

		std::cerr << "//////////////////////////////////////\n" << content << "\n//////////////////////////////////////" << std::endl;

		DiagnosticConsumer diagnosticConsumer;

		auto compiler = getCompiler(llvm::StringRef(path),&diagnosticConsumer);

		auto fileBuffer = llvm::MemoryBuffer::getMemBufferCopy(content);

		PreambleBounds = clang::ComputePreambleBounds(*compiler->getLanguageOptions(), *fileBuffer, UINT_MAX);

		std::cerr << "PreambleBounds.Size: " << PreambleBounds.Size << std::endl;

		auto NewPreambleContent = llvm::MemoryBuffer::getMemBufferCopy(fileBuffer->getBuffer().slice(0,PreambleBounds.Size));
		if(NewPreambleContent->getBuffer() != PreambleContent->getBuffer()) {
			PreambleContent.swap(NewPreambleContent);
			BuildPreamble();
		}
		
		IPC::Object diagnostics(new std::vector<IPC::Object>);

		diagnosticConsumer.m_HandleDiagnostic = [&](clang::DiagnosticsEngine::Level DiagLevel,const clang::Diagnostic& Info){
			if(not compiler->getContext()->SourceManager->isInMainFile(Info.getLocation())) {
				//std::cerr << "diagnostic ignored: not in main file" << std::endl;
				return;
			}

			std::cerr << "diagnostic | level: " << DiagLevel << std::endl;

			IPC::Object diagnostic = new std::vector<IPC::Object>({
				new std::vector<IPC::Object>()
			});

			llvm::SmallVector<char,16> llvmStr;
			Info.FormatDiagnostic(llvmStr);
			auto str = new std::string();
			str->resize(llvmStr.size());
			std::memcpy(str->data(),llvmStr.data(),str->size());

			auto& sourceManager = *compiler->getContext()->SourceManager;

			auto& ranges = diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>();
			for(auto& range : Info.getRanges()) {
				auto begin = range.getBegin();
				auto end = clang::Lexer::getLocForEndOfToken(
					range.getEnd(),
					0, 
					sourceManager,
					*compiler->getLanguageOptions()
				);
				if(end.isInvalid()) {
					end = range.getEnd();
				}
				if(begin.isInvalid() or end.isInvalid()) {
					return;
				}

				auto beginLine = sourceManager.getLineNumber(begin);
				auto beginColumn = sourceManager.getColumnNumber(begin);
				auto endLine = sourceManager.getLineNumber(end);
				auto endColumn = sourceManager.getColumnNumber(end);
				diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>().push_back(
					new std::vector<IPC::Object>({
						new double(beginLine),
						new double(beginColumn),
						new double(endLine),
						new double(endColumn)
					})
				);
			}
			if(ranges.empty()) {
				auto begin = Info.getLocation();
				auto end = clang::Lexer::getLocForEndOfToken(
					Info.getLocation(),
					0,
					sourceManager,
					*compiler->getLanguageOptions()
				);
				if(end.isInvalid()) {
					end = Info.getLocation();
				}
				if(begin.isInvalid() or end.isInvalid()) {
					return;
				}

				auto beginLine = sourceManager.getLineNumber(begin);
				auto beginColumn = sourceManager.getColumnNumber(begin);
				auto endLine = sourceManager.getLineNumber(end);
				auto endColumn = sourceManager.getColumnNumber(end);
				diagnostic.as<std::vector<IPC::Object>>()[0].as<std::vector<IPC::Object>>().push_back(
					new std::vector<IPC::Object>({
						new double(beginLine),
						new double(beginColumn),
						new double(endLine),
						new double(endColumn)
					})
				);
			}

			diagnostic.as<std::vector<IPC::Object>>().push_back(str);

			diagnostics.as<std::vector<IPC::Object>>().push_back(diagnostic);
		};

		IPC::Object Tokens = new std::vector<IPC::Object>;
		IPC::Object Hovers(new std::vector<IPC::Object>);

		RecursiveASTVisitor RecursiveASTVisitor;

		std::forward_list<clang::Decl*> ReferencedDeclarations;
		auto OnDeclarationReference = [&](clang::Decl* decl){
			for(auto i : ReferencedDeclarations) if(i == decl) return;
			ReferencedDeclarations.push_front(decl);

			std::string Hover_vscode_markdownWithHtmlAndIcons = [&]{
				std::stringstream out;

				out << "declared in " << compiler->getSourceManager()->getFilename(decl->getLocation()).str() << " on line " << compiler->getSourceManager()->getLineNumber(decl->getLocation()) << std::endl;				

				return out.str();
			}();

			Hovers.as<std::vector<IPC::Object>>().push_back(new std::vector<IPC::Object>({
				new std::string(getDeclIdentifier(decl)),
				new std::string(Hover_vscode_markdownWithHtmlAndIcons)
			}));
		};

		RecursiveASTVisitor.m_VisitDeclRefExpr = [&](clang::DeclRefExpr* DeclRefExpr) -> bool {
			if(not DeclRefExpr->getLocation().isValid()) return true;
			if(not compiler->getSourceManager()->isInMainFile(DeclRefExpr->getLocation())) return true;

			const clang::SourceLocation& location = DeclRefExpr->getLocation();

			clang::Decl* decl = DeclRefExpr->getDecl();

			OnDeclarationReference(decl);

			long long column = compiler->getSourceManager()->getColumnNumber(location);
			long long line = compiler->getSourceManager()->getLineNumber(location);
			long long length = DeclRefExpr->getNameInfo().getAsString().length();
			Tokens.as<std::vector<IPC::Object>>().push_back(new std::vector<IPC::Object>({
				new std::string(TranslateDeclToTokenType(decl)),
				new double(line),
				new double(column),
				new double(length),
				new std::string(getDeclIdentifier(decl))
			}));

			return true;
		};

		ASTConsumer astConsumer;
		astConsumer.m_HandleTranslationUnit = [&](clang::ASTContext& astContext){
			RecursiveASTVisitor.TraverseTranslationUnitDecl(astContext.getTranslationUnitDecl());
		};

		compiler->addASTConsumer(&astConsumer);

		compiler->InitializeSema();

		compiler->setMainFile(path, llvm::MemoryBuffer::getMemBufferCopy(fileBuffer->getBuffer().slice(PreambleBounds.Size,fileBuffer->getBuffer().size())));

		diagnosticConsumer.BeginSourceFile(*compiler->getLanguageOptions(),compiler->getPreprocessor());

		compiler->compile();

		delete compiler;

		{
			std::lock_guard lock(DocumentWorkerQueueMutex);
			DocumentWorkers.push_front(this);
			while(DocumentWorkers.size() > 10) {
				auto worker = DocumentWorkers.back();
				DocumentWorkers.pop_back();
				delete worker;
			}
			ActiveWorkers.erase(path);
		}

		{
			IPC::Object final(new std::vector<std::pair<std::string,IPC::Object>>({
				{"Document",new std::string(path)},
				{"Tokens",Tokens},
				{"Hovers",Hovers},
				{"Diagnostics",diagnostics}
			}));
			EditorIPC->call("document.refresh",final);
		}
	}

	void DocumentWorker::QueueUpdate(std::string content,long long version) {
		UpdateWaitConditionVariable.notify_all();
		{
			std::thread([this,content,version] mutable {
				std::mutex mtx;
				std::unique_lock lock(mtx);
				auto res = this->UpdateWaitConditionVariable.wait_for(lock,std::chrono::milliseconds(500));
				if(res == std::cv_status::timeout) {
					QueueTask([content,version,this]{
						this->update(content,version);
					});
				} else {
					std::cerr << "update cancelled: " << path << " v" << version << std::endl;
				}
			}).detach();
		}
	}
}
