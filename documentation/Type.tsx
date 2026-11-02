"implementation";

import React from 'react';
import { Theme } from './theme';

export function TypeView(props: {descriptor: any}) {
	const elements = [] as Array<React.JSX.Element>;

	if(props.descriptor.parent != undefined) {
		elements.push(
			<>
				<TypeView descriptor={props.descriptor.parent} />
				<TextView children={'::'} />
			</>
		)
	}

	if(props.descriptor.kind == 'LValueReference' || props.descriptor.kind == 'RValueReference') {
		elements.push(
			<>
				<TypeView descriptor={props.descriptor.referencee} />
				<span children={'&'} style={{color: Theme.code.CxxReference.color}} />
			</>
		)
	}

	if(props.descriptor.name != undefined) {
		elements.push(
			<>
				<TextView children={props.descriptor.name} />
			</>
		)
	}

	if(props.descriptor.TemplateArgs != undefined) {
		elements.push(
			<>
				<TextView children={'<'} />
				{
					(props.descriptor.TemplateArgs as Array<any>).map((arg,index,array) => (
						<>
							<TypeView descriptor={arg} />
							{(index != array.length) && <TextView children={','} />}
						</>
					))
				}
				<TextView children={'>'} />
			</>
		)
	}

	return <TextView children={elements} />;
}
