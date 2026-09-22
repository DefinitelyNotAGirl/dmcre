"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { Theme } from './theme';

import { icon as NamespaceIcon } from './codicon/symbol-namespace';
import { icon as ClassIcon } from './codicon/symbol-class';
import { icon as MethodIcon } from './codicon/symbol-method';
import { icon as MiscIcon } from './codicon/symbol-misc';

export function ChildView(props: {page: Page}) {
	let Icon = MiscIcon;
	let name = props.page.Type as string;
	let iconFill = 'white';

	if(props.page.Type == 'CXXRecord') {
		if(props.page.TagTypeKind == 'Class') {
			Icon = ClassIcon;
			iconFill = Theme.code['Class'].color;
		}
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Namespace') {
		Icon = NamespaceIcon;
		iconFill = Theme.code['Namespace'].color;
		name = props.page.UnqualifiedName;
	}
	else {
		if((props.page as any).UnqualifiedName !== undefined) {
			name = (props.page as any).UnqualifiedName;
		}
	}

	return (
		<div
			style={{
				display: 'flex',
				flexDirection: 'column',
				gap: '16px',
				borderRadius: '16px',
				border: '1px solid gray',
				background: 'hsla(214, 13%, 20%, 100%)'
			}}
		>
			<div
				style={{
					display: 'flex',
					flexDirection: 'row',
					alignItems: 'center',
					gap: '8px',
					borderRadius: '0px',
					borderBottom: '1px solid black',
					paddingTop: '8px',
					paddingBottom: '8px',
					paddingLeft: '16px',
					paddingRight: '16px',
				}}
			>
				<Icon size='20' fill={iconFill} />
				<div
					children={name}
				/>
			</div>
			<div
				style={{
					display: 'flex',
					flexDirection: 'column',
					gap: '16px',
					borderRadius: '0px',
					minHeight: '64px',
					padding: '16px'
				}}
			>
				{(props.page as any).ShortDescription()}
			</div>
		</div>
	)
}

export function ChildrenView(props: {page: Page}) {
	return (
		<div
			style={{
				display: 'flex',
				flexDirection: 'column',
				gap: '16px',
				width: '100%'
			}}
		>
		{
			props.page.children.map((child) => <ChildView page={child} />)
		}
		</div>
	)	
}
