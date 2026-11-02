import * as fs from 'fs';
import * as path from 'path';
import typescript from 'typescript';

// the english language cannot express how much i hate microsoft...

var javascript_out = new TextDecoder().decode(fs.readFileSync('bundler_core.js'));

const importedModules: Array<string> = [];

function GetJavascript(
	nodes: Array<typescript.Node>,
	scriptKind: typescript.ScriptKind,
	source?: typescript.SourceFile
) {
	const fileName = scriptKind == typescript.ScriptKind.JS ? 'generated.js' : 'generated.tsx';
	const generatedSource = typescript.createSourceFile(
		fileName,
		'',
		typescript.ScriptTarget.ES2022,
		false,
		scriptKind
	);
	const printer = typescript.createPrinter({
		newLine: typescript.NewLineKind.LineFeed
	});
	const sourceText = nodes.map(node => printer.printNode(
		typescript.EmitHint.Unspecified,
		node,
		source ?? node.getSourceFile() ?? generatedSource
	)).join('\n');
	if(scriptKind == typescript.ScriptKind.JS) {
		javascript_out += sourceText;
		return;
	}
	const result = typescript.transpileModule(sourceText, {
		compilerOptions: {
			target: typescript.ScriptTarget.ES2022,
			module: typescript.ModuleKind.ESNext,
			jsx: typescript.JsxEmit.React,
			sourceMap: false
		},
		fileName: fileName
	});

	return result.outputText;
}

function ResolveModulePath(specifier: string,source: string): string {
	let resolved = '';
	if(specifier.charAt(0) == '.') {
		resolved = path.join(path.dirname(source),specifier);
	} else {
		if(fs.existsSync(`node_modules/${specifier}.js`)) {
			resolved = `node_modules/${specifier}.js`;
		} else {
			resolved = `node_modules/${specifier}/index.js`;
		}
	}

	if(fs.existsSync(resolved)) {
		return resolved;
	}

	if(fs.existsSync(resolved+'.js')) {
		return resolved+'.js';
	}

	if(fs.existsSync(resolved+'.ts')) {
		return resolved+'.ts';
	}

	if(fs.existsSync(resolved+'.tsx')) {
		return resolved+'.tsx';
	}

	throw new Error(`failed to resolve ${resolved} to a file`);
}

function ImportModule(specifier: string,source: string) {
	const resolved = ResolveModulePath(specifier,source);

	if(importedModules.includes(resolved)) {
		return;
	}

	importedModules.push(resolved);

	if(resolved.endsWith('.js')) {
		ImportCommonJsFile(resolved,resolved);
	}
	else if(resolved.endsWith('.ts')) {
		ImportTsFile(resolved);
	}
	else if(resolved.endsWith('.tsx')) {
		ImportTsxFile(resolved);
	}
	else {
		throw new Error(`failed to resolve import function for ${resolved}`);
	}
}

function makeIIFE(nodes: Array<typescript.Statement>): typescript.CallExpression {
	const iife = typescript.factory.createCallExpression(
	    typescript.factory.createArrowFunction(
	        undefined,
	        undefined,
	        [],
	        undefined,
	        typescript.factory.createToken(typescript.SyntaxKind.EqualsGreaterThanToken),
	        typescript.factory.createBlock(nodes, true)
	    ),
	    undefined,
	    []
	);

	return iife;
}

function ImportCommonJsFile(file: string,module: string) {
	const source = typescript.createSourceFile(
		file,
		new TextDecoder().decode(fs.readFileSync(file)),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.JS
	);

	const transformation = typescript.transform(source, [context => root => {
		function visit(node: typescript.Node): typescript.VisitResult<typescript.Node> {
			if(
				typescript.isCallExpression(node) &&
				typescript.isIdentifier(node.expression) &&
				node.expression.text == 'require' &&
				node.arguments.length == 1 &&
				typescript.isStringLiteral(node.arguments[0])
			) {
				const specifier = node.arguments[0].text;
				const resolved = ResolveModulePath(specifier,file);
				ImportModule(specifier,file);

				return typescript.factory.updateCallExpression(
					node,
					node.expression,
					node.typeArguments,
					[typescript.factory.createStringLiteral(resolved)]
				);
			}

			return typescript.visitEachChild(node, visit, context);
		}

		return typescript.visitNode(root, visit) as typescript.SourceFile;
	}]);
	const transformed = transformation.transformed[0];

	const printer = typescript.createPrinter({
		newLine: typescript.NewLineKind.LineFeed
	});
	const body = transformed.statements.map(statement => printer.printNode(
		typescript.EmitHint.Unspecified,
		statement,
		transformed
	)).join('\n');

	javascript_out += `modules[${JSON.stringify(module)}] = (exports, module) => {\n${body}\n};\n`;
}

