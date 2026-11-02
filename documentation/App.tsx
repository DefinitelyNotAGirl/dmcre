"implementation";

import React, { useEffect, useState } from 'react';
import { TopBar } from './Topbar';
import { Sidebar } from './Sidebar';
import { ClassPage } from './ClassPage';
import { NamespacePage } from './NamespacePage';
import { ArticleView } from './ArticleView';
import { EnumView } from './EnumView';
import { EnumMemberView } from './EnumMemberView';
import { FunctionView } from './FunctionView';
import { VariableView } from './VariableView';
import { FieldView } from './FieldView';

function RealizePage(page: Page) {
	if(page.Type == 'CXXRecord' || page.Type == 'ClassTemplate') {
		return <ClassPage page={page}/>
	}

	if(page.Type == 'Namespace') {
		return <NamespacePage page={page}/>
	}

	if(page.Type == 'Function' || page.Type == 'CXXMethod' || page.Type == 'CXXConstructor' || page.Type == 'CXXDestructor') {
		return <FunctionView page={page}/>
	}

	if(page.Type == 'Article') {
		return <ArticleView page={page}/>
	}

	if(page.Type == 'Enum') {
		return <EnumView page={page}/>
	}

	if(page.Type == 'EnumConstant') {
		return <EnumMemberView page={page}/>
	}

	if(page.Type == 'Var') {
		return <VariableView page={page}/>
	}

	if(page.Type == 'Field') {
		return <FieldView page={page}/>
	}

	return (
		<div>
			error realizing page of type {(page as Page).Type}
		</div>
	)
}

function CurrentPageContent() {
	const [page,setPage] = useState(window.location.pathname);

	useEffect(() => {
		window.addEventListener('popstate', (event) => {
			setPage(window.location.pathname);
		});

		window.addEventListener('navigate', (event) => {
			history.pushState({}, '', (event as any).detail.destination);
			setPage((event as any).detail.destination);
		});
	},[]);

	if(page == '/') {
		return RealizePage(Pages['articles/introduction']);
	}

	if(page.startsWith('/docs')) {
		const target = window.location.pathname.substring('/docs/'.length);
		const entry = (Object.entries(Pages) as [string,any][]).find(([key,data]) => {
			return key == target;
		});
		if(entry !== undefined) {
			return RealizePage(entry[1]);
		}
	}

	return (
		<div>
			no page content
		</div>
	)
}

export function App() {
	return (
		<div
			style={{
				display: 'flex',
				flexDirection: 'column',
				background: 'hsl(214, 14%, 10%)',
				width: '100vw',
				height: '100vh',
			}}
		>
			<TopBar/>
			<div
				style={{
					display: 'flex',
					flexDirection: 'row',
					width: '100%',
					height: 'calc(100% - 48px)',
				}}
			>
				<Sidebar/>
				<CurrentPageContent/>
			</div>
		</div>
	)
}
