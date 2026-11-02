import * as vscode from 'vscode';
import { GetDocument } from './Document';

export class HoverProvider implements vscode.HoverProvider {
	provideHover(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken): vscode.ProviderResult<vscode.Hover> {
		const doc = GetDocument(document.uri.fsPath);
		for(const [range,hoverId] of doc.HoverRanges) {
			if(range.contains(position)) {
				return doc.HoverMap.get(hoverId);
			}
		}

		return undefined;
	}
}
