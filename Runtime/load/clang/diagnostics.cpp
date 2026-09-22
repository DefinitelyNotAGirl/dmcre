#include <dmcre/load>

namespace dmcre::load {
	class DiagnosticConsumer : public clang::DiagnosticConsumer {
		virtual void HandleDiagnostic(clang::DiagnosticsEngine::Level DiagLevel, const clang::Diagnostic& Info) override {
			if(DiagLevel == clang::DiagnosticsEngine::Level::Error) {
				std::cout << "ERROR" << std::endl;
			}
			else if(DiagLevel == clang::DiagnosticsEngine::Level::Fatal) {
				std::cout << "FATAL ERROR" << std::endl;
			}
			//Info.getLocation();
		}

		void BeginSourceFile(const clang::LangOptions&,const clang::Preprocessor*) override {
		}

        void EndSourceFile() override {
		}
	};

	clang::DiagnosticOptions clangDiagnosticsOptions;

	void InitializeClangDiagnosticsEngine() {
		clangDiagnosticConsumer = new DiagnosticConsumer();
		clangDiagnosticsEngine = new clang::DiagnosticsEngine(clang::DiagnosticIDs::create(),clangDiagnosticsOptions,clangDiagnosticConsumer,false);
	}
}