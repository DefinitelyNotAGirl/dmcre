"page";

import { Reference } from "../../../Reference";

const Type = "Function";


function ShortDescription() {
	return (
		<div>
			Loads a single C++ source file.
		</div>
	);
}

function FullDescription() {
	return (
		<>
			<ParagraphView>
				Loads a single C++ source file.
				<br/>
				<br/>
				See <Reference Article="Loading code"/> for further context.
			</ParagraphView>
			<SectionView title={"Relevant configuration options"}>
				<ParagraphView>
					<Reference Language="C++" QualifiedName="dmcre::IncludeDirectories" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::compileCommandsPath" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::cppMacros" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::cxx::SystemIncludeDirectories" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::cxx::enableRTTI" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::cxx::SystemIncludeDirectories" /><br/>
					<Reference Language="C++" QualifiedName="dmcre::load::cxx::SystemIncludeDirectories" /><br/>
				</ParagraphView>
			</SectionView>
		</>
	);
}

function parameter_domain() {
	return (<div>domain</div>);
}

function parameter_path() {
	return (<div>path</div>);
}

