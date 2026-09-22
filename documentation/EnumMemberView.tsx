"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as EnumMemberIcon } from './codicon/symbol-enum-member';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';

export function EnumMemberView(props: {page: Page}) {
	if(props.page.Type != 'EnumConstant') {
		return (
			<div>
				error: page is not an enum member
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
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={EnumMemberIcon} Title={props.page.UnqualifiedName} Color={Theme.code.EnumMember.color} >
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
