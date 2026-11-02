#include "core.h"
#include "DocumentWorker.h"

namespace dmcred {
	void UpdateTextDocument(dmcred::IPC::Object data,std::function<void(dmcred::IPC::Object&)> reply) {
		if(data.type != typeid(std::vector<dmcred::IPC::Object>)) {
			dmcred::IPC::Object result = new std::string("bad arguments");
			reply(result);
			return;
		}
		auto args = reinterpret_cast<std::vector<dmcred::IPC::Object>*>(data.ptr);

		if(args->size() != 3) {
			dmcred::IPC::Object result = new std::string("bad arguments");
			reply(result);
			return;
		}

		auto path = (*args)[0].as<std::string>();
		auto content = (*args)[1].as<std::string>();
		auto version = (*args)[2].as<double>();

		std::cerr << path << " v" << version << std::endl;

		{
			std::lock_guard lock(DocumentWorkerQueueMutex);
			DocumentWorker* worker = nullptr;
			for(decltype(DocumentWorkers)::const_iterator i = DocumentWorkers.cbegin();i<DocumentWorkers.cend();i++) {
				if((*i)->getPath() == path) {
					worker = *i;
					ActiveWorkers.insert({path,worker});
					DocumentWorkers.erase(i);
					break;
				}
			}
			if(ActiveWorkers.contains(path)) {
				worker = ActiveWorkers.at(path);
			}
			if(worker == nullptr) {
				worker = new DocumentWorker(path);
				worker->start();
			}

			worker->QueueUpdate(content,version);
		}
		
		IPC::Object obj(new std::vector<IPC::Object>());
		reply(obj);
	}
}
