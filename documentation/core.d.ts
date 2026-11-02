declare type Page = {
	// basic
	key: string
	// tree
	depth: number
	parent: Page | undefined
	children: Array<Page>
	SourceFile: string
	SourceLine: number
	status: 'not implemented' | 'experimental' | 'stable' | 'deprecated'
} & (
	{
		Type: 'Article'
		title: string
		content: () => React.JSX.Element
	}
	|
	{
		Type: 'Language'
		label: 'C++'
	}
	|
	{
		Type: 'Function' | 'CXXMethod' | 'CXXConstructor' | 'CXXDestructor'
		QualifiedName: string
		UnqualifiedName: string
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'Namespace'
		QualifiedName: string
		UnqualifiedName: string
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'Enum'
		QualifiedName: string
		UnqualifiedName: string,
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'EnumConstant'
		QualifiedName: string
		UnqualifiedName: string,
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'Var'
		QualifiedName: string
		UnqualifiedName: string,
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'Field'
		QualifiedName: string
		UnqualifiedName: string,
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
	|
	{
		Type: 'CXXRecord' | 'ClassTemplate',
		TagTypeKind: string,
		QualifiedName: string
		UnqualifiedName: string,
		isAbstract: boolean
		ShortDescription: () => React.JSX.Element | undefined
		FullDescription: () => React.JSX.Element | undefined
	}
);

declare const Pages: {
	[key: string]: Page
}

declare const snapshots: {
	[key: string]: {
		[key: string]: () => void
	}
}