function CreateImportBinding(
    localName: string,
    moduleName: string,
    exportName: string
): typescript.VariableStatement {
	const requireCall = typescript.factory.createCallExpression(
		typescript.factory.createIdentifier('require'),
		undefined,
		[
			typescript.factory.createStringLiteral(moduleName)
		]
	);

	const exportAccess = typescript.factory.createElementAccessExpression(
        requireCall,
        typescript.factory.createStringLiteral(exportName)
    );

    return typescript.factory.createVariableStatement(
        undefined,
        typescript.factory.createVariableDeclarationList(
            [
                typescript.factory.createVariableDeclaration(
                    localName,
                    undefined,
                    undefined,
                    exportAccess
                )
            ],
            typescript.NodeFlags.Const
        )
    );
}

function CreateDefaultImportBinding(
    localName: string,
    moduleName: string
): typescript.VariableStatement {
	const requireCall = typescript.factory.createCallExpression(
		typescript.factory.createIdentifier('require'),
		undefined,
		[
			typescript.factory.createStringLiteral(moduleName)
		]
	);

    return typescript.factory.createVariableStatement(
        undefined,
        typescript.factory.createVariableDeclarationList(
            [
                typescript.factory.createVariableDeclaration(
                    localName,
                    undefined,
                    undefined,
                    requireCall
                )
            ],
            typescript.NodeFlags.Const
        )
    );
}

function getJavascriptNodesForImportClause(importClause: typescript.ImportClause,module: string): Array<typescript.Statement> {
	const out: Array<typescript.Statement> = [];

	if(importClause.namedBindings !== undefined) {
		importClause.namedBindings.forEachChild(node => {
			if((node as any).name == undefined) {
				console.log(importClause)
				return;
			}
			const localName = (node as any).name.escapedText;
			if((node as any).propertyName !== undefined) {
				const exportName = (node as any).propertyName.escapedText;
				out.push(CreateImportBinding(localName,module,exportName));
			} else {
				out.push(CreateImportBinding(localName,module,localName));
			}
		});
	}

	if(importClause.name !== undefined) {
		const localName = (importClause.name as any).escapedText;
		out.push(CreateDefaultImportBinding(localName,module));
	}

	return out;
}

