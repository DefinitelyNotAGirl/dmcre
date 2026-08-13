//
//  ARC.hpp
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

#pragma once

#include <source_location>
#include <functional>
#include <atomic>

#include "type.hpp"
#include "foundation.hpp"

#include <list>

namespace dmcre {

class ARC {
public:
	class DynamicReference;
	class WeakDynamicReference;
	template<typename T>
	class Reference;
	template<typename T>
	class WeakReference;
		
	class NullReference {};
	
	class Object;
		
#ifndef DMCRE_ARC_CPP
private:
#endif

	class Control;
		
#ifndef DMCRE_ARC_CPP
	private:
#endif
		
	static void registerToTable(Control*,const std::source_location& caller);
	static void unregisterFromTable(Control*);
		
	static void debug_register_ref(void* ref_this,Control* control,const std::source_location& source = std::source_location::current());
	static void debug_unregister_ref(void* ref_this,Control* control,const std::source_location& source = std::source_location::current());
		
public:
	static void dumpTable();
		
#ifndef DMCRE_ARC_CPP
private:
#endif
	class Control {
		friend class ARC;
		friend class DynamicReference;
			
	private:
		const std::type_info& m_type;
		ARC::Object* m_data;
		uint64_t m_dataSize = 69420;
		std::function<void()> m_delete;
		std::atomic<unsigned long long> m_refCount = 0;
			
		Control(
			const std::type_info& p_type,
			ARC::Object* p_data,
			std::function<void()> p_delete,
			uint64_t p_refCount,
			uint64_t p_dataSize,
			const std::source_location& caller
		): m_type(p_type),m_data(p_data),m_delete(p_delete),m_refCount(p_refCount),m_dataSize(p_dataSize) {
			registerToTable(this,caller);
		}
			
		Control() = delete;
		Control(const Control&) = delete;
		Control(Control&&) = delete;
			
	public:
		const std::type_info& type() const {
			return m_type;
		}
			
		ARC::Object* data() {
			return m_data;
		}
			
		uint64_t dataSize() {
			return m_dataSize;
		}
			
		void registerRef() {
			m_refCount++;
		}
			
		void unregisterRef() {
			if(m_refCount.fetch_sub(1, std::memory_order_acq_rel) == 1) {
				unregisterFromTable(this);
				m_delete(); // delete content
				delete this; // delete control object
			}
		}
	};
		
public:
	class NullReferenceException : public std::runtime_error {
	public:
		NullReferenceException(const std::type_info& type):
		std::runtime_error("ARC::NullReferenceException attempting to access object of type "+std::string((char*)::Typename(type).encode(String::Format::CSTRING).raw())) {}
			
		NullReferenceException():
		std::runtime_error("ARC::NullReferenceException attempting to access object of unknown type") {}
		
		NullReferenceException(const std::source_location& caller):
		std::runtime_error("ARC::NullReferenceException attempting to access object of unknown type from "+std::string(caller.file_name())+":"+std::to_string(caller.line())) {}
			
		NullReferenceException(const std::type_info& type,const std::source_location& caller):
		std::runtime_error("ARC::NullReferenceException attempting to access object of type "+std::string((char*)::Typename(type).encode(String::Format::CSTRING).raw())+" from "+std::string(caller.file_name())+":"+std::to_string(caller.line())) {}
	};
		
	class DynamicReference {
		friend class ARC;
	private:
		Control* m_control;
		
		DynamicReference() = delete;
			
