snapshot_Language("C++");snapshot_SourceFile("Headers/C++/dmcre/DynamicLibrary");
snapshot_SourceLine(32);
snapshot_QualifiedName("dmcre::DynamicLibrary::DynamicLibrary");
snapshot_UnqualifiedName("DynamicLibrary");
snapshot_returnType({
	"kind": "Builtin",
	"name": "void"
});
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
},"path")
snapshot_parameter({
	"kind": "ClassTemplateSpecialization",
	"name": "vector",
	"TemplateArgs": [
		{
			"kind": "Enum",
			"name": "LoadFlag",
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
					"kind": "Enum",
					"name": "LoadFlag",
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
},"flags")
snapshot_dataType({
	"kind": "FunctionProto"
});
