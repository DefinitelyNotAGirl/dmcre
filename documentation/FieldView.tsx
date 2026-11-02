"implemantation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as FieldIcon } from './codicon/symbol-field';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';

export function FieldView(props: {page: Page}) {
	if(props.page.Type != 'Field') {
		return (
			<div>
				error: page is not a field
			</div>
		)
	}

	let VersionIntroduced = '';
	let SourceFile = '';
	let SourceLine = 0;
		
	ResetSnapshotEval();
	snapshot_version = (version) => {
		if(VersionIntroduced == '') {
			VersionIntroduced = version;
		}
	};
	snapshot_SourceFile = (file) => {
		SourceFile = file;
	};
	snapshot_SourceLine = (line) => {
		SourceLine = line;
	};
	EvaluateSnapshots(props.page.key);

	return (
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={FieldIcon} Title={props.page.UnqualifiedName} Color={Theme.code.Field.color} >
			<PageHeaderExtraInfo>
				<div
					style={{
						color: 'white',
						fontSize: '16px'
					}}
				
					children={props.page.QualifiedName}
				/>
				<SourceLocation file={SourceFile} line={SourceLine} />
			</PageHeaderExtraInfo>
			<PageContent>
				<div
					style={{
						color: 'white',
						fontSize: '14px'
					}}
					children={props.page.FullDescription()}
				/>
			</PageContent>
		</PageWithHeader>
	);
}
