import * as vscode from 'vscode';
import { GetDocument } from './Document';

export class DocumentSemanticTokensProvider implements vscode.DocumentSemanticTokensProvider {
	public onDidChangeSemanticTokensEmitter = new vscode.EventEmitter<void>();
	public onDidChangeSemanticTokens = this.onDidChangeSemanticTokensEmitter.event;

	public static tokenTypes = [
		'unknown',
		'namespace',
		'class',
		'struct',
		'enum',
		'interface',
		'typeParameter',
		'type',
		'parameter',
		'variable',
		'property',
		'enumMember',
		'function',
		'method',
		'macro',
		'label',
		'comment',
		'string',
		'keyword',
		'number',
		'operator',
		'event',
		'regexp'
	];
	public static legend = new vscode.SemanticTokensLegend(DocumentSemanticTokensProvider.tokenTypes);

	public provideDocumentSemanticTokens(document: vscode.TextDocument, token: vscode.CancellationToken): vscode.ProviderResult<vscode.SemanticTokens> {
		return GetDocument(document.uri.fsPath).SemanticTokens;
	}
}
