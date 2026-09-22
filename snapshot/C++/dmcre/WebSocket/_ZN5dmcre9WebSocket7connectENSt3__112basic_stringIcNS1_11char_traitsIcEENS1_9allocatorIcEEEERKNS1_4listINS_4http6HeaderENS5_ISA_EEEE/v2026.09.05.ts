snapshot_Language("C++");snapshot_SourceFile("Headers/C++/dmcre/WebSocket");
snapshot_SourceLine(130);
snapshot_QualifiedName("dmcre::WebSocket::connect");
snapshot_UnqualifiedName("connect");
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
	"kind": "LValueReference",
	"referencee": {
		"kind": "ClassTemplateSpecialization",
		"name": "list",
		"TemplateArgs": [
			{
				"kind": "CXXRecord",
				"name": "Header",
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
						"name": "Header",
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
},"headers")
snapshot_dataType({
	"kind": "FunctionProto"
});
