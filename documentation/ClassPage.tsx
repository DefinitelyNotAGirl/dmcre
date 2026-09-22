"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as ClassIcon } from './codicon/symbol-class';
import { icon as InterfaceIcon } from './codicon/symbol-interface';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';

export function ClassPage(props: {page: Page}) {
	if(props.page.Type != 'CXXRecord' && props.page.Type != 'ClassTemplate') {
		return (
			<div>
				error: page is not a class
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
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={props.page.isAbstract ? InterfaceIcon : ClassIcon} Title={props.page.UnqualifiedName} Color={props.page.isAbstract ? Theme.code.Interface.color : Theme.code.Class.color} >
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
	)
}
