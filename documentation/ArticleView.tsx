"implementation";

import React from 'react';
import { SourceLocation } from './SourceLocation';

import { icon as ArticleIcon } from './codicon/lightbulb';
import { ChildrenView } from './Children';
import { Theme } from './theme';
import { PageContent, PageHeaderExtraInfo, PageWithHeader } from './PageWithHeader';

export function ArticleView(props: {page: Page}) {
	if(props.page.Type != 'Article') {
		return (
			<div>
				error: page is not an article
			</div>
		)
	}

	return (
		<PageWithHeader Icon={ArticleIcon} Title={props.page.title} Color={`hsla(150, 82%, 66%,100%)`} >
			<PageContent>
				<div
					style={{
						color: 'white',
						fontSize: '14px',
						width: '100%'
					}}
					children={props.page.content()}
				/>
			</PageContent>
		</PageWithHeader>
	);
}
