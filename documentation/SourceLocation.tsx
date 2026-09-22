"implementation";

import React from 'react';

import { icon as GitHubIcon } from './codicon/github';

export function SourceLocation(props: {
	file: string,
	line: number
}) {
	return (
		<a
			style={{
				display: 'flex',
				flexDirection: 'row',
				gap: '8px',
				alignItems: 'center',
				textDecoration: 'none',
				color: 'white'
			}}
			target='_blank'
			href={`https://github.com/DefinitelyNotAGirl/dmcre/blob/release/${encodeURIComponent(props.file)}#L${props.line}`}
		>
			<GitHubIcon size={20} fill='white' />
			<div
				style={{
					display: 'flex',
					flexDirection: 'row',
					gap: '0px',
					alignItems: 'center',
				}}
			>
				<div
					children={props.file}
				/>
				<div
					children={':'}
				/>
				<div
					children={props.line.toString(10)}
				/>
			</div>
		</a>
	)
}