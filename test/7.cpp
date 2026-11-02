#include <vector>
#include <string>
#include <iostream>
#include <dmcre/foundation>

#include "8.hpp"

class ReflectedClass1 {
	__public [[clang::annotate("DMCRE_DatabaseKit_dbfield")]] int Field1;
	__public [[clang::annotate("DMCRE_DatabaseKit_dbfield")]] double Field2;
	__public [[clang::annotate("DMCRE_DatabaseKit_dbfield")]] std::string Field3;
	__public [[clang::annotate("DMCRE_DatabaseKit_dbfield")]] unsigned long long Field4;
	__public void* Field5;
};

class ReflectedClass2 : public ReflectedClass1 {
	__public [[clang::annotate("DMCRE_DatabaseKit_dbfield")]] std::string Field6;
};

enum class ReflectedEnum1 {
	Member1,
	Member2,
	Member3,
	Member4 = 8,
	Member5,
	Member6,
	Member7,
};

void dmcre_main(std::vector<std::string>& argv) {
	std::cout << EnumeratorToString(ReflectedEnum1::Member4) << std::endl;
	std::cout << dmcre_IsMainFile("this message does not eat potato salad") << std::endl;
	test();
}