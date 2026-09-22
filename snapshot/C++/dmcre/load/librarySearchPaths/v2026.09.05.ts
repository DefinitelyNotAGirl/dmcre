snapshot_Language("C++");snapshot_SourceFile("Headers/C++/dmcre/load");
snapshot_SourceLine(23);
snapshot_QualifiedName("dmcre::load::librarySearchPaths");
snapshot_UnqualifiedName("librarySearchPaths");
snapshot_dataType({
	"kind": "ClassTemplateSpecialization",
	"name": "vector",
	"TemplateArgs": [
		{
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
		{
			"kind": "ClassTemplateSpecialization",
			"name": "allocator",
			"TemplateArgs": [
				{
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
});
