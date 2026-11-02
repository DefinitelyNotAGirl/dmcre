#pragma once

#include "IPC.h"

#include <functional>

#include <dmcre/compile>

#include <llvm/ExecutionEngine/Orc/Core.h>

#include <clang/Basic/Diagnostic.h>
#include <clang/AST/ASTContext.h>
#include <clang/Lex/Preprocessor.h>

namespace dmcred {
	extern dmcred::IPC* EditorIPC;
	void UpdateTextDocument(dmcred::IPC::Object data,std::function<void(dmcred::IPC::Object&)> reply);

	extern llvm::orc::JITDylib* compile_Dylib;
	extern dmcre::compile::ClangCompiler*(*getCompiler)(
		llvm::StringRef Filename,
		clang::DiagnosticConsumer* DiagnosticConsumer
	);
}