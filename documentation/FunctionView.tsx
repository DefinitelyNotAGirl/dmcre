"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as MethodIcon } from './codicon/symbol-method';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';
import { TypeView } from './Type';

export function FunctionView(props: {page: Page}) {
	if(!(props.page.Type == 'Function' || props.page.Type == 'CXXMethod' || props.page.Type == 'CXXConstructor' || props.page.Type == 'CXXDestructor')) {
		return (
			<div>
				error: page is not a function
			</div>
		)
	}

	let VersionIntroduced = '';
	let SourceFile = '';
	let SourceLine = 0;
	let returnType = undefined;

	const parameters = [] as Array<[type: any,name: string]>
		
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
	snapshot_returnType = (type) => {
		returnType = type;
	};
	snapshot_parameter = (type,name) => {
		parameters.push([type,name]);
	};
	EvaluateSnapshots(props.page.key);

	return (
		<PageWithHeader VersionIntroduced={VersionIntroduced} Icon={MethodIcon} Title={props.page.UnqualifiedName} Color={Theme.code.Function.color} >
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
					<TypeView descriptor={returnType} />
					<div children={props.page.UnqualifiedName} style={{color: Theme.code.Function.color}} />
					<div children={'('} style={{color: Theme.code.MemberAccess.color}} />
					{
						parameters.map((parameter,index) => (
							<>
								<TypeView descriptor={parameter[0]} />
								<div children={parameter[1]} style={{color: Theme.code.Parameter.color}} />
								{index != (parameters.length-1) && <div children={','} style={{color: Theme.code.MemberAccess.color}} />}
							</>
						))
					}
					<div children={')'} style={{color: Theme.code.MemberAccess.color}} />
				</div>
				<VStackView
					gap={32}

					children={props.page.FullDescription()}
				/>
			</PageContent>
		</PageWithHeader>
	);
}
