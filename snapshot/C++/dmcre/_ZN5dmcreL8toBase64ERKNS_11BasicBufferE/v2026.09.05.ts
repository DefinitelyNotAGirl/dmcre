snapshot_Language("C++");snapshot_SourceFile("Headers/C++/dmcre/encoding");
snapshot_SourceLine(6);
snapshot_QualifiedName("dmcre::toBase64");
snapshot_UnqualifiedName("toBase64");
snapshot_returnType({
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
});
snapshot_parameter({
	"kind": "LValueReference",
	"referencee": {
		"kind": "CXXRecord",
		"name": "BasicBuffer"
	}
},"buffer")
snapshot_dataType({
	"kind": "FunctionProto"
});
