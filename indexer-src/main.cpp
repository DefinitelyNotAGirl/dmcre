#include <dmcre/BufferStream>
#include <dmcre/console>
#include <dmcre/serial>

#include <clang/AST/ASTConsumer.h>
#include <clang/AST/RecursiveASTVisitor.h>
#include <clang/Frontend/FrontendActions.h>
#include <clang/Tooling/Tooling.h>
#include <clang/AST/Mangle.h>

#include <filesystem>
#include <iostream>
#include <memory>
#include <fstream>

void ProcessDecl(clang::Decl* decl);

clang::SourceManager* sourceManager;

class Consumer : public clang::ASTConsumer {
public:
	void HandleTranslationUnit(clang::ASTContext &context) override {
		sourceManager = &context.getSourceManager();
		ProcessDecl(context.getTranslationUnitDecl());
		sourceManager = nullptr;
	}
};

class Action : public clang::ASTFrontendAction {
public:
	std::unique_ptr<clang::ASTConsumer>

	CreateASTConsumer(clang::CompilerInstance&,llvm::StringRef) override {
		return std::make_unique<Consumer>();
	}
};

void processFile(std::string& source,std::string path) {
	dmcre::console.info(path);
	clang::tooling::runToolOnCodeWithArgs(
        std::make_unique<Action>(),
        source,
		{
			"-std=c++23",
			"-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk/usr/include/c++/v1",
			"-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/17/include",
			"-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk/usr/include",
			"-isystem/Users/lilith/dmcre_2026091000/Headers/C++",
			"-DDMCRE_MODULE=\"DMCRE Runtime\"",
			"-DDMCRE_BUILDING_RUNTIME",
			"-Wno-system-headers",
			"-Wno-pragma-once-outside-header",
			"-F/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.sdk/System/Library/Frameworks",
			"-x","c++"
		},
        path
    );
}

std::string version;

int main(int argc,char** argv) {
	if(false) {
		std::string source = "#include <stddef.h>\nsize_t n = 0;";
		processFile(source,"test");
		return 0;
	}

	version = argv[1];

	std::filesystem::recursive_directory_iterator directory_iterator("Headers/C++");
	for(auto& i : directory_iterator) {
		if(i.is_regular_file()) {
			std::ifstream stream(i.path());
			std::string str;
			stream.seekg(0,std::ios_base::end);
			str.resize(stream.tellg());
			stream.seekg(0,std::ios_base::beg);
			stream.read(str.data(), str.size());
			stream.close();
			processFile(str,i.path());

			//return 0;
		}
	}

    return 0;
}

bool isDmcrePublicApi(clang::Decl* decl) {
	clang::SourceLocation loc = decl->getLocation();
	if(loc.isValid()) {
		return sourceManager->isInMainFile(loc);
	}
	return false;
}

std::list<clang::NamedDecl*> parentDeclarations;

std::string getMangledName(clang::FunctionDecl* function) {
    auto mangleContext = function->getASTContext().createMangleContext();

    std::string result;
    llvm::raw_string_ostream stream(result);

    if(auto* constructor = llvm::dyn_cast<clang::CXXConstructorDecl>(function)) {
        mangleContext->mangleName(
            clang::GlobalDecl(constructor, clang::Ctor_Complete),
            stream
        );
    }
    else if(auto* destructor = llvm::dyn_cast<clang::CXXDestructorDecl>(function)) {
        mangleContext->mangleName(
            clang::GlobalDecl(destructor, clang::Dtor_Complete),
            stream
        );
    }
    else {
        mangleContext->mangleName(function, stream);
    }
    stream.flush();

    return result;
}

std::string getBasenameForDeclaration(clang::NamedDecl* decl) {
	std::stringstream ss;

	if(llvm::isa<clang::FunctionDecl>(decl)) {
		auto functionDecl = llvm::cast<clang::FunctionDecl>(decl);
		ss << getMangledName(functionDecl);
	} else {
		ss << decl->getDeclName().getAsString();
	}

	return ss.str();
}

