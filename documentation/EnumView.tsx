"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as EnumIcon } from './codicon/symbol-enum';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';

export function EnumView(props: {page: Page}) {
	if(props.page.Type != 'Enum') {
		return (
			<div>
				error: page is not an enum
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
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={EnumIcon} Title={props.page.UnqualifiedName} Color={Theme.code.Enum.color} >
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
				<ChildrenView page={props.page} />
			</PageContent>
		</PageWithHeader>
	);
}