function ResolveImportsAndExports(nodes: Array<typescript.Statement>,source: string): Array<typescript.Statement> {
	const out: Array<typescript.Statement> = [];

	nodes.forEach(node => {
		if(node.kind == typescript.SyntaxKind.ImportDeclaration) {
			const module = ResolveModulePath((node as any).moduleSpecifier.text,source);
			ImportModule((node as any).moduleSpecifier.text,source);

			const importClause = (node as any).importClause as typescript.ImportClause;
			out.push(...getJavascriptNodesForImportClause(importClause,module));
		}
		else if(node.kind == typescript.SyntaxKind.FunctionDeclaration) {
			// check if declaration is export
    		if (
    		    typescript.getModifiers(node as typescript.FunctionDeclaration)?.some(
    		        modifier => modifier.kind === typescript.SyntaxKind.ExportKeyword
    		    )
    		) {
				out.push(
					typescript.factory.createFunctionDeclaration(
						typescript.getModifiers(node as typescript.FunctionDeclaration)?.filter(
    		    		    modifier => modifier.kind !== typescript.SyntaxKind.ExportKeyword
    		    		),
						undefined,
						(node as any).name.text,
						undefined,
						(node as any).parameters,
						(node as any).type,
						(node as any).body
					)
				);
				out.push(
					typescript.factory.createAssignment(
						typescript.factory.createElementAccessExpression(
							typescript.factory.createIdentifier('exports'),
							typescript.factory.createStringLiteral((node as any).name.text)
						),
						typescript.factory.createIdentifier((node as any).name.text)
					) as any
				);
				/*
				out.push(
					typescript.factory.createAssignment(
						typescript.factory.createElementAccessExpression(
							typescript.factory.createIdentifier('exports'),
							typescript.factory.createStringLiteral((node as any).name.text)
						),
						typescript.factory.createArrowFunction(
							undefined,
							undefined,
							(node as any).parameters,
							(node as any).type,
							undefined,
							(node as any).body
						)
					) as any
				);
				*/
			} else {
				out.push(node);
			}
		}
		else if(node.kind == typescript.SyntaxKind.VariableStatement) {
			if (
    		    typescript.getModifiers(node as typescript.FunctionDeclaration)?.some(
    		        modifier => modifier.kind === typescript.SyntaxKind.ExportKeyword
    		    )
    		) {
				node.forEachChild(statement => {
					statement.forEachChild(statement => {
						if(statement.kind == typescript.SyntaxKind.VariableDeclaration) {
							out.push(
								typescript.factory.createVariableStatement(
									undefined,
									typescript.factory.createVariableDeclarationList(
										[
											typescript.factory.createVariableDeclaration(
												typescript.factory.createIdentifier((statement as any).name.text),
												undefined,
												undefined,
												(statement as any).initializer
											)
										],
										typescript.NodeFlags.Const
									)
								) as any
							);
							out.push(
								typescript.factory.createAssignment(
									typescript.factory.createElementAccessExpression(
										typescript.factory.createIdentifier('exports'),
										typescript.factory.createStringLiteral((statement as any).name.text)
									),
									typescript.factory.createIdentifier((statement as any).name.text)
								) as any
							);
							/*
							out.push(
								typescript.factory.createAssignment(
									typescript.factory.createElementAccessExpression(
										typescript.factory.createIdentifier('exports'),
										typescript.factory.createStringLiteral((statement as any).name.text)
									),
									(statement as any).initializer
								) as any
							);
							*/
						}
					})
				})
			} else {
				out.push(node);
			}
		}
		else {
			out.push(node);
		}
	});

	return out;
}

function ImportTsFile(file: string) {
	const source = typescript.createSourceFile(
		file,
		new TextDecoder().decode(fs.readFileSync(file)),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.TS
	);

	const statements = ResolveImportsAndExports([...source.statements],file);

	const body = GetJavascript(statements,typescript.ScriptKind.TS,source);

	javascript_out += `modules[${JSON.stringify(file)}] = (exports, module) => {\n${body}\n};\n`;
}

function ImportTsxFile(file: string) {
	const source = typescript.createSourceFile(
		file,
		new TextDecoder().decode(fs.readFileSync(file)),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.TSX
	);

	const statements = ResolveImportsAndExports([...source.statements],file);

	const body = GetJavascript(statements,typescript.ScriptKind.TSX,source);

	javascript_out += `modules[${JSON.stringify(file)}] = (exports, module) => {\n${body}\n};\n`;
}

function IncludeGlobalTsxImplementationFile(file: string) {
	const source = typescript.createSourceFile(
		file,
		new TextDecoder().decode(fs.readFileSync(file)),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.TSX
	);

	const body = GetJavascript([...source.statements],typescript.ScriptKind.TSX,source);

	javascript_out += `${body}\n\n`;
}

const pageListIdentifier = typescript.factory.createIdentifier('Pages');