std::filesystem::path getTsxDocumentationPathForDeclaration(clang::NamedDecl* decl) {
	std::filesystem::path path;
	path.append("documentation");
	path.append("C++");
	for(auto i : parentDeclarations) {
		path.append(getBasenameForDeclaration(i));
	}
	path.append(getBasenameForDeclaration(decl));
	path.replace_extension(".tsx");
	return path;
}

std::filesystem::path getTsSnapshotPathForDeclaration(clang::NamedDecl* decl) {
	std::filesystem::path path;
	path.append("snapshot");
	path.append("C++");
	for(auto i : parentDeclarations) {
		path.append(getBasenameForDeclaration(i));
	}
	path.append(getBasenameForDeclaration(decl));
	path.append(version+".ts");
	return path;
}

std::string getTagTypeKindName(clang::TagTypeKind type) {
	if(type == clang::TagTypeKind::Class) {
		return "Class";
	}
	else if(type == clang::TagTypeKind::Union) {
		return "Union";
	}
	else if(type == clang::TagTypeKind::Enum) {
		return "Enum";
	}
	else if(type == clang::TagTypeKind::Interface) {
		return "Interface";
	}
	else if(type == clang::TagTypeKind::Struct) {
		return "Struct";
	}
	throw std::logic_error("bad tag type kind");
}

SerialObject getDescriptor(const clang::Decl* decl);

SerialObject getDescriptor(const clang::Type* type) {
	SerialObject object(SerialObject::Type::Object);

	object.properties().push_back({"kind",type->getTypeClassName()});

	if(type->isBuiltinType()) {
		const clang::PrintingPolicy policy({});

		auto builtinType = type->getAs<clang::BuiltinType>();
		object.properties().push_back({"name",builtinType->getNameAsCString(policy)});
	}
	else if(type->isLValueReferenceType()) {
		auto lvalueReferenceType = type->getAs<clang::LValueReferenceType>();
		object.properties().push_back({"referencee",getDescriptor(lvalueReferenceType->getPointeeType().getTypePtr())});
	}
	else if(type->isRValueReferenceType()) {
		auto rvalueReferenceType = type->getAs<clang::RValueReferenceType>();
		object.properties().push_back({"referencee",getDescriptor(rvalueReferenceType->getPointeeType().getTypePtr())});
	}
	else if(llvm::isa<clang::TypedefType>(type)) {
		auto typedefType = llvm::cast<clang::TypedefType>(type);
		return getDescriptor(typedefType->getDecl());
	}
	else if(type->isClassType()) {
		return getDescriptor(type->getAsTagDecl());
	}
	else if(type->isEnumeralType()) {
		return getDescriptor(type->getAsTagDecl());
	}

	return object;
}

SerialObject getDescriptor(const clang::Decl* decl) {
	SerialObject object(SerialObject::Type::Object);

	object.properties().push_back({"kind",decl->getDeclKindName()});

	auto namedDecl = llvm::dyn_cast<clang::NamedDecl>(decl);

	if(namedDecl != nullptr) {
		object.properties().push_back({"name",namedDecl->getDeclName().getAsString().c_str()});
	}

	auto typedefNameDecl = llvm::dyn_cast<clang::TypedefNameDecl>(decl);
	if(typedefNameDecl != nullptr) {
		object.properties().push_back({"underlyingType",getDescriptor(typedefNameDecl->getUnderlyingType().getTypePtr())});
	}

	auto classTemplateSpecializationDecl = llvm::dyn_cast<clang::ClassTemplateSpecializationDecl>(decl);
	if(classTemplateSpecializationDecl != nullptr) {
		auto& templateArgs = classTemplateSpecializationDecl->getTemplateArgs();
		SerialObject templateArgsSerial(SerialObject::Type::List);
		for(auto& arg : templateArgs.asArray()) {
			if(arg.getKind() == clang::TemplateArgument::ArgKind::Type) {
				templateArgsSerial.items().push_back(getDescriptor(arg.getAsType().getTypePtr()));
			}
		}
		object.properties().push_back({"TemplateArgs",templateArgsSerial});
	}

	auto declContext = decl->getDeclContext();
	if(declContext != nullptr) {
		auto parent = declContext->getParent();
		if(parent != nullptr) {
			if(llvm::isa<clang::NamedDecl>(parent)) {
				bool isSpecialParent = false;

				auto namedParent = llvm::cast<clang::NamedDecl>(parent);
				if(namedParent->getDeclName().getAsString() == "std") {
					if(namedDecl->getDeclName().getAsString() == "__1") {
						isSpecialParent = true;
						object.GetProperty("name") = "std";
					}
				}

				if(not isSpecialParent) {
					object.properties().push_back({"parent",getDescriptor(namedParent)});
				}
			}
		}
	}

	return object;
}

