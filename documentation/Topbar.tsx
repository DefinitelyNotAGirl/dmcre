"implementation";

import React from 'react';

export function TopBar() {
	return (
		<div
			style={{
				display: 'flex',
				flexDirection: 'row',
				width: '100%',
				borderBottom: '1px solid black',
				height: '48px',
				background: 'hsl(214, 14%, 15%)',
				alignItems: 'center',
				paddingLeft: '24px',
				paddingRight: '24px',
			}}
		>
			<input
				style={{
					display: 'flex',
					alignItems: 'center',
					border: '2px solid gray',
					borderRadius: '8px',
					height: '24px',
					background: 'none',
					fontSize: '13px'
				}}
				type='text'
			/>
		</div>
	)
}