function ProcessPageFile(source: typescript.SourceFile,file: string) {
	const page = path.join(path.dirname(file),path.basename(file,path.extname(file))).split('/').slice(1).join('/');

	console.log(`page ${file} => ${page}`);

	const importNodes: Array<typescript.Statement> = [];

	(() => {
		const module = ResolveModulePath('react',file);
		const importClause = typescript.factory.createImportClause(undefined,typescript.factory.createIdentifier('React'),undefined);
		importNodes.push(...getJavascriptNodesForImportClause(importClause,module));
	})();

	const statements = [...importNodes];

	statements.push(
		typescript.factory.createAssignment(
			typescript.factory.createElementAccessExpression(
				pageListIdentifier,
				typescript.factory.createStringLiteral(page)
			),
			typescript.factory.createObjectLiteralExpression([],false)
		) as any
	);

	source.forEachChild(statement => {
		if(statement.kind == typescript.SyntaxKind.EndOfFileToken) {
		}
		else if(statement.kind == typescript.SyntaxKind.ImportDeclaration) {
			const module = ResolveModulePath((statement as any).moduleSpecifier.text,file);
			ImportModule((statement as any).moduleSpecifier.text,file);

			const importClause = (statement as any).importClause as typescript.ImportClause;
			statements.push(...getJavascriptNodesForImportClause(importClause,module));
		}
		else if(statement.kind == typescript.SyntaxKind.ExpressionStatement) {
			if((statement as any).expression.kind == typescript.SyntaxKind.StringLiteral) {
				const text = (statement as any).expression.text;
				if(text == 'page') {
				}
				else {
					console.warn(`warning: unexpected top level string: '${text}'`);
				}
			}
		}
		else if(statement.kind == typescript.SyntaxKind.FunctionDeclaration) {
			const declaration = statement as typescript.FunctionDeclaration;
			const identifier = declaration.name?.escapedText ?? 'anonymous';
			statements.push(
				typescript.factory.createAssignment(
					typescript.factory.createElementAccessExpression(
						typescript.factory.createElementAccessExpression(
							pageListIdentifier,
							typescript.factory.createStringLiteral(page)
						),
						typescript.factory.createStringLiteral(String(identifier))
					),
					typescript.factory.createArrowFunction(
						(declaration as any).modifiers,
						declaration.typeParameters,
						declaration.parameters,
						declaration.type,
						undefined,
						(declaration as any).body
					)
				) as any
			);
		}
		else if(statement.kind == typescript.SyntaxKind.VariableStatement) {
			statement.forEachChild(statement => {
				if(statement.kind == typescript.SyntaxKind.VariableDeclarationList) {
					statement.forEachChild(statement => {
						if(statement.kind == typescript.SyntaxKind.VariableDeclaration) {
							//console.log(statement);
							const identifier = (statement as any).name.escapedText;

							const init = (statement as any).initializer;
							const right =
								init && typescript.isStringLiteral(init)
								? typescript.factory.createStringLiteral(init.text)
								: init;

							statements.push(
								typescript.factory.createAssignment(
									typescript.factory.createElementAccessExpression(
										typescript.factory.createElementAccessExpression(
											pageListIdentifier,
											typescript.factory.createStringLiteral(page)
										),
										typescript.factory.createStringLiteral(identifier)
									),
									right
								) as any
							);
						}
					})
				}
			})
		}
		else {
			console.warn(`warning: unexpected top level statement of type '${statement.kind}'`);
		}
	});

	statements.push(
		typescript.factory.createAssignment(
			typescript.factory.createElementAccessExpression(
				typescript.factory.createElementAccessExpression(
					pageListIdentifier,
					typescript.factory.createStringLiteral(page)
				),
				typescript.factory.createStringLiteral('key')
			),
			typescript.factory.createStringLiteral(page)
		) as any
	);

	javascript_out += GetJavascript([
		makeIIFE(statements)
	],typescript.ScriptKind.TSX,source);
}

var lastSnapshotId = "";
function ProcessSnapshotFile(source: typescript.SourceFile,file: string) {
	const id = path.join(path.dirname(file),path.basename(file,path.extname(file))).split('/').slice(1,-1).join('/');
	const version = path.basename(file,'.ts');

	console.log(`snapshot ${file} => ${id}#${version}`);

	const statements = [...source.statements];
	const tlStatements = [] as Array<typescript.Node>;

	if(lastSnapshotId != id) {
		tlStatements.push(
			typescript.factory.createAssignment(
				typescript.factory.createElementAccessExpression(
					typescript.factory.createIdentifier('snapshots'),
					typescript.factory.createStringLiteral(id)
				),
				typescript.factory.createObjectLiteralExpression([])
			)
		);
	}
	lastSnapshotId = id;

	tlStatements.push(
		typescript.factory.createAssignment(
			typescript.factory.createElementAccessExpression(
				typescript.factory.createElementAccessExpression(
					typescript.factory.createIdentifier('snapshots'),
					typescript.factory.createStringLiteral(id)
				),
				typescript.factory.createStringLiteral(version)
			),
			typescript.factory.createArrowFunction(
				[],
				undefined,
				[],
				undefined,
				undefined,
				typescript.factory.createBlock(
					statements,
					true
				)
			)
		)
	);

	javascript_out += GetJavascript(tlStatements,typescript.ScriptKind.TS,source);
}

