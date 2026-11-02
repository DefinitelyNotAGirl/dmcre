"implementation";

import React from 'react';

import { NavigateToPage } from './nav';
import { Theme } from './theme';

import { icon as ClassIcon } from './codicon/symbol-class'
import { icon as MethodIcon } from './codicon/symbol-method'
import { icon as NamespaceIcon } from './codicon/symbol-namespace'
import { icon as EnumIcon } from './codicon/symbol-enum'
import { icon as EnumMemberIcon } from './codicon/symbol-enum-member'
import { icon as VariableIcon } from './codicon/symbol-variable'
import { icon as FieldIcon } from './codicon/symbol-field'
import { icon as InterfaceIcon } from './codicon/symbol-interface'
import { icon as MiscIcon } from './codicon/symbol-misc'
import { icon as LightbulbIcon } from './codicon/lightbulb'

import { icon as ChevronDown } from './codicon/chevron-down'
import { icon as ChevronRight } from './codicon/chevron-right'

function PageLabel(props: {page: Page}) {
	let Icon = MiscIcon;
	let name = props.page.Type as string;
	let iconFill = 'white';

	if(props.page.Type == 'CXXRecord') {
		if(props.page.TagTypeKind == 'Class') {
			if(props.page.isAbstract) {
				Icon = InterfaceIcon;
				iconFill = Theme.code.Interface.color;
			} else {
				Icon = ClassIcon;
				iconFill = Theme.code['Class'].color;
			}
		}
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Namespace') {
		Icon = NamespaceIcon;
		iconFill = Theme.code['Namespace'].color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Function' || props.page.Type == 'CXXMethod' || props.page.Type == 'CXXConstructor' || props.page.Type == 'CXXDestructor') {
		Icon = MethodIcon;
		iconFill = Theme.code.Function.color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Enum') {
		Icon = EnumIcon;
		iconFill = Theme.code.Enum.color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Var') {
		Icon = VariableIcon;
		iconFill = Theme.code.Variable.color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Field') {
		Icon = FieldIcon;
		iconFill = Theme.code.Field.color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'EnumConstant') {
		Icon = EnumMemberIcon;
		iconFill = Theme.code.EnumMember.color;
		name = props.page.UnqualifiedName;
	}
	else if(props.page.Type == 'Article') {
		Icon = LightbulbIcon;
		iconFill = `hsla(150, 82%, 66%,100%)`;
		name = props.page.title;
	}
	else {
		if((props.page as any).UnqualifiedName !== undefined) {
			name = (props.page as any).UnqualifiedName;
		}
	}

	return (
		<>
			<Icon size='20' fill={iconFill} />
			<div
				style={{
					color: 'white',
					background: 'none',
					outline: 'none',
					border: 'none',
					fontSize: '14px'
				}}

				children={name}
			/>
		</>
	);
}

function TreeItem(props: {
	page: Page
}) {
	const [expanded,setExpanded] = React.useState(false);
	
	return (
		<div>
			<div
				style={{
					display: 'flex',
					flexDirection: 'row',
					alignItems: 'center',
					gap: '0px',
					paddingLeft: (props.page.children.length > 0) ? '0px' : '32px'
				}}
			>
				{(props.page.children.length > 0) &&
					<button
						onClick={() => {
							setExpanded(!expanded);
						}}

						style={{
							cursor: 'pointer',
							display: 'flex',
							flexDirection: 'row',
							alignItems: 'center',
							background: 'none',
							outline: 'none',
							border: 'none',
							height: '32px',
							gap: '8px'
						}}

						children={expanded ? <ChevronDown size='20' fill='white'/> : <ChevronRight size='20' fill='white'/>}
					/>
				}
				<button
					style={{
						cursor: 'pointer',
						display: 'flex',
						flexDirection: 'row',
						alignItems: 'center',
						background: 'none',
						outline: 'none',
						border: 'none',
						height: '32px',
						gap: '8px',
					}}

					onClick={() => {
						NavigateToPage(props.page.key);
					}}
				>
					<PageLabel page={props.page} />
				</button>
			</div>
			{expanded && 
				<div
					style={{
						display: 'flex',
						flexDirection: 'column',
						paddingLeft: '24px',
					}}
				>
				{
					props.page.children.map(page => (
						<TreeItem key={page.key} page={page} />
					))
				}
			</div>}
		</div>
	)
}

export function Sidebar() {
	return (
		<div
			style={{
				display: 'flex',
				flexDirection: 'column',
				width: '350px',
				borderBottom: '1px solid black',
				height: '100%',
				background: 'hsl(214, 14%, 12%)',
				alignItems: 'start',
				paddingTop: '24px',
				paddingBottom: '24px',
				paddingLeft: '16px',
				paddingRight: '16px',
				overflowX: 'hidden',
				overflowY: 'scroll',
				textWrap: 'nowrap',
			}}
		>
		{
			Object.entries(Pages).filter(([key,page]) => (page.depth == 2 && key.startsWith('articles/'))).map(([key,page]) => (
				<TreeItem key={key} page={page} />
			))
		}
		<TreeItem key={'C++'} page={
			{
				key: 'C++',
				label: 'C++',
				Type: 'Language',
				children: (
					Object.entries(Pages).filter(([key,page]) => (page.depth == 2 && key.startsWith('C++/'))).map(([key,page]) => page)
				),
				SourceFile: '',
				SourceLine: 0,
				status: 'stable',
				parent: undefined,
				depth: 0
			}
		} />
		</div>
	)
}
