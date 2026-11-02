import * as vscode from 'vscode';

export class CodeLensProvider implements vscode.CodeLensProvider {
	provideCodeLenses(document: vscode.TextDocument): vscode.CodeLens[] {
		return [];
	}
}