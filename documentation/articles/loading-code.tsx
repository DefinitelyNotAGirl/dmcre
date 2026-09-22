"page";

import { Reference } from "../Reference";

const Type = "Article";

const title = "Loading code";

function content() {
	return (
		<>
			<SectionView title='Using the system toolchain'>
				<ParagraphView>
					<TextView>
						The DMCRE was originally designed to load code using the toolchain provided by the host system,
						doing so has fallen out of favour, these functions are provided for backwards compatiblity,
						no further development will be happening on these functions and no garuantees are made as to their continued stability.
					</TextView>
				</ParagraphView>
				<SectionView title='Loading source files'>
					<ParagraphView>
						<Reference QualifiedName="dmcre::load::cpp" Language="C++" /><br/>
						<Reference QualifiedName="dmcre::load::Swift" Language="C++" /><br/>
						<Reference QualifiedName="dmcre::load::ObjCpp" Language="C++" /><br/>
					</ParagraphView>
				</SectionView>
			</SectionView>
		</>
	)
}