function ProcessSourceFile(file: string) {
	const source = typescript.createSourceFile(
		file,
		new TextDecoder().decode(fs.readFileSync(file)),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.TSX
	);

	const node = source.getChildAt(0).getChildAt(0);

	if(node.kind == typescript.SyntaxKind.ExpressionStatement) {
		if((node as any).expression.kind == typescript.SyntaxKind.StringLiteral) {
			const type = (node as any).expression.text;
			if(type == 'page') {
				ProcessPageFile(source,file);
			}
			else if(type == 'implementation') {
			}
			else {
				console.error(`unexpected source type '${type}'`);
			}
		} else {
			console.error(`first AST node.expression.kind must be typescript.SyntaxKind.StringLiteral`,node);
		}
	} else {
		console.error(`first AST node.kind must be typescript.SyntaxKind.ExpressionStatement`,node);
	}
}

ImportModule('react','');
ImportModule('react-dom/client','');

javascript_out += `const React = require('node_modules/react/cjs/react.development.js');\n\n`;

IncludeGlobalTsxImplementationFile('documentation/BasicElements.tsx');

(() => {
	const source = typescript.createSourceFile(
		'snapshot.d.ts',
		new TextDecoder().decode(fs.readFileSync('snapshot.d.ts')),
		typescript.ScriptTarget.ES2025,
		true,
		typescript.ScriptKind.TS
	);

	const snapshotFunctions = [] as Array<string>;

	source.forEachChild(statement => {
		//console.log(statement)
		if(statement.kind == typescript.SyntaxKind.VariableStatement) {
			const declarationList = (statement as any).declarationList as typescript.VariableDeclarationList;
			//console.log(declarationList)
			declarationList.forEachChild(declaration => {
				console.log(declaration);
				const name = (declaration as any).name.escapedText as string;
				if(name.startsWith('snapshot_')) {
					snapshotFunctions.push(name);
				}
			})
		}
	});

	snapshotFunctions.forEach(func => {
		javascript_out += `var ${func} = undefined;\n`;
	})

	javascript_out += `function ResetSnapshotEval() {\n`;
	snapshotFunctions.forEach(func => {
		javascript_out += `${func} = () => {};\n`;
	})
	javascript_out += `}\n`;

	javascript_out += (`
function EvaluateSnapshots(key) {
	if(snapshots[key] != undefined) {
		Object.entries(snapshots[key]).forEach(([key,value]) => {
			snapshot_version(key);
			value();
		})
	}
}
`);

})();

//process.exit(0);

javascript_out += GetJavascript([
	typescript.factory.createVariableDeclaration(
		pageListIdentifier,
		undefined,
		undefined,
		typescript.factory.createObjectLiteralExpression([],false)
	)
],typescript.ScriptKind.TSX);

javascript_out += GetJavascript([
	typescript.factory.createVariableDeclaration(
		typescript.factory.createIdentifier('snapshots'),
		undefined,
		undefined,
		typescript.factory.createObjectLiteralExpression([],false)
	)
],typescript.ScriptKind.TSX);

console.log('pages');
function ProcessSourceDirectory(dir: string) {
	const entries = fs.readdirSync(dir,{recursive: true});
	for(const i of entries) {
		if((i as string).endsWith('.tsx')) {
			ProcessSourceFile('documentation/'+i);
		}
	}
}
ProcessSourceDirectory('documentation');

console.log('snapshots');
for(const i of fs.readdirSync('snapshot',{recursive: true})) {
	if((i as string).endsWith('.ts')) {
		const file = 'snapshot/'+i;
		const source = typescript.createSourceFile(
			file,
			new TextDecoder().decode(fs.readFileSync(file)),
			typescript.ScriptTarget.ES2025,
			true,
			typescript.ScriptKind.TSX
		);
		ProcessSnapshotFile(source,file);
	}
}

console.log('logic');
const mainFile = 'documentation/main.ts';
ImportTsFile(mainFile);
javascript_out+=`require('${mainFile}');`

fs.writeFileSync(`documentation_out.html`,`
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<style>
		@font-face {
		    font-family: "JetBrains Mono";
			font-style: normal;
		    font-weight: 400;
		    font-display: block;
		    src: url("data:font/woff2;base64,${fs.readFileSync(`fonts/JetBrainsMono-Regular.woff2`).toString('base64')}") format("woff2");
		}
		* {
			font-family: "Jetbrains Mono";
			box-sizing: border-box;
		}
		button {
			border: unset;
			outline: unset;
		}
	</style>
</head>
<body>
</body>
<script>
${javascript_out}
</script>
</html>
`)