		DynamicReference(Control* p_control,const std::source_location& caller = std::source_location::current()): m_control(p_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
	public:
		bool operator==(const DynamicReference& other) const {
			if(this->m_control == nullptr) {
				return false;
			}
				
			if(this->m_control == other.m_control) {
				return true;
			}
				
			return false;
		}

		~DynamicReference() {
			if(m_control != nullptr) {
				debug_unregister_ref(this,m_control);
				m_control->unregisterRef();
			}
		}
			
		DynamicReference(DynamicReference&& other,const std::source_location& caller = std::source_location::current()): m_control(other.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		DynamicReference(const DynamicReference& other,const std::source_location& caller = std::source_location::current()): m_control(other.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		template<typename T>
		DynamicReference(const WeakReference<T>& wref,const std::source_location& caller = std::source_location::current()): m_control(wref.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		DynamicReference(const WeakDynamicReference& wref,const std::source_location& caller = std::source_location::current());
			
		void copy(const DynamicReference& other,const std::source_location& caller = std::source_location::current()) {
			if(m_control != nullptr) {
				debug_unregister_ref(this,m_control,caller);
				m_control->unregisterRef();
			}
			m_control = other.m_control;
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		template<typename T>
		DynamicReference(const Reference<T>& ref);
		
		static DynamicReference nullref() {
			return DynamicReference(nullptr);
		}
			
		bool isnullref() const {
			return m_control == nullptr;
		}
			
		const std::type_info& type(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(ARC::NullReference);
			}
			return m_control->type();
		}
			
		template<typename T>
		bool is(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(T) == typeid(ARC::NullReference);
			}
			return typeid(T) == m_control->type();
		}
			
		template<typename T>
		bool implements(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(T) == typeid(ARC::NullReference);
			}
			return dynamic_cast<const T*>(m_control->data()) != nullptr;
		}
			
		template<typename T>
		T* as(const std::source_location& caller = std::source_location::current()) {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			T* out = dynamic_cast<T*>(m_control->data());
			if(out == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return out;
		}
			
		template<typename T>
		const T* as(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			const T* out = dynamic_cast<const T*>(m_control->data());
			if(out == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return out;
		}
	};
		
	class WeakDynamicReference {
		friend class DynamicReference;
		friend class ARC;
	private:
			
		Control* m_control;
		
		WeakDynamicReference() = delete;
			
	public:
		~WeakDynamicReference() {
		}
			
		WeakDynamicReference(const WeakDynamicReference& other): m_control(other.m_control) {
		}
			
		template<typename T>
		WeakDynamicReference(const Reference<T>& sref): m_control(sref.m_control) {
		}
			
		WeakDynamicReference(const DynamicReference sref): m_control(sref.m_control) {
		}
			
		void copy(const WeakDynamicReference& other,const std::source_location& caller = std::source_location::current()) {
			this->m_control = other.m_control;
		}
			
		static WeakDynamicReference nullref() {
			return WeakDynamicReference(nullptr);
		}
			
		const std::type_info& type(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(ARC::NullReference);
			}
			return m_control->type();
		}
			
		template<typename T>
		bool is(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(T) == typeid(ARC::NullReference);
			}
			return typeid(T) == m_control->type();
		}
			
		template<typename T>
		bool implements(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(T) == typeid(ARC::NullReference);
			}
			return dynamic_cast<const T*>(m_control->data()) != nullptr;
		}
			
		template<typename T>
		T* as(const std::source_location& caller = std::source_location::current()) {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			T* out = dynamic_cast<T*>(m_control->data());
			if(out == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return out;
		}
			
		template<typename T>
		const T* as(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			const T* out = dynamic_cast<const T*>(m_control->data());
			if(out == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return out;
		}
			
		bool isnullref() {
			return m_control == nullptr;
		}
	};
		
	template<typename T>
	class Reference {
		friend class DynamicReference;
		friend class WeakReference<T>;
		template<typename> friend class Reference;
		friend class ARC;

	private:
		Control* m_control;
			
		Reference() = delete;
			
		Reference(Control* p_control,const std::source_location& caller = std::source_location::current()): m_control(p_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
	public:
		~Reference() {
			if(m_control != nullptr) {
				debug_unregister_ref(this,m_control);
				m_control->unregisterRef();
			}
		}
			
		Reference(Reference&& other,const std::source_location& caller = std::source_location::current()): m_control(other.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		Reference(const Reference& other,const std::source_location& caller = std::source_location::current()): m_control(other.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		Reference(const DynamicReference& dref,const std::source_location& caller = std::source_location::current()): m_control(dref.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		Reference(const WeakDynamicReference& dref,const std::source_location& caller = std::source_location::current()): m_control(dref.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		Reference(const WeakReference<T>& wref,const std::source_location& caller = std::source_location::current()): m_control(wref.m_control) {
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		void copy(const Reference& other,const std::source_location& caller = std::source_location::current()) {
			if(m_control != nullptr) {
				debug_unregister_ref(this,m_control,caller);
				m_control->unregisterRef();
			}
			m_control = other.m_control;
			if(m_control != nullptr) {
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		template<typename bT>
		bool implements(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(bT) == typeid(ARC::NullReference);
			}
			return dynamic_cast<const bT*>(m_control->data()) != nullptr;
		}
			
		template<typename oT>
		Reference(const WeakReference<oT>& ref,const std::source_location& caller = std::source_location::current()): m_control(ref.m_control) {
			if(m_control != nullptr) {
				if(dynamic_cast<oT*>(m_control->data()) == nullptr) {
					throw NullReferenceException(typeid(oT),caller);
				}

				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		template<typename oT>
		Reference(const Reference<oT>& ref,const std::source_location& caller = std::source_location::current()): m_control(ref.m_control) {
			if(m_control != nullptr) {
				if(dynamic_cast<oT*>(m_control->data()) == nullptr) {
					throw NullReferenceException(typeid(oT),caller);
				}
					
				debug_register_ref(this,m_control,caller);
				m_control->registerRef();
			}
		}
			
		static Reference nullref() {
			return Reference(nullptr);
		}
			
		T* get(const std::source_location& caller = std::source_location::current()) {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return dynamic_cast<T*>(m_control->data());
		}
			
		const T* get(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return dynamic_cast<T*>(m_control->data());
		}
			
		Reference clone() {
			return ARC::create<T>(T(*this));
		}
			
		bool isnullref() {
			return m_control == nullptr;
		}
	};
		
	template<typename T>
	class WeakReference {
		friend class DynamicReference;
		friend class Reference<T>;
	private:
			
		Control* m_control;
			
		WeakReference() = delete;
			
	public:
		~WeakReference() {
		}
			
		WeakReference(const WeakReference& other): m_control(other.m_control) {
		}
			
		WeakReference(const Reference<T>& sref): m_control(sref.m_control) {
		}
			
		WeakReference(const DynamicReference sref): m_control(sref.m_control) {
		}
		
		WeakReference(const WeakDynamicReference dref): m_control(dref.m_control) {
		}
			
		void copy(const WeakReference& other) {
			this->m_control = other.m_control;
		}
			
		template<typename bT>
		bool implements(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				return typeid(bT) == typeid(ARC::NullReference);
			}
			return dynamic_cast<const bT*>(m_control->data()) != nullptr;
		}
			
		template<typename oT>
		WeakReference(const WeakReference<oT>& ref,const std::source_location& caller = std::source_location::current()): m_control(ref.m_control) {
			if(m_control != nullptr) {
				if(dynamic_cast<oT*>(m_control->data()) == nullptr) {
					throw NullReferenceException(typeid(oT),caller);
				}
			}
		}
			
		template<typename oT>
		WeakReference(const Reference<oT>& ref,const std::source_location& caller = std::source_location::current()): m_control(ref.m_control) {
			if(m_control != nullptr) {
				if(dynamic_cast<oT*>(m_control->data()) == nullptr) {
					throw NullReferenceException(typeid(oT),caller);
				}
			}
		}
			
		static WeakReference nullref() {
			return WeakReference(nullptr);
		}
			
		T* get(const std::source_location& caller = std::source_location::current()) {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return dynamic_cast<T*>(m_control->data());
		}
			
		const T* get(const std::source_location& caller = std::source_location::current()) const {
			if(m_control == nullptr) {
				throw NullReferenceException(typeid(T),caller);
			}
			return dynamic_cast<const T*>(m_control->data());
		}
			
		bool isnullref() {
			return m_control == nullptr;
		}
	};
		
	template<typename T>
	static DynamicReference create(const std::source_location& caller = std::source_location::current()) {
		T* data = new T;
			
		Control* control = new Control(
			typeid(T),
			data,
			[data] {
				delete data;
			},
			0,
			sizeof(T),
			caller
		);
			
		ARC::DynamicReference dref = DynamicReference(control,caller);
			
		data->ARC_THIS.copy(dref,caller);
			
		return dref;
	}
	
	class Object {
	protected:
		friend ARC;
		
		ARC::WeakDynamicReference ARC_THIS = ARC::WeakDynamicReference::nullref();
		
		Object(const Object& other) = default;
		Object(Object&& other) = default;
		Object() = default;
		virtual ~Object() = default;
	};
	
	template<typename T>
	static Reference<T> create(T* data,const std::source_location& caller = std::source_location::current()) {
		Control* control = new Control(
			typeid(T),
			dynamic_cast<ARC::Object*>(data),
			[data] {
				delete data;
			},
			0,
			sizeof(T),
			caller
		);
		
		ARC::Reference<T> ref = DynamicReference(control,caller);
		
		data->ARC_THIS.copy(ref,caller);
		
		return ref;
	}
		
	template<typename T>
	static DynamicReference create(T init,const std::source_location& caller = std::source_location::current()) {
		T* data = new T(init);
			
		Control* control = new Control(
			typeid(T),
			dynamic_cast<ARC::Object*>(data),
			[data] {
				delete data;
			},
			0,
			sizeof(T),
			caller
		);
			
		ARC::DynamicReference dref = DynamicReference(control,caller);
			
		data->ARC_THIS.copy(dref,caller);
			
		return dref;
	}
		
	template<typename T>
	static Reference<T> first(std::list<DynamicReference>& refs) {
		for(auto ref : refs) {
			if(ref.is<T>()) {
				return ref;
			}
		}
		return Reference<T>::nullref();
	}
		
	template<typename T>
	static std::list<Reference<T>> filter(std::list<DynamicReference>& refs) {
		std::list<Reference<T>> out;
		for(auto ref : refs) {
			if(ref.is<T>()) {
				out.push_back(ref);
			}
		}
		return out;
	}
		
	template<typename T>
	static std::list<DynamicReference> filterOut(std::list<DynamicReference>& refs) {
		std::list<DynamicReference> out;
		for(auto ref : refs) {
			if(!ref.is<T>()) {
				out.push_back(ref);
			}
		}
		return out;
	}
		
	template<typename T>
	struct SharedListRef {
		using type = ARC::Reference<T>;
	};
		
	template<>
	struct SharedListRef<void> {
		using type = ARC::DynamicReference;
	};
		
	template<typename T = void>
	class SharedList : public Object, public indexed_list<typename SharedListRef<T>::type> {
	};
		
	class DynamicReferenceList {
	private:
		SharedList<void> m_data;
			
	public:
		decltype(m_data)& data() {
			return m_data;
		}
			
		const decltype(m_data)& data() const {
			return m_data;
		}
	};
};

template<typename T>
inline ARC::DynamicReference::DynamicReference(const Reference<T>& ref): m_control(ref.m_control) {
	if(m_control != nullptr) {
		debug_register_ref(this,m_control,std::source_location::current());
		m_control->registerRef();
	}
}
	
inline ARC::DynamicReference::DynamicReference(const ARC::WeakDynamicReference& wref,const std::source_location& caller): m_control(wref.m_control) {
	if(m_control != nullptr) {
		debug_register_ref(this,m_control,caller);
		m_control->registerRef();
	}
}

}
