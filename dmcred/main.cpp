#include <iostream>
#include "IPC.h"
#include "core.h"

#include <llvm/Support/InitLLVM.h>
#include <llvm/Support/Program.h>
#include <llvm/Support/Signals.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_os_ostream.h>
#include <llvm/IRReader/IRReader.h>

#include <dmcre/load>

namespace dmcred {
	dmcred::IPC* EditorIPC = nullptr;

	llvm::orc::JITDylib* compile_Dylib;
	dmcre::compile::ClangCompiler*(*getCompiler)(
		llvm::StringRef Filename,
		clang::DiagnosticConsumer* DiagnosticConsumer
	);
}

int main(int argc,char** argv) {
	llvm::sys::AddSignalHandler(
		[](void*) {
			llvm::errs().flush();
		},
		nullptr
	);

	dmcre::load::initialize();
	dmcre::load::cxx::initialize();

	if(not std::filesystem::exists("dmcred_compile.ll")) {
		std::cerr << "loading dmcred_compile.cpp..." << std::endl;
		auto module = dmcre::load::cxx::ToModule(dmcre::load::Domain::WorkingDirectory, "dmcred_compile.cpp");
		std::error_code ec;
		llvm::raw_fd_ostream out("dmcred_compile.ll", ec);
		std::cout << ec.category().name() << ": " << ec.message() << std::endl;
		module->print(out, nullptr);
		delete module;
	}

	std::cerr << "loading dmcred_compile.ll..." << std::endl;

	{
		llvm::SMDiagnostic diagnostic;
		auto module = llvm::parseIRFile("dmcred_compile.ll", diagnostic, dmcre::load::llvmContext);
		std::vector<llvm::Module*> modules = {module.release()};
		dmcred::compile_Dylib = dmcre::load::llvm_IR::ToProcess(modules, "dmcred_compile");
	}

	std::cerr << "get _Z4initv" << std::endl;

	{
		auto symbol = dmcre::load::llvmJIT->lookup(
			*dmcred::compile_Dylib,
			"_Z4initv"
		);
		if(symbol) {
			reinterpret_cast<void(*)()>(symbol->getValue())();
		}
	}

	{
		auto symbol = dmcre::load::llvmJIT->lookup(
			*dmcred::compile_Dylib,
			"_Z11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerE"
		);
		if(not symbol) {
			std::cerr << "failed to load compile function" << std::endl;
			return 1;
		}

		dmcred::getCompiler = reinterpret_cast<decltype(dmcred::getCompiler)>(symbol->getValue());
	}

	dmcred::EditorIPC = new dmcred::IPC(0,1);

	dmcred::EditorIPC->RegisterFunction(
		"HelloWorld",[](dmcred::IPC::Object data,std::function<void(dmcred::IPC::Object&)> reply){
			dmcred::IPC::Object result(new std::string("Hello World reply from dmcred"));
			reply(result);
		}
	);

	dmcred::EditorIPC->RegisterFunction("UpdateTextDocument",dmcred::UpdateTextDocument);

	std::cerr << "starting IPC..." << std::endl;

	try {
		dmcred::EditorIPC->run();
	} catch(std::runtime_error& e) {
		std::cerr << "[IPC]: " << e.what() << std::endl;
	} catch(std::logic_error& e) {
		std::cerr << "[IPC]: " << e.what() << std::endl;
	} catch(std::exception& e) {
		std::cerr << "[IPC]: " << e.what() << std::endl;
	}

	return 0;
}