std::string SerialToJson(SerialObject serial) {
	dmcre::DynamicBuffer buffer;
	dmcre::BufferBackedOStream ostream(buffer);
	JsonWriterUTF8(ostream).write(serial);
	return std::string((char*)dmcre::String::decode(buffer,dmcre::String::Format::ASCII).encode(dmcre::String::Format::CSTRING).raw());
}

void ProcessDecl(clang::Decl* decl) {
	if(decl->getKind() == clang::Decl::Kind::TranslationUnit) {
		auto translationUnitDecl = llvm::cast<clang::TranslationUnitDecl>(decl);
		for(auto i : translationUnitDecl->decls()) {
			ProcessDecl(i);
		}
		return;
	}

	if(not isDmcrePublicApi(decl)) {
		return;
	}

	if(llvm::dyn_cast<clang::NamedDecl>(decl) == nullptr) {
		//std::cout << "[ ] " << decl->getDeclKindName()  << std::endl;
		return;
	}
	//std::cout << "[X] " << decl->getDeclKindName()  << std::endl;

	clang::NamedDecl* namedDecl = llvm::cast<clang::NamedDecl>(decl);

	auto tsSnapshotPath = getTsSnapshotPathForDeclaration(namedDecl);
	if(not std::filesystem::exists(tsSnapshotPath.parent_path())) {
		std::filesystem::create_directories(tsSnapshotPath.parent_path());
	}
	std::ofstream snapshot;
	snapshot.open(tsSnapshotPath);

	auto tsxPath = getTsxDocumentationPathForDeclaration(namedDecl);
	std::ofstream tsx;
	if(not std::filesystem::exists(tsxPath.parent_path())) {
		std::filesystem::create_directories(tsxPath.parent_path());
	}

	if(not std::filesystem::exists(tsxPath)) {
		tsx.open(tsxPath);
	} else {
		tsx.open("/dev/null");
	}

	snapshot << "snapshot_Language(\"C++\");";

	tsx << "\"page\";\n";
	tsx << "\n";

	tsx << "const Type = \"" << decl->getDeclKindName() << "\";\n";
	tsx << "\n";

	auto loc = decl->getLocation();
	if(loc.isValid()) {
		auto fileLoc = sourceManager->getPresumedLoc(loc);
		snapshot << "snapshot_SourceFile(\"" << fileLoc.getFilename() << "\");\n";
		snapshot << "snapshot_SourceLine(" << fileLoc.getLine() << ");\n";
	}

	snapshot << "snapshot_QualifiedName(\"" << namedDecl->getQualifiedNameAsString() << "\");\n";
	snapshot << "snapshot_UnqualifiedName(\"" << namedDecl->getDeclName().getAsString() << "\");\n";

	auto classTemplateDecl = llvm::dyn_cast<clang::ClassTemplateDecl>(decl);
	if(classTemplateDecl != nullptr) {
		auto templateParameters = classTemplateDecl->getTemplateParameters();
		for(auto parameter : *templateParameters) {
			snapshot << "snapshot_templateParameter(\"" << parameter->getDeclKindName() << "\",\"" << parameter->getNameAsString() << "\")\n";

			tsx << "function templateParameter_" << parameter->getDeclName().getAsString() << "() {\n";
			tsx << "\treturn (<div>" << parameter->getDeclName().getAsString() << "</div>);\n";
			tsx << "}\n\n";
		}
	}

	if(llvm::isa<clang::FunctionDecl>(decl)) {
		auto functionDecl = llvm::cast<clang::FunctionDecl>(decl);
		auto returnType = functionDecl->getDeclaredReturnType().getTypePtr();
		if(returnType != nullptr) {
			snapshot << "snapshot_returnType(" << SerialToJson(getDescriptor(returnType)) << ");\n";
		}
		tsx << "\n";

		for(auto parameter : functionDecl->parameters()) {
			snapshot << "snapshot_parameter(" << SerialToJson(getDescriptor(parameter->getType().getTypePtr())) << ",\"" << parameter->getNameAsString() << "\")\n";
		}
	}

	if(llvm::isa<clang::ValueDecl>(decl)) {
		auto valueDecl = llvm::cast<clang::ValueDecl>(decl);
		snapshot << "snapshot_dataType(" << SerialToJson(getDescriptor(valueDecl->getType().getTypePtr())) << ");\n";
	}

	if(decl->getKind() == clang::Decl::Kind::CXXRecord) {
		auto cxxRecordDecl = llvm::cast<clang::CXXRecordDecl>(decl);
		snapshot << "snapshot_TagTypeKind(\"" << getTagTypeKindName(cxxRecordDecl->getTagKind()) << "\");\n";
		if(cxxRecordDecl->isThisDeclarationADefinition()) {

			if(cxxRecordDecl->getTagKind() == clang::TagTypeKind::Class) {
				snapshot << "snapshot_isAbstract(" << (cxxRecordDecl->isAbstract() ? "true" : "false") << ");\n";
			}
		}
	}

	if(decl->getKind() == clang::Decl::Kind::EnumConstant) {
		auto enumConstantDecl = llvm::cast<clang::EnumConstantDecl>(decl);
		snapshot << "snapshot_EnumConstant_value(" << enumConstantDecl->getInitVal().getExtValue() << ")";
	}

	for(auto attr : decl->attrs()) {
		if(auto annotation = llvm::dyn_cast<clang::AnnotateAttr>(attr)) {
			snapshot << "snapshot_attribute(\"" << annotation->getAnnotation().str() << "\")";
		} else {
			snapshot << "snapshot_attribute(\"" << attr->getSpelling() << "\")";
		}
	}

	tsx << "function ShortDescription() {\n";
	tsx << "\treturn (<div>" << namedDecl->getQualifiedNameAsString() << "</div>);\n";
	tsx << "}\n";
	tsx << "\n";

	tsx << "function FullDescription() {\n";
	tsx << "\treturn (<div>" << namedDecl->getQualifiedNameAsString() << "</div>);\n";
	tsx << "}\n";
	tsx << "\n";

	if(llvm::isa<clang::FunctionDecl>(decl)) {
		auto functionDecl = llvm::cast<clang::FunctionDecl>(decl);

		for(auto parameter : functionDecl->parameters()) {
			tsx << "function parameter_" << parameter->getDeclName().getAsString() << "() {\n";
			tsx << "\treturn (<div>" << parameter->getDeclName().getAsString() << "</div>);\n";
			tsx << "}\n\n";
		}
	}

	tsx.close();
	snapshot.close();

	parentDeclarations.push_back(namedDecl);
	if(decl->getKind() == clang::Decl::Kind::CXXRecord) {
		auto cxxRecordDecl = llvm::cast<clang::CXXRecordDecl>(decl);
		for(auto i : cxxRecordDecl->decls()) {
			ProcessDecl(i);
		}
	} else if(decl->getKind() == clang::Decl::Kind::Namespace) {
		auto namespaceDecl = llvm::cast<clang::NamespaceDecl>(decl);
		for(auto i : namespaceDecl->decls()) {
			ProcessDecl(i);
		}
	} else if(decl->getKind() == clang::Decl::Kind::Enum) {
		auto enumDecl = llvm::cast<clang::EnumDecl>(decl);
		for(auto i : enumDecl->decls()) {
			ProcessDecl(i);
		}
	}
	parentDeclarations.pop_back();
}
