#include <dmcre/Reflection>

#include <map>

namespace dmcre::reflection {
	std::vector<ReflectedDecl*> ReflectedDeclarations;

	std::map<const std::type_info*,ReflectedDecl*> TypeInfoToReflectedDeclMap;

	DMCRE_PUBLIC_API ReflectedClassDecl* RegisterClassByStdTypeInfo(const std::type_info& type) {
		std::cerr << "RegisterClassByStdTypeInfo(" << type.name() << ")" << std::endl;

		auto decl = new ReflectedClassDecl(type.name());

		TypeInfoToReflectedDeclMap.insert({&type,decl});

		return decl;
	}
}
