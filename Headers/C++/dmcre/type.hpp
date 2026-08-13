//
//  type.hpp
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

#pragma once

#include <typeinfo>

// ███╗   ███╗ ██████╗ ██████╗ ██╗███████╗██╗███████╗██████╗ ███████╗
// ████╗ ████║██╔═══██╗██╔══██╗██║██╔════╝██║██╔════╝██╔══██╗██╔════╝
// ██╔████╔██║██║   ██║██║  ██║██║█████╗  ██║█████╗  ██████╔╝███████╗
// ██║╚██╔╝██║██║   ██║██║  ██║██║██╔══╝  ██║██╔══╝  ██╔══██╗╚════██║
// ██║ ╚═╝ ██║╚██████╔╝██████╔╝██║██║     ██║███████╗██║  ██║███████║
// ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝
template<typename T>
using Pointer = T*;

template<typename T>
using ConstantPointer = T* const;

template<typename T>
using VolatilePointer = T* volatile;

template<typename T>
using ConstantVolatilePointer = T* const volatile;

// ████████╗██╗   ██╗██████╗ ███████╗    ████████╗██████╗  █████╗ ██╗████████╗███████╗
// ╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔════╝    ╚══██╔══╝██╔══██╗██╔══██╗██║╚══██╔══╝██╔════╝
//    ██║    ╚████╔╝ ██████╔╝█████╗         ██║   ██████╔╝███████║██║   ██║   ███████╗
//    ██║     ╚██╔╝  ██╔═══╝ ██╔══╝         ██║   ██╔══██╗██╔══██║██║   ██║   ╚════██║
//    ██║      ██║   ██║     ███████╗       ██║   ██║  ██║██║  ██║██║   ██║   ███████║
//    ╚═╝      ╚═╝   ╚═╝     ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝
template<typename A, typename B>
constexpr bool IsSame = __is_same(A,B);

template<typename A,typename B>
constexpr bool IsBaseOf = __is_base_of(A,B);

template<typename T>
constexpr bool IsClass = __is_class(T);

template<typename T>
constexpr bool IsEnum = __is_enum(T);

template<typename T>
constexpr bool IsUnion = __is_union(T);

template<typename T>
constexpr bool IsTriviallyConstructible = __is_trivially_constructible(T);

template<typename T>
constexpr bool IsTriviallyCopyable = __is_trivially_copyable(T);

template<typename T>
constexpr bool IsConstructible = __is_constructible(T);

template<typename T>
constexpr bool IsTrivial = __is_trivial(T);

template<typename T>
constexpr bool IsStandardLayout = __is_standard_layout(T);

template<typename T>
constexpr bool IsPod = __is_pod(T);

template<typename T>
constexpr bool IsAbstract = __is_abstract(T);

template<typename T>
constexpr bool IsPolymorphic = __is_polymorphic(T);

template<typename from,typename to>
constexpr bool IsConvertible = __is_convertible(from,to);

template<typename T>
concept IsIntegral = __is_integral(T);

/// Evaluates true if inside any constant evaluation (constexpr or consteval)
constexpr bool IsConstEval() noexcept {
	return __builtin_is_constant_evaluated();
}

// Primary template: chosen type is T if Condition is true
template<bool Condition, typename T, typename F>
struct ConditionalType_Helper {
	using type = T;
};

// Specialization: chosen type is F if Condition is false
template<typename T, typename F>
struct ConditionalType_Helper<false, T, F> {
	using type = F;
};

template<bool condition,typename T,typename F>
using ConditionalType = typename ConditionalType_Helper<condition, T, F>::type;

template<typename T> struct remove_reference      { using type = T; };
template<typename T> struct remove_reference<T&>  { using type = T; };
template<typename T> struct remove_reference<T&&> { using type = T; };

template<typename T>
using remove_ref = typename remove_reference<T>::type;

template<typename T> struct remove_pointer      { using type = T; };
template<typename T> struct remove_pointer<T*>  { using type = T; };

template<typename T>
using remove_ptr = typename remove_pointer<T>::type;

// Remove const
template<typename T> struct remove_const { using type = T; };
template<typename T> struct remove_const<const T> { using type = T; };

// Remove volatile
template<typename T> struct remove_volatile { using type = T; };
template<typename T> struct remove_volatile<volatile T> { using type = T; };

// Remove both const and volatile
template<typename T>
struct RemoveQualifiers_s {
	using type = typename remove_const<typename remove_volatile<T>::type>::type;
};

// Shorthand alias (like std::remove_cv_t)
template<typename T>
using RemoveQualifiers = typename RemoveQualifiers_s<T>::type;

// Pointer detection
template<typename T> struct is_pointer_s { static constexpr bool value = false; };
template<typename T> struct is_pointer_s<T*> { static constexpr bool value = true; };

template<typename T>
concept IsPointer = is_pointer_s<T>::value;
