declare type TextViewProperties = (
	{
		children: any
	}
)

declare type BorderProperties = (
	{
		borderWidth?: number
		borderColor?: string
		borderStyle?: "dashed" | "dotted" | "double" | "groove" | "hidden" | "inset" | "none" | "outset" | "ridge" | "solid",
		borderRadius?: number
	}
)

declare type BackgroundProperties = (
	{
		backgroundColor?: string
	}
)

function TransformBorderProperties(props: BorderProperties): React.CSSProperties {
	return {
		borderWidth: `${props.borderWidth}px`,
		borderColor: props.borderColor,
		borderStyle: props.borderStyle,
		borderRadius: `${props.borderRadius}px`
	}
}

function TransformBackgroundProperties(props: BackgroundProperties): React.CSSProperties {
	return {
		backgroundColor: props.backgroundColor
	}
}

declare type StackProperties = (
	{
		gap: number
		children: any
	}
	&
	BorderProperties
	&
	BackgroundProperties
)

function TransformStackProperties(props: StackProperties): React.CSSProperties {
	return Object.assign({},
		{
			gap: `${props.gap}px`
		},
		TransformBackgroundProperties(props),
		TransformBorderProperties(props),
	) as any;
}

declare type VStackProperties = (
	{
	}
	&
	StackProperties
)

declare type HStackProperties = (
	{
	}
	&
	StackProperties
)

declare type ParagraphProperties = (
	{
		children: any
	}
)

function TextView(props: TextViewProperties) {
	return (
		<div
			style={
				{
					display: 'inline',
				}
			}
			
			children={props.children}
		/>
	)
}

function ParagraphView(props: ParagraphProperties) {
	return (
		<div
			style={
				{
					display: 'block',
				}
			}
			
			children={props.children}
		/>
	)
}

function VStackView(props: VStackProperties) {
	return (
		<div
			style={
				Object.assign({},
					{
						display: 'flex',
						flexDirection: 'column',
						width: '100%'
					},
					TransformStackProperties(props)
				) as any
			}

			children={props.children}
		/>
	)
}

function HStackView(props: HStackProperties) {
	return (
		<div
			style={
				Object.assign({},
					{
						display: 'flex',
						flexDirection: 'row'
					},
					TransformStackProperties(props)
				) as any
			}

			children={props.children}
		/>
	)
}

type ButtonProperties = (
	{
		children: any,
		onClick: () => void | Promise<void>
	}
	&
	BackgroundProperties
	&
	BorderProperties
)

function TransformButtonProperties(props: ButtonProperties): React.CSSProperties {
	return Object.assign({},
		{
			cursor: 'pointer'
		},
		TransformBackgroundProperties(props),
		TransformBorderProperties(props),
	) as any;
}

function Button(props: ButtonProperties) {
	return (
		<button
			style={
				Object.assign({},
					{
						display: 'inline-flex',
						flexDirection: 'row',
						verticalAlign: 'middle',
						outline: 'none',
						border: 'none'
					},
					TransformButtonProperties(props)
				) as any
			}

			onClick={props.onClick}

			children={props.children}
		/>
	)
}

type SectionProperties = (
	{
		children: any,
		title: any
	}
)

function TransformSectionProperties(props: SectionProperties): React.CSSProperties {
	return Object.assign({}
	) as any;
}

function SectionView(props: SectionProperties) {
	return (
		<div
			style={
				Object.assign({},
					{
						display: 'flex',
						flexDirection: 'column'
					},
					TransformSectionProperties(props)
				) as any
			}
		>
			<div
				style={
					{
						borderBottom: '1px solid gray',
						fontSize: '28px',
						paddingBottom: '8px',
						marginBottom: '16px',
						width: '100%'
					}
				}

				children={props.title}
			/>
			{props.children}
		</div>
	)
}
