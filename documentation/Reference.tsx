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

type ReferenceProps = (
	{
		Article: string
	}
	|
	{
		QualifiedName: string,
		Language: 'C++'
	}
	|
	{
		Key: string
	}
)

export function Reference(props: ReferenceProps) {
	let page = undefined;
	if((props as any).Article !== undefined) {
		const target = (props as any).Article as string;
		page = Object.entries(Pages).find(([key,value]) => (value as any).title == target)?.[1];
	}
	else if((props as any).QualifiedName !== undefined) {
		const QualifiedName = (props as any).QualifiedName as string;
		const Language = (props as any).Language as string;
		page = Object.entries(Pages).find(([key,value]) => (((value as any).QualifiedName == QualifiedName) && ((value as any).Language == Language)))?.[1];
	}
	else if((props as any).Key !== undefined) {
		const Key = (props as any).Key as string;
		page = Object.entries(Pages).find(([key,value]) => (key == Key))?.[1];
	}

	if(page === undefined) {
		return (
			<div 
				style={{
					color: 'red'
				}}

				children={'bad reference'}
			/>
		)
	}
	
	if(page.Type == 'CXXRecord') {
		if(page.TagTypeKind == 'Class') {
			if(page.isAbstract) {
				return (
					<Button
						backgroundColor={`hsla(0,0%,50%,25%)`}
						borderRadius={8}
						
						onClick={() => {
							NavigateToPage(page.key);
						}}
					>
						<InterfaceIcon size='20' fill={Theme.code.Interface.color} />
						<div
							style={{
								color: 'white',
								background: 'none',
								outline: 'none',
								border: 'none',
								fontSize: '14px'
							}}
						
							children={page.QualifiedName}
						/>
					</Button>
				)
			} else {
				return (
					<Button
						backgroundColor={`hsla(0,0%,50%,25%)`}
						borderRadius={8}

						onClick={() => {
							NavigateToPage(page.key);
						}}
					>
						<ClassIcon size='20' fill={Theme.code.Class.color} />
						<div
							style={{
								color: 'white',
								background: 'none',
								outline: 'none',
								border: 'none',
								fontSize: '14px'
							}}
						
							children={page.QualifiedName}
						/>
					</Button>
				)
			}
		}
	}
	else if(page.Type == 'Namespace') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<NamespaceIcon size='20' fill={Theme.code.Namespace.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'Function' || page.Type == 'CXXMethod' || page.Type == 'CXXConstructor' || page.Type == 'CXXDestructor') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<MethodIcon size='20' fill={Theme.code.Function.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'Enum') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<EnumIcon size='20' fill={Theme.code.Enum.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'Var') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<VariableIcon size='20' fill={Theme.code.Variable.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'Field') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<FieldIcon size='20' fill={Theme.code.Field.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'EnumConstant') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<EnumMemberIcon size='20' fill={Theme.code.EnumMember.color} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.QualifiedName}
				/>
			</Button>
		)
	}
	else if(page.Type == 'Article') {
		return (
			<Button
				backgroundColor={`hsla(0,0%,50%,25%)`}
				borderRadius={8}

				onClick={() => {
					NavigateToPage(page.key);
				}}
			>
				<LightbulbIcon size='20' fill={`hsla(150, 82%, 66%,100%)`} />
				<div
					style={{
						color: 'white',
						background: 'none',
						outline: 'none',
						border: 'none',
						fontSize: '14px'
					}}
				
					children={page.title}
				/>
			</Button>
		)
	}
	
	return (
		<div children={'reference target type not implemented'} />
	);
}
