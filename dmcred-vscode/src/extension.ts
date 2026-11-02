import * as vscode from 'vscode';
import * as dmcred from './dmcred';

import { DocumentSemanticTokensProvider } from './DocumentSemanticTokensProvider';
import { CodeLensProvider } from './CodeLensProvider';
import { HoverProvider } from './HoverProvider';
import { GetDocument } from './Document';

export function activate(context: vscode.ExtensionContext) {
	const selector: vscode.DocumentSelector = { language: 'cpp' };

	const documentSemanticTokensProvider = new DocumentSemanticTokensProvider();
	const codeLensProvider = new CodeLensProvider();
	const hoverProvider = new HoverProvider();

	dmcred.RegisterFunction('document.refresh',(data,reply) => {
		console.log(data);
		const document = GetDocument(data.Document);
		
		document.SemanticTokensBuilder = new vscode.SemanticTokensBuilder(DocumentSemanticTokensProvider.legend);
		for(const t of data.Tokens) {
			try {
				document.SemanticTokensBuilder.push(new vscode.Range(new vscode.Position(t[1]-1,t[2]-1),new vscode.Position(t[1]-1,t[2]+t[3]-1)),t[0]);
			} catch(e) {
				console.error(e);
			}
		}
		document.SemanticTokens = document.SemanticTokensBuilder.build();
		documentSemanticTokensProvider.onDidChangeSemanticTokensEmitter.fire();

		document.Diagnostics = [];
		for(const i of data.Diagnostics) {
			if(i[0].length === 0) {
				console.error('Ignoring diagnostic without a source range:',i[1]);
				continue;
			}

			document.Diagnostics.push(new vscode.Diagnostic(
				new vscode.Range(
					new vscode.Position(i[0][0][0] - 1,i[0][0][1] - 1),
					new vscode.Position(i[0][0][2] - 1,i[0][0][3] - 1)
				),
				i[1],
				vscode.DiagnosticSeverity.Error
			));
		}
		document.DiagnosticCollection.set(vscode.Uri.file(data.Document),document.Diagnostics);

		document.HoverRanges = [];
		for(const t of data.Tokens) {
			try {
				const range = new vscode.Range(new vscode.Position(t[1]-1,t[2]-1),new vscode.Position(t[1]-1,t[2]+t[3]-1));
				document.HoverRanges.push([range,t[4]]);
			} catch(e) {
				console.error(e);
			}
		}

		document.HoverMap.clear();
		for(const hover of data.Hovers) {
			document.HoverMap.set(hover[0],new vscode.Hover(hover[1]));
		}

		reply(true);
	});

	context.subscriptions.push(
		vscode.languages.registerDocumentSemanticTokensProvider(selector, documentSemanticTokensProvider, DocumentSemanticTokensProvider.legend),
		vscode.languages.registerCodeLensProvider(selector, codeLensProvider),
		vscode.languages.registerHoverProvider(selector, hoverProvider),
		vscode.workspace.onDidChangeTextDocument(async (event) => {
			if (event.document.languageId !== 'cpp') {
				return;
			}
			const result = await (dmcred.call('UpdateTextDocument',[
				event.document.uri.fsPath,
				event.document.getText(),
				event.document.version
			]).catch((e) => {
				console.error(e);
			}));
			console.log(result);
		}),
		vscode.commands.registerCommand('dmcred.shutdownLanguageServer', () => {
			dmcred.shutdown();
		}),
		vscode.commands.registerCommand('dmcred.restartLanguageServer',async () => {
			dmcred.restart();
			dmcred.run().catch((e) => {
				console.error(e);
			});
			const result = await dmcred.call('HelloWorld',[]).catch((e) => {
				console.log(e);
			});
			console.log(result);
		})
	);
}

export function deactivate() {
	dmcred.shutdown();
}
