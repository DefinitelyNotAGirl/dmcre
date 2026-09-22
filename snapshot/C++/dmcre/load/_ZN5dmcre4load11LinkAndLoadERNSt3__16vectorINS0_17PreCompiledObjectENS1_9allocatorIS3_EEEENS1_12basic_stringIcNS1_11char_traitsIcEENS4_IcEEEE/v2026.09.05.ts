snapshot_Language("C++");snapshot_SourceFile("Headers/C++/dmcre/load");
snapshot_SourceLine(60);
snapshot_QualifiedName("dmcre::load::LinkAndLoad");
snapshot_UnqualifiedName("LinkAndLoad");
snapshot_returnType({
	"kind": "CXXRecord",
	"name": "DynamicLibrary"
});
snapshot_parameter({
	"kind": "LValueReference",
	"referencee": {
		"kind": "ClassTemplateSpecialization",
		"name": "vector",
		"TemplateArgs": [
			{
				"kind": "CXXRecord",
				"name": "PreCompiledObject",
				"parent": {
					"kind": "Namespace",
					"name": "dmcre"
				}
			},
			{
				"kind": "ClassTemplateSpecialization",
				"name": "allocator",
				"TemplateArgs": [
					{
						"kind": "CXXRecord",
						"name": "PreCompiledObject",
						"parent": {
							"kind": "Namespace",
							"name": "dmcre"
						}
					}
				],
				"parent": {
					"kind": "Namespace",
					"name": "std"
				}
			}
		],
		"parent": {
			"kind": "Namespace",
			"name": "std"
		}
	}
},"objects")
snapshot_parameter({
	"kind": "TypeAlias",
	"name": "string",
	"underlyingType": {
		"kind": "ClassTemplateSpecialization",
		"name": "basic_string",
		"TemplateArgs": [
			{
				"kind": "Builtin",
				"name": "char"
			},
			{
				"kind": "Record"
			},
			{
				"kind": "ClassTemplateSpecialization",
				"name": "allocator",
				"TemplateArgs": [
					{
						"kind": "Builtin",
						"name": "char"
					}
				],
				"parent": {
					"kind": "Namespace",
					"name": "std"
				}
			}
		],
		"parent": {
			"kind": "Namespace",
			"name": "std"
		}
	},
	"parent": {
		"kind": "Namespace",
		"name": "std"
	}
},"ModuleId")
snapshot_dataType({
	"kind": "FunctionProto"
});
