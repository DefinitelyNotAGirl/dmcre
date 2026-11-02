"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as VariableIcon } from './codicon/symbol-variable';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';
import { TypeView } from './Type';

export function VariableView(props: {page: Page}) {
	if(props.page.Type != 'Var') {
		return (
			<div>
				error: page is not a variable
			</div>
		)
	}

	let VersionIntroduced = '';
	let SourceFile = '';
	let SourceLine = 0;

	let dataType = undefined;
		
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
	snapshot_dataType = (type) => {
		dataType = type;
	}
	EvaluateSnapshots(props.page.key);

	return (
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={VariableIcon} Title={props.page.UnqualifiedName} Color={Theme.code.Variable.color} >
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
						display: 'flex',
						flexDirection: 'row',
						gap: '16px'
					}}
				>
					<TypeView descriptor={dataType} />
					<div children={props.page.UnqualifiedName} style={{color: Theme.code.Variable.color}} />
				</div>
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
