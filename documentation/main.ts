"implementation";

import React from 'react';
import { createRoot } from "react-dom/client";

import { App } from './App';

document.body.style.background = 'hsl(214, 14%, 10%)';
document.body.style.padding = '0px';
document.body.style.margin = '0px';

document.body.innerHTML = "building tree...";

Object.entries(Pages).forEach(([key,page]) => {
	page.depth = key.split('/').length;
	page.children = [] as Array<Page>;
})

Object.entries(Pages).forEach(([key,page]) => {
	Object.entries(Pages).forEach(([_key,_page]) => {
		if(_key.startsWith(key) && (_page.depth == (page.depth + 1))) {
			page.children.push(_page);
		}
	})
})

document.body.innerHTML = "evaluating snapshots...";

Object.entries(Pages).forEach(([key,page]) => {
	ResetSnapshotEval();
	snapshot_TagTypeKind = (TagTypeKind) => {
		(page as any).TagTypeKind = TagTypeKind;
	};
	snapshot_isAbstract = (isAbstract) => {
		(page as any).isAbstract = isAbstract;
	};
	snapshot_UnqualifiedName = (name) => {
		(page as any).UnqualifiedName = name;
	};
	snapshot_QualifiedName = (name) => {
		(page as any).QualifiedName = name;
	};
	snapshot_Language = (language) => {
		(page as any).Language = language;
	};
	EvaluateSnapshots(key);
})

const root = createRoot(document.body);

root.render(App()) 
