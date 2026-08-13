#define DMCRE_ARC_CPP
#include <dmcre/ARC.hpp>

#include <iomanip>
#include <map>
#include <cstring>
#include <string>
#include <stdexcept>
#include <filesystem>
#include <source_location>

#include <dmcre/debug.hpp>
#include <dmcre/JSON.hpp>
#include <dmcre/foundation.hpp>
#include <string>

#define DMCRE_ARC_DEBUG 0

using namespace dmcre;

struct ReferenceDebugInfo {
	const std::source_location source;
};

struct ControlDebugInfo {
	const std::source_location source;
	
	std::map<void*,ReferenceDebugInfo> referenceDebugInfo;
};

std::map<ARC::Control*,ControlDebugInfo> controlDebugInfo;

void ARC::registerToTable(ARC::Control* control,const std::source_location& caller) {
#if DMCRE_ARC_DEBUG == 1
	controlDebugInfo.insert({
		control,
		{
			.source = caller,
		}
	});
	dmcre::debug::send(
		JSON::object(
			{
				JSON("event","ARC/object/create"),
				JSON("dataSize",(int64_t)control->dataSize()),
				JSON("dataType",std::string((char*)Typename(control->type()).encode(String::Format::CSTRING).raw())),
				JSON("dataAddress",(int64_t)control->data()),
				JSON("controlAddress",(int64_t)control)
			}
		)
	);
#endif
}

void ARC::unregisterFromTable(ARC::Control* control) {
#if DMCRE_ARC_DEBUG == 1
	controlDebugInfo.erase(control);
	dmcre::debug::send(
		JSON::object(
			{
				JSON("event","ARC/object/destroy"),
				JSON("dataSize",(int64_t)control->dataSize()),
				JSON("dataType",std::string((char*)Typename(control->type()).encode(String::Format::CSTRING).raw())),
				JSON("dataAddress",(int64_t)control->data()),
				JSON("controlAddress",(int64_t)control)
			}
		)
	);
#endif
}

void ARC::debug_register_ref(void* ref_this,ARC::Control* control,const std::source_location& source) {
#if DMCRE_ARC_DEBUG == 1
	controlDebugInfo.at(control).referenceDebugInfo.insert({
		ref_this,
		{
			.source = source
		}
	});
	dmcre::debug::send(
		JSON::object(
			{
				JSON("event","ARC/ref/create"),
				JSON("controlAddress",(int64_t)control),
				JSON("refAddress",(int64_t)ref_this)
			}
		)
	);
#endif
}

void ARC::debug_unregister_ref(void* ref_this,ARC::Control* control,const std::source_location& source) {
#if DMCRE_ARC_DEBUG == 1
	controlDebugInfo.at(control).referenceDebugInfo.erase(ref_this);
	dmcre::debug::send(
		JSON::object(
			{
				JSON("event","ARC/ref/destroy"),
				JSON("controlAddress",(int64_t)control),
				JSON("refAddress",(int64_t)ref_this)
			}
		)
	);
#endif
}

void ARC::dumpTable() {
	std::cout << "###################################### ARC DEBUG ######################################" << std::endl;
	for(auto& control : controlDebugInfo) {
		std::cout << "control: " << std::hex << control.first << std::endl;
		std::cout << "\tdata: " << std::hex << control.first->m_data << std::endl;
		//std::cout << "\ttype: " << Typename(control.first->m_type) << std::endl;
		std::cout << "\trefcnt: " << std::dec << control.first->m_refCount << std::endl;
		std::cout << "\tsource: " << control.second.source.function_name() << " in " << control.second.source.file_name() << " on line " << std::dec << control.second.source.line() << std::endl;
		for(auto& reference : control.second.referenceDebugInfo) {
			std::cout << "\treference: " << std::hex << reference.first << std::endl;
			std::cout << "\t\tsource: " << reference.second.source.function_name() << " in " << reference.second.source.file_name() << " on line " << std::dec << reference.second.source.line() << std::endl;
		}
	}
	std::cout << "#######################################################################################" << std::endl;
}
