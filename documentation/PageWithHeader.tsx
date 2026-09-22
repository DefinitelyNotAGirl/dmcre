"implementation";

import React from 'react';

export function PageHeaderExtraInfo(props: {children: any}) {
	return props.children
}

export function PageContent(props: {children: any}) {
	return props.children
}

export function PageWithHeader(props: {
	Icon: (props: {size: string,fill: string}) => React.JSX.Element
	Color: string
	Title: string
	VersionIntroduced?: string
	children: any
}) {
	const childrenArray = React.Children.toArray(props.children);

	const Icon = props.Icon;

	let ExtraInfo = undefined as unknown as React.ReactElement<unknown, string | React.JSXElementConstructor<any>>;
	let Content = undefined as unknown as React.ReactElement<unknown, string | React.JSXElementConstructor<any>>;

	childrenArray.forEach((child) => {
		if(!React.isValidElement(child)) return;

		if(child.type === PageHeaderExtraInfo) {
			ExtraInfo = child;
		}
		else if(child.type === PageContent) {
			Content = child;
		}
	});

	return (
		<div
			style={{
				display: 'grid',
				width: '100%'
			}}
		>
			<div
				style={{
					display: 'flex',
					flexDirection: 'row',
					alignItems: 'start',
					gap: '32px',
					padding: '32px',
					gridArea: '1/1',
					zIndex: '2',
					height: 'fit-content',
					background: `hsla(214, 5%, 5%, 100%)`,
					boxShadow: `0px 18px 10px -10px ${props.Color}`
				}}
			>
				<div
					style={{
						display: 'flex',
						flexDirection: 'row',
						alignItems: 'center',
						alignSelf: 'start',
						gap: '32px'
					}}
				>
					<Icon fill={props.Color} size='96' />
					<div
						style={{
							color: 'white',
							fontSize: '48px'
						}}
						children={props.Title}
					/>
				</div>
				<div
					style={{
						display: 'flex',
						flexDirection: 'column',
						alignItems: 'start',
						alignSelf: 'start',
						marginLeft: 'auto',
						gap: '24px'
					}}
				>
					{props.VersionIntroduced && <div
						style={{
							color: 'white',
							fontSize: '16px'
						}}
					
						children={`available as of ${props.VersionIntroduced}`}
					/>}
					{ExtraInfo}
				</div>
			</div>
			<div
				style={{
					display: 'flex',
					flexDirection: 'column',
					alignItems: 'start',
					alignSelf: 'start',
					gap: '32px',
					width: '100%',
					paddingLeft: '64px',
					paddingRight: '64px',
					paddingBottom: '64px',
					paddingTop: '224px',
					gridArea: '1/1',
					zIndex: '1',
					maxHeight: '100%',
					overflow: 'auto'
				}}
			>
				{Content}
			</div>
		</div>
	)
}
