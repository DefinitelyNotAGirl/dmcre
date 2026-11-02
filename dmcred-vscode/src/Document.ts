import * as vscode from 'vscode';
import { DocumentSemanticTokensProvider } from './DocumentSemanticTokensProvider';

export class Document {
	public SemanticTokensBuilder = new vscode.SemanticTokensBuilder(DocumentSemanticTokensProvider.legend);
	public SemanticTokens = this.SemanticTokensBuilder.build();

	public Diagnostics: vscode.Diagnostic[] = [];
	public DiagnosticCollection = vscode.languages.createDiagnosticCollection('dmcred');

	public HoverRanges: Array<[vscode.Range,string]> = [];
	public HoverMap = new Map<string,vscode.Hover>();
};

const DocumentMap = new Map<string,Document>();

export function GetDocument(document: string): Document {
	if(!DocumentMap.has(document)) {
		DocumentMap.set(document,new Document());
	}

	return DocumentMap.get(document)!;
}
