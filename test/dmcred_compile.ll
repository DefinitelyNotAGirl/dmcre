; ModuleID = 'dmcred_compile.cpp'
source_filename = "dmcred_compile.cpp"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-w64-windows-gnu"

%"class.clang::FileSystemOptions" = type { %"class.std::__cxx11::basic_string" }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { ptr }
%union.anon = type { i64, [8 x i8] }
%"class.clang::DiagnosticOptions" = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58" }
%"class.std::vector.58" = type { %"struct.std::_Vector_base.59" }
%"struct.std::_Vector_base.59" = type { %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char>>>::_Vector_impl" }
%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char>>>::_Vector_impl" = type { %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char>>>::_Vector_impl_data" }
%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char>>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.clang::HeaderSearchOptions" = type <{ %"class.std::__cxx11::basic_string", %"class.std::vector.147", %"class.std::vector.152", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::map.157", %"class.std::vector.58", %"class.std::__cxx11::basic_string", i32, i32, i32, [4 x i8], i64, %"class.llvm::SmallSetVector", %"class.std::vector.58", i32, [4 x i8] }>
%"class.std::vector.147" = type { %"struct.std::_Vector_base.148" }
%"struct.std::_Vector_base.148" = type { %"struct.std::_Vector_base<clang::HeaderSearchOptions::Entry, std::allocator<clang::HeaderSearchOptions::Entry>>::_Vector_impl" }
%"struct.std::_Vector_base<clang::HeaderSearchOptions::Entry, std::allocator<clang::HeaderSearchOptions::Entry>>::_Vector_impl" = type { %"struct.std::_Vector_base<clang::HeaderSearchOptions::Entry, std::allocator<clang::HeaderSearchOptions::Entry>>::_Vector_impl_data" }
%"struct.std::_Vector_base<clang::HeaderSearchOptions::Entry, std::allocator<clang::HeaderSearchOptions::Entry>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::vector.152" = type { %"struct.std::_Vector_base.153" }
%"struct.std::_Vector_base.153" = type { %"struct.std::_Vector_base<clang::HeaderSearchOptions::SystemHeaderPrefix, std::allocator<clang::HeaderSearchOptions::SystemHeaderPrefix>>::_Vector_impl" }
%"struct.std::_Vector_base<clang::HeaderSearchOptions::SystemHeaderPrefix, std::allocator<clang::HeaderSearchOptions::SystemHeaderPrefix>>::_Vector_impl" = type { %"struct.std::_Vector_base<clang::HeaderSearchOptions::SystemHeaderPrefix, std::allocator<clang::HeaderSearchOptions::SystemHeaderPrefix>>::_Vector_impl_data" }
%"struct.std::_Vector_base<clang::HeaderSearchOptions::SystemHeaderPrefix, std::allocator<clang::HeaderSearchOptions::SystemHeaderPrefix>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::map.157" = type { %"class.std::_Rb_tree.158" }
%"class.std::_Rb_tree.158" = type { %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>, std::less<void>>::_Rb_tree_impl" }
%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>, std::less<void>>::_Rb_tree_impl" = type { [8 x i8], %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_header" = type { %"struct.std::_Rb_tree_node_base", i64 }
%"struct.std::_Rb_tree_node_base" = type { i32, ptr, ptr, ptr }
%"class.llvm::SmallSetVector" = type { %"class.llvm::SetVector" }
%"class.llvm::SetVector" = type { %"class.llvm::DenseSet", %"class.llvm::SmallVector.165" }
%"class.llvm::DenseSet" = type { %"class.llvm::detail::DenseSetImpl" }
%"class.llvm::detail::DenseSetImpl" = type { %"class.llvm::DenseMap.163" }
%"class.llvm::DenseMap.163" = type { ptr, ptr, i32, i32 }
%"class.llvm::SmallVector.165" = type { %"class.llvm::SmallVectorImpl.166", %"struct.llvm::SmallVectorStorage.169" }
%"class.llvm::SmallVectorImpl.166" = type { %"class.llvm::SmallVectorTemplateBase.167" }
%"class.llvm::SmallVectorTemplateBase.167" = type { %"class.llvm::SmallVectorTemplateCommon.168" }
%"class.llvm::SmallVectorTemplateCommon.168" = type { %"class.llvm::SmallVectorBase" }
%"class.llvm::SmallVectorBase" = type { ptr, i32, i32 }
%"struct.llvm::SmallVectorStorage.169" = type { [256 x i8] }
%"class.clang::PreprocessorOptions" = type { %"class.std::vector.170", %"class.std::vector.58", %"class.std::vector.58", i8, i8, i8, i8, i8, i8, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.58", i32, i8, i8, i8, %"class.std::set", %"struct.std::pair", i8, i8, i8, i8, i8, i8, %"class.std::vector.180", %"class.std::vector.185", %"class.std::vector.58", i8, i8, i32, i8, i8, [6 x i8], %"class.std::optional.190", i32, i32 }
%"class.std::vector.170" = type { %"struct.std::_Vector_base.171" }
%"struct.std::_Vector_base.171" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, bool>, std::allocator<std::pair<std::__cxx11::basic_string<char>, bool>>>::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, bool>, std::allocator<std::pair<std::__cxx11::basic_string<char>, bool>>>::_Vector_impl" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, bool>, std::allocator<std::pair<std::__cxx11::basic_string<char>, bool>>>::_Vector_impl_data" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, bool>, std::allocator<std::pair<std::__cxx11::basic_string<char>, bool>>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::set" = type { %"class.std::_Rb_tree.175" }
%"class.std::_Rb_tree.175" = type { %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>, std::_Identity<std::__cxx11::basic_string<char>>, std::less<std::__cxx11::basic_string<char>>>::_Rb_tree_impl" }
%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>, std::_Identity<std::__cxx11::basic_string<char>>, std::less<std::__cxx11::basic_string<char>>>::_Rb_tree_impl" = type { [8 x i8], %"struct.std::_Rb_tree_header" }
%"struct.std::pair" = type <{ i32, i8, [3 x i8] }>
%"class.std::vector.180" = type { %"struct.std::_Vector_base.181" }
%"struct.std::_Vector_base.181" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::allocator<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>>::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::allocator<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>>::_Vector_impl" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::allocator<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>>::_Vector_impl_data" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::allocator<std::pair<std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::vector.185" = type { %"struct.std::_Vector_base.186" }
%"struct.std::_Vector_base.186" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>, std::allocator<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>>>::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>, std::allocator<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>>>::_Vector_impl" = type { %"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>, std::allocator<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>>>::_Vector_impl_data" }
%"struct.std::_Vector_base<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>, std::allocator<std::pair<std::__cxx11::basic_string<char>, llvm::MemoryBuffer *>>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::optional.190" = type { %"struct.std::_Optional_base.191" }
%"struct.std::_Optional_base.191" = type { %"struct.std::_Optional_payload.192" }
%"struct.std::_Optional_payload.192" = type { %"struct.std::_Optional_payload_base.base", [7 x i8] }
%"struct.std::_Optional_payload_base.base" = type <{ %"union.std::_Optional_payload_base<unsigned long long>::_Storage", i8 }>
%"union.std::_Optional_payload_base<unsigned long long>::_Storage" = type { i64 }
%"class.clang::LangOptions" = type { %"class.clang::LangOptionsBase", i32, %"struct.clang::SanitizerSet", i8, %"struct.clang::SanitizerSet", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.clang::ObjCRuntime", i32, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"struct.clang::CommentOptions", %"class.std::vector.58", %"class.std::map.195", %"class.std::__cxx11::basic_string", %"class.std::vector.198", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::optional.203", i8, i32, i32, %"class.std::vector.58", %"class.std::__cxx11::basic_string", i8, i8, i32, %"class.std::__cxx11::basic_string", i8, i8, i8, i8, [4 x i8], %"class.std::optional.190", %"class.std::optional.210", %"class.std::__cxx11::basic_string" }
%"class.clang::LangOptionsBase" = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%"struct.clang::SanitizerSet" = type { %"class.clang::SanitizerMask" }
%"class.clang::SanitizerMask" = type { [2 x i64] }
%"class.clang::ObjCRuntime" = type { i32, %"class.llvm::VersionTuple" }
%"class.llvm::VersionTuple" = type { i32, i32, i32, i32 }
%"struct.clang::CommentOptions" = type <{ %"class.std::vector.58", i8, [7 x i8] }>
%"class.std::map.195" = type { %"class.std::_Rb_tree.196" }
%"class.std::_Rb_tree.196" = type { %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>, std::greater<std::__cxx11::basic_string<char>>>::_Rb_tree_impl" }
%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char>>>, std::greater<std::__cxx11::basic_string<char>>>::_Rb_tree_impl" = type { [8 x i8], %"struct.std::_Rb_tree_header" }
%"class.std::vector.198" = type { %"struct.std::_Vector_base.199" }
%"struct.std::_Vector_base.199" = type { %"struct.std::_Vector_base<llvm::Triple, std::allocator<llvm::Triple>>::_Vector_impl" }
%"struct.std::_Vector_base<llvm::Triple, std::allocator<llvm::Triple>>::_Vector_impl" = type { %"struct.std::_Vector_base<llvm::Triple, std::allocator<llvm::Triple>>::_Vector_impl_data" }
%"struct.std::_Vector_base<llvm::Triple, std::allocator<llvm::Triple>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::optional.203" = type { %"struct.std::_Optional_base.204" }
%"struct.std::_Optional_base.204" = type { %"struct.std::_Optional_payload.205" }
%"struct.std::_Optional_payload.205" = type { %"struct.std::_Optional_payload_base.base.207", [3 x i8] }
%"struct.std::_Optional_payload_base.base.207" = type <{ %"union.std::_Optional_payload_base<clang::TargetCXXABI::Kind>::_Storage", i8 }>
%"union.std::_Optional_payload_base<clang::TargetCXXABI::Kind>::_Storage" = type { i32 }
%"class.std::optional.210" = type { %"struct.std::_Optional_base.211" }
%"struct.std::_Optional_base.211" = type { %"struct.std::_Optional_payload.212" }
%"struct.std::_Optional_payload.212" = type { %"struct.std::_Optional_payload_base.base.214", [3 x i8] }
%"struct.std::_Optional_payload_base.base.214" = type <{ %"union.std::_Optional_payload_base<llvm::AllocTokenMode>::_Storage", i8 }>
%"union.std::_Optional_payload_base<llvm::AllocTokenMode>::_Storage" = type { i32 }
%"class.clang::CodeGenOptions" = type { %"class.clang::CodeGenOptionsBase", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", i64, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", [4 x i8], %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.llvm::SmallVector.217", %"class.llvm::SmallVector.222", %"class.llvm::SmallVector.222", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"struct.llvm::DenormalMode", %"struct.llvm::DenormalMode", %"class.std::__cxx11::basic_string", %"class.std::vector.227", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", i32, %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"class.std::vector.58", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"struct.clang::CodeGenOptions::OptRemark", %"struct.clang::CodeGenOptions::OptRemark", %"struct.clang::CodeGenOptions::OptRemark", %"struct.clang::SanitizerSet", %"struct.clang::SanitizerSet", %"struct.clang::SanitizerSet", %"class.clang::SanitizerMaskCutoffs", %"struct.clang::SanitizerSet", %"class.std::optional.237", %"class.std::vector.244", %"class.std::vector.58", %"class.std::vector.58", %"struct.clang::PointerAuthOptions", %"class.std::__cxx11::basic_string", %"struct.clang::XRayInstrSet", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.249", %"class.std::vector.58", %"class.std::vector.58", %"class.std::vector.58", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"class.std::vector.58", i32, %"class.std::__cxx11::basic_string", ptr, %"class.std::vector.58", %"class.std::optional.190", %"class.std::optional.254", %"class.std::__cxx11::basic_string", %"class.std::vector.58", %"class.std::__cxx11::basic_string", %"class.std::vector.58" }
%"class.clang::CodeGenOptionsBase" = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%"class.llvm::SmallVector.217" = type { %"class.llvm::SmallVectorImpl.218", %"struct.llvm::SmallVectorStorage.221" }
%"class.llvm::SmallVectorImpl.218" = type { %"class.llvm::SmallVectorTemplateBase.219" }
%"class.llvm::SmallVectorTemplateBase.219" = type { %"class.llvm::SmallVectorTemplateCommon.220" }
%"class.llvm::SmallVectorTemplateCommon.220" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.221" = type { [32 x i8] }
%"class.llvm::SmallVector.222" = type { %"class.llvm::SmallVectorImpl.223" }
%"class.llvm::SmallVectorImpl.223" = type { %"class.llvm::SmallVectorTemplateBase.224" }
%"class.llvm::SmallVectorTemplateBase.224" = type { %"class.llvm::SmallVectorTemplateCommon.225" }
%"class.llvm::SmallVectorTemplateCommon.225" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::DenormalMode" = type { i8, i8 }
%"class.std::vector.227" = type { %"struct.std::_Vector_base.228" }
%"struct.std::_Vector_base.228" = type { %"struct.std::_Vector_base<clang::CodeGenOptions::BitcodeFileToLink, std::allocator<clang::CodeGenOptions::BitcodeFileToLink>>::_Vector_impl" }
%"struct.std::_Vector_base<clang::CodeGenOptions::BitcodeFileToLink, std::allocator<clang::CodeGenOptions::BitcodeFileToLink>>::_Vector_impl" = type { %"struct.std::_Vector_base<clang::CodeGenOptions::BitcodeFileToLink, std::allocator<clang::CodeGenOptions::BitcodeFileToLink>>::_Vector_impl_data" }
%"struct.std::_Vector_base<clang::CodeGenOptions::BitcodeFileToLink, std::allocator<clang::CodeGenOptions::BitcodeFileToLink>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"struct.clang::CodeGenOptions::OptRemark" = type { i32, %"class.std::__cxx11::basic_string", %"class.std::shared_ptr" }
%"class.std::shared_ptr" = type { %"class.std::__shared_ptr" }
%"class.std::__shared_ptr" = type { ptr, %"class.std::__shared_count" }
%"class.std::__shared_count" = type { ptr }
%"class.clang::SanitizerMaskCutoffs" = type { %"class.std::vector.232" }
%"class.std::vector.232" = type { %"struct.std::_Vector_base.233" }
%"struct.std::_Vector_base.233" = type { %"struct.std::_Vector_base<double, std::allocator<double>>::_Vector_impl" }
%"struct.std::_Vector_base<double, std::allocator<double>>::_Vector_impl" = type { %"struct.std::_Vector_base<double, std::allocator<double>>::_Vector_impl_data" }
%"struct.std::_Vector_base<double, std::allocator<double>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::optional.237" = type { %"struct.std::_Optional_base.238" }
%"struct.std::_Optional_base.238" = type { %"struct.std::_Optional_payload.239" }
%"struct.std::_Optional_payload.239" = type { %"struct.std::_Optional_payload_base.base.241", [7 x i8] }
%"struct.std::_Optional_payload_base.base.241" = type <{ %"union.std::_Optional_payload_base<double>::_Storage", i8 }>
%"union.std::_Optional_payload_base<double>::_Storage" = type { double }
%"class.std::vector.244" = type { %"struct.std::_Vector_base.245" }
%"struct.std::_Vector_base.245" = type { %"struct.std::_Vector_base<unsigned char, std::allocator<unsigned char>>::_Vector_impl" }
%"struct.std::_Vector_base<unsigned char, std::allocator<unsigned char>>::_Vector_impl" = type { %"struct.std::_Vector_base<unsigned char, std::allocator<unsigned char>>::_Vector_impl_data" }
%"struct.std::_Vector_base<unsigned char, std::allocator<unsigned char>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"struct.clang::PointerAuthOptions" = type { i8, i8, i8, i8, %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema", %"class.clang::PointerAuthSchema" }
%"class.clang::PointerAuthSchema" = type { i32 }
%"struct.clang::XRayInstrSet" = type { i32 }
%"class.std::vector.249" = type { %"struct.std::_Vector_base.250" }
%"struct.std::_Vector_base.250" = type { %"struct.std::_Vector_base<std::function<void (llvm::PassBuilder &)>, std::allocator<std::function<void (llvm::PassBuilder &)>>>::_Vector_impl" }
%"struct.std::_Vector_base<std::function<void (llvm::PassBuilder &)>, std::allocator<std::function<void (llvm::PassBuilder &)>>>::_Vector_impl" = type { %"struct.std::_Vector_base<std::function<void (llvm::PassBuilder &)>, std::allocator<std::function<void (llvm::PassBuilder &)>>>::_Vector_impl_data" }
%"struct.std::_Vector_base<std::function<void (llvm::PassBuilder &)>, std::allocator<std::function<void (llvm::PassBuilder &)>>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.std::optional.254" = type { %"struct.std::_Optional_base.255" }
%"struct.std::_Optional_base.255" = type { %"struct.std::_Optional_payload.256" }
%"struct.std::_Optional_payload.256" = type { %"struct.std::_Optional_payload_base.base.258", [3 x i8] }
%"struct.std::_Optional_payload_base.base.258" = type <{ %"union.std::_Optional_payload_base<unsigned int>::_Storage", i8 }>
%"union.std::_Optional_payload_base<unsigned int>::_Storage" = type { i32 }
%"class.llvm::StringRef" = type { ptr, i64 }
%"class.std::basic_string_view" = type { i64, ptr }
%"class.clang::ConstructionContextItem" = type { ptr, i32, i32 }
%"class.llvm::IntrusiveRefCntPtr" = type { ptr }
%"class.llvm::IntrusiveRefCntPtr.30" = type { ptr }
%"class.std::function" = type { %"class.std::_Function_base", ptr }
%"class.std::_Function_base" = type { %"union.std::_Any_data", ptr }
%"union.std::_Any_data" = type { %"union.std::_Nocopy_types" }
%"union.std::_Nocopy_types" = type { { i64, i64 } }
%class.anon = type { ptr, ptr, ptr }
%"class.clang::FileManager" = type <{ %"class.llvm::RefCountedBase", [4 x i8], %"class.llvm::IntrusiveRefCntPtr", %"class.clang::FileSystemOptions", %"class.llvm::SpecificBumpPtrAllocator", %"class.llvm::SpecificBumpPtrAllocator.6", %"class.llvm::DenseMap", %"class.llvm::DenseMap.7", %"class.llvm::SmallVector.9", %"class.llvm::SmallVector.14", %"class.llvm::SmallVector.19", %"class.llvm::StringMap", %"class.llvm::StringMap.24", %"class.std::unique_ptr", %"class.clang::CustomizableOptional", %"class.llvm::DenseMap.27", %"class.llvm::BumpPtrAllocatorImpl.22", i32, i32, i32, i32, i32, [4 x i8] }>
%"class.llvm::RefCountedBase" = type { i32 }
%"class.llvm::SpecificBumpPtrAllocator" = type { %"class.llvm::BumpPtrAllocatorImpl" }
%"class.llvm::BumpPtrAllocatorImpl" = type { ptr, i64, %"class.llvm::SmallVector", %"class.llvm::SmallVector.1" }
%"class.llvm::SmallVector" = type { %"class.llvm::SmallVectorImpl", %"struct.llvm::SmallVectorStorage" }
%"class.llvm::SmallVectorImpl" = type { %"class.llvm::SmallVectorTemplateBase" }
%"class.llvm::SmallVectorTemplateBase" = type { %"class.llvm::SmallVectorTemplateCommon" }
%"class.llvm::SmallVectorTemplateCommon" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage" = type { [32 x i8] }
%"class.llvm::SmallVector.1" = type { %"class.llvm::SmallVectorImpl.2" }
%"class.llvm::SmallVectorImpl.2" = type { %"class.llvm::SmallVectorTemplateBase.3" }
%"class.llvm::SmallVectorTemplateBase.3" = type { %"class.llvm::SmallVectorTemplateCommon.4" }
%"class.llvm::SmallVectorTemplateCommon.4" = type { %"class.llvm::SmallVectorBase" }
%"class.llvm::SpecificBumpPtrAllocator.6" = type { %"class.llvm::BumpPtrAllocatorImpl" }
%"class.llvm::DenseMap" = type { ptr, ptr, i32, i32 }
%"class.llvm::DenseMap.7" = type { ptr, ptr, i32, i32 }
%"class.llvm::SmallVector.9" = type { %"class.llvm::SmallVectorImpl.10", %"struct.llvm::SmallVectorStorage.13" }
%"class.llvm::SmallVectorImpl.10" = type { %"class.llvm::SmallVectorTemplateBase.11" }
%"class.llvm::SmallVectorTemplateBase.11" = type { %"class.llvm::SmallVectorTemplateCommon.12" }
%"class.llvm::SmallVectorTemplateCommon.12" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.13" = type { [32 x i8] }
%"class.llvm::SmallVector.14" = type { %"class.llvm::SmallVectorImpl.15", %"struct.llvm::SmallVectorStorage.18" }
%"class.llvm::SmallVectorImpl.15" = type { %"class.llvm::SmallVectorTemplateBase.16" }
%"class.llvm::SmallVectorTemplateBase.16" = type { %"class.llvm::SmallVectorTemplateCommon.17" }
%"class.llvm::SmallVectorTemplateCommon.17" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.18" = type { [32 x i8] }
%"class.llvm::SmallVector.19" = type { %"class.llvm::SmallVectorImpl.15" }
%"class.llvm::StringMap" = type { %"class.llvm::StringMapImpl.base", %"class.llvm::detail::AllocatorHolder.21" }
%"class.llvm::StringMapImpl.base" = type <{ ptr, i32, i32, i32 }>
%"class.llvm::detail::AllocatorHolder.21" = type { %"class.llvm::BumpPtrAllocatorImpl.22" }
%"class.llvm::StringMap.24" = type { %"class.llvm::StringMapImpl.base", %"class.llvm::detail::AllocatorHolder.21" }
%"class.std::unique_ptr" = type { %"struct.std::__uniq_ptr_data" }
%"struct.std::__uniq_ptr_data" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Head_base.26" }
%"struct.std::_Head_base.26" = type { ptr }
%"class.clang::CustomizableOptional" = type { %"class.clang::optional_detail::OptionalStorage" }
%"class.clang::optional_detail::OptionalStorage" = type { %"class.clang::FileMgr::MapEntryOptionalStorage" }
%"class.clang::FileMgr::MapEntryOptionalStorage" = type { %"class.clang::FileEntryRef" }
%"class.clang::FileEntryRef" = type { ptr }
%"class.llvm::DenseMap.27" = type { ptr, ptr, i32, i32 }
%"class.llvm::BumpPtrAllocatorImpl.22" = type { ptr, i64, %"class.llvm::SmallVector", %"class.llvm::SmallVector.1" }
%"class.clang::DiagnosticsEngine" = type { %"class.llvm::RefCountedBase.29", i8, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, i32, %"class.llvm::IntrusiveRefCntPtr.30", ptr, ptr, %"class.std::unique_ptr.31", ptr, %"class.std::__cxx11::list", %"class.clang::DiagnosticsEngine::DiagStateMap", %"class.std::vector", i8, i8, i8, i8, i32, i32, i32, i32, i32, ptr, ptr, %"class.llvm::unique_function", %"class.clang::DiagStorageAllocator" }
%"class.llvm::RefCountedBase.29" = type { i32 }
%"class.std::unique_ptr.31" = type { %"struct.std::__uniq_ptr_data.32" }
%"struct.std::__uniq_ptr_data.32" = type { %"class.std::__uniq_ptr_impl.33" }
%"class.std::__uniq_ptr_impl.33" = type { %"class.std::tuple.34" }
%"class.std::tuple.34" = type { %"struct.std::_Tuple_impl.35" }
%"struct.std::_Tuple_impl.35" = type { %"struct.std::_Head_base.38" }
%"struct.std::_Head_base.38" = type { ptr }
%"class.std::__cxx11::list" = type { %"class.std::__cxx11::_List_base" }
%"class.std::__cxx11::_List_base" = type { %"struct.std::__cxx11::_List_base<clang::DiagnosticsEngine::DiagState, std::allocator<clang::DiagnosticsEngine::DiagState>>::_List_impl" }
%"struct.std::__cxx11::_List_base<clang::DiagnosticsEngine::DiagState, std::allocator<clang::DiagnosticsEngine::DiagState>>::_List_impl" = type { %"struct.std::__detail::_List_node_header" }
%"struct.std::__detail::_List_node_header" = type { %"struct.std::__detail::_List_node_base", %"struct.std::__detail::_List_size" }
%"struct.std::__detail::_List_node_base" = type { ptr, ptr }
%"struct.std::__detail::_List_size" = type { i64 }
%"class.clang::DiagnosticsEngine::DiagStateMap" = type <{ %"class.std::map", ptr, ptr, %"class.clang::SourceLocation", [4 x i8] }>
%"class.std::map" = type { %"class.std::_Rb_tree" }
%"class.std::_Rb_tree" = type { %"struct.std::_Rb_tree<clang::FileID, std::pair<const clang::FileID, clang::DiagnosticsEngine::DiagStateMap::File>, std::_Select1st<std::pair<const clang::FileID, clang::DiagnosticsEngine::DiagStateMap::File>>, std::less<clang::FileID>>::_Rb_tree_impl" }
%"struct.std::_Rb_tree<clang::FileID, std::pair<const clang::FileID, clang::DiagnosticsEngine::DiagStateMap::File>, std::_Select1st<std::pair<const clang::FileID, clang::DiagnosticsEngine::DiagStateMap::File>>, std::less<clang::FileID>>::_Rb_tree_impl" = type { [8 x i8], %"struct.std::_Rb_tree_header" }
%"class.clang::SourceLocation" = type { i32 }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<clang::DiagnosticsEngine::DiagState *, std::allocator<clang::DiagnosticsEngine::DiagState *>>::_Vector_impl" }
%"struct.std::_Vector_base<clang::DiagnosticsEngine::DiagState *, std::allocator<clang::DiagnosticsEngine::DiagState *>>::_Vector_impl" = type { %"struct.std::_Vector_base<clang::DiagnosticsEngine::DiagState *, std::allocator<clang::DiagnosticsEngine::DiagState *>>::_Vector_impl_data" }
%"struct.std::_Vector_base<clang::DiagnosticsEngine::DiagState *, std::allocator<clang::DiagnosticsEngine::DiagState *>>::_Vector_impl_data" = type { ptr, ptr, ptr }
%"class.llvm::unique_function" = type { %"class.llvm::detail::UniqueFunctionBase" }
%"class.llvm::detail::UniqueFunctionBase" = type { %"union.llvm::detail::UniqueFunctionBase<bool, unsigned int, clang::SourceLocation, const clang::SourceManager &>::StorageT", ptr, ptr }
%"union.llvm::detail::UniqueFunctionBase<bool, unsigned int, clang::SourceLocation, const clang::SourceManager &>::StorageT" = type { ptr, [16 x i8] }
%"class.clang::DiagStorageAllocator" = type <{ [16 x %"struct.clang::DiagnosticStorage"], [16 x ptr], i32, [4 x i8] }>
%"struct.clang::DiagnosticStorage" = type { i8, [10 x i8], [10 x i64], [10 x %"class.std::__cxx11::basic_string"], %"class.llvm::SmallVector.48", %"class.llvm::SmallVector.53" }
%"class.llvm::SmallVector.48" = type { %"class.llvm::SmallVectorImpl.49", %"struct.llvm::SmallVectorStorage.52" }
%"class.llvm::SmallVectorImpl.49" = type { %"class.llvm::SmallVectorTemplateBase.50" }
%"class.llvm::SmallVectorTemplateBase.50" = type { %"class.llvm::SmallVectorTemplateCommon.51" }
%"class.llvm::SmallVectorTemplateCommon.51" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.52" = type { [96 x i8] }
%"class.llvm::SmallVector.53" = type { %"class.llvm::SmallVectorImpl.54", %"struct.llvm::SmallVectorStorage.57" }
%"class.llvm::SmallVectorImpl.54" = type { %"class.llvm::SmallVectorTemplateBase.55" }
%"class.llvm::SmallVectorTemplateBase.55" = type { %"class.llvm::SmallVectorTemplateCommon.56" }
%"class.llvm::SmallVectorTemplateCommon.56" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.57" = type { [384 x i8] }
%"class.llvm::raw_ostream" = type { ptr, i32, ptr, ptr, ptr, i8, i32 }
%"class.llvm::RefCountedBase.261" = type { i32 }
%"class.llvm::ThreadSafeRefCountedBase" = type { %"struct.std::atomic" }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i32 }
%"struct.std::integral_constant" = type { i8 }
%"struct.std::__invoke_other" = type { i8 }

$_ZNK5clang13AtomicOptions4dumpEv = comdat any

$_ZN4llvm11raw_ostreamlsEPKc = comdat any

$_ZN4llvm11raw_ostreamlsEj = comdat any

$_ZN5clang23ConstructionContextItem15getKindAsStringENS0_8ItemKindE = comdat any

$_ZN4llvm9StringRefC1EPKc = comdat any

$_ZNK5clang23ConstructionContextItem15getKindAsStringEv = comdat any

$_ZNK5clang23ConstructionContextItem7getKindEv = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EPS2_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev = comdat any

$_ZN5clang11FileManager20setVirtualFileSystemEN4llvm18IntrusiveRefCntPtrINS1_3vfs10FileSystemEEE = comdat any

$_ZN5clang13DiagnosticIDs6createEv = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED1Ev = comdat any

$_ZN5clang17DiagnosticsEngine16setSourceManagerEPNS_13SourceManagerE = comdat any

$_ZNSt8functionIFvvEED1Ev = comdat any

$_ZN4llvm11raw_ostreamlsENS_9StringRefE = comdat any

$_ZNK4llvm9StringRef4sizeEv = comdat any

$_ZNK4llvm9StringRef4dataEv = comdat any

$_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc = comdat any

$_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1Ev = comdat any

$_ZN4llvm9StringRefC1ESt17basic_string_viewIcSt11char_traitsIcEE = comdat any

$_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2EPKc = comdat any

$_ZNSt11char_traitsIcE6lengthEPKc = comdat any

$__clang_call_terminate = comdat any

$_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2Ev = comdat any

$_ZN4llvm9StringRefC2ESt17basic_string_viewIcSt11char_traitsIcEE = comdat any

$_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv = comdat any

$_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4sizeEv = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EOS3_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEaSES3_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EOS3_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE4swapERS3_ = comdat any

$_ZN4llvm19makeIntrusiveRefCntIN5clang13DiagnosticIDsEJEEENS_18IntrusiveRefCntPtrIT_EEDpOT0_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC1EPS2_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC2EPS2_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE6retainEv = comdat any

$_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE6retainEPS2_ = comdat any

$_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE6RetainEv = comdat any

$_ZNK5clang17DiagnosticsEngine12DiagStateMap5emptyEv = comdat any

$_ZNKSt3mapIN5clang6FileIDENS0_17DiagnosticsEngine12DiagStateMap4FileESt4lessIS1_ESaISt4pairIKS1_S4_EEE5emptyEv = comdat any

$_ZNKSt8_Rb_treeIN5clang6FileIDESt4pairIKS1_NS0_17DiagnosticsEngine12DiagStateMap4FileEESt10_Select1stIS7_ESt4lessIS1_ESaIS7_EE5emptyEv = comdat any

$_ZNSt8functionIFvvEED2Ev = comdat any

$_ZNSt14_Function_baseD2Ev = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED2Ev = comdat any

$_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE7releaseEv = comdat any

$_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE7releaseEPS2_ = comdat any

$_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE7ReleaseEv = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED2Ev = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE7releaseEv = comdat any

$_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE7releaseEPS2_ = comdat any

$_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE7ReleaseEv = comdat any

$_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EPS2_ = comdat any

$_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE6retainEv = comdat any

$_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE6retainEPS2_ = comdat any

$_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE6RetainEv = comdat any

$_ZNSt13__atomic_baseIiE9fetch_addEiSt12memory_order = comdat any

$_ZNSt14_Function_baseC2Ev = comdat any

$_ZNSt9_Any_data9_M_accessEv = comdat any

$_ZNKSt9_Any_data9_M_accessEv = comdat any

$_ZNSt9_Any_data9_M_accessIPKSt9type_infoEERT_v = comdat any

@.str = private unnamed_addr constant [18 x i8] c"\0A remote_memory: \00", align 1
@.str.1 = private unnamed_addr constant [24 x i8] c"\0A fine_grained_memory: \00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"\0A ignore_denormal_mode: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [30 x i8] c"construct into local variable\00", align 1
@.str.5 = private unnamed_addr constant [29 x i8] c"construct into new-allocator\00", align 1
@.str.6 = private unnamed_addr constant [30 x i8] c"construct into return address\00", align 1
@.str.7 = private unnamed_addr constant [22 x i8] c"materialize temporary\00", align 1
@.str.8 = private unnamed_addr constant [18 x i8] c"destroy temporary\00", align 1
@.str.9 = private unnamed_addr constant [17 x i8] c"elide destructor\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"elide constructor\00", align 1
@.str.11 = private unnamed_addr constant [24 x i8] c"construct into argument\00", align 1
@.str.12 = private unnamed_addr constant [40 x i8] c"construct into lambda captured variable\00", align 1
@.str.13 = private unnamed_addr constant [31 x i8] c"construct into member variable\00", align 1
@.str.14 = private unnamed_addr constant [17 x i8] c"Unknown ItemKind\00", align 1
@.str.15 = private unnamed_addr constant [82 x i8] c"C:\\Users\\lilit/dmcre_2026101700/llvm-include/clang/Analysis/ConstructionContext.h\00", align 1
@_ZN5dmcre4load3cxx9internals17FileSystemOptionsE = external dllimport global %"class.clang::FileSystemOptions", align 8
@_ZN5dmcre4load3cxx9internals17DiagnosticOptionsE = external dllimport global %"class.clang::DiagnosticOptions", align 8
@_ZN5dmcre4load3cxx6config19HeaderSearchOptionsE = external dllimport global %"class.clang::HeaderSearchOptions", align 8
@_ZN5dmcre4load3cxx6config19PreprocessorOptionsE = external dllimport global %"class.clang::PreprocessorOptions", align 8
@_ZN5dmcre4load3cxx6config15LanguageOptionsE = external dllimport global %"class.clang::LangOptions", align 8
@_ZN5dmcre4load3cxx9internals10TargetInfoE = external dllimport global ptr, align 8
@_ZN5dmcre4load3cxx6config14CodeGenOptionsE = external dllimport global %"class.clang::CodeGenOptions", align 8
@.str.16 = private unnamed_addr constant [81 x i8] c"DiagStatesByLoc.empty() && \22Leftover diag state from a different SourceManager.\22\00", align 1
@.str.17 = private unnamed_addr constant [70 x i8] c"C:\\Users\\lilit/dmcre_2026101700/llvm-include/clang/Basic/Diagnostic.h\00", align 1
@.str.18 = private unnamed_addr constant [51 x i8] c"RefCount > 0 && \22Reference count is already zero.\22\00", align 1
@.str.19 = private unnamed_addr constant [75 x i8] c"C:\\Users\\lilit/dmcre_2026101700/llvm-include/llvm/ADT/IntrusiveRefCntPtr.h\00", align 1
@.str.20 = private unnamed_addr constant [56 x i8] c"NewRefCount >= 0 && \22Reference count was already zero.\22\00", align 1
@"_ZTIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0" = internal constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @"_ZTSZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0" }, align 8
@_ZTVN10__cxxabiv117__class_type_infoE = external global [0 x ptr]
@"_ZTSZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0" = internal constant [66 x i8] c"Z11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0\00", align 1
@llvm.used = appending global [6 x ptr] [ptr @_ZNK5clang13AtomicOptions4dumpEv, ptr @_ZNK5clang13AtomicOptions4dumpEv, ptr @_ZN5clang23ConstructionContextItem15getKindAsStringENS0_8ItemKindE, ptr @_ZN5clang23ConstructionContextItem15getKindAsStringENS0_8ItemKindE, ptr @_ZNK5clang23ConstructionContextItem15getKindAsStringEv, ptr @_ZNK5clang23ConstructionContextItem15getKindAsStringEv], section "llvm.metadata"

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNK5clang13AtomicOptions4dumpEv(ptr nonnull align 4 dereferenceable(4) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call nonnull align 8 dereferenceable(104) ptr @_ZN4llvm4errsEv() #11
  %call2 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call, ptr @.str) #11
  %bf.load = load i32, ptr %this1, align 4
  %bf.clear = and i32 %bf.load, 1
  %call3 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call2, i32 %bf.clear) #11
  %call4 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call3, ptr @.str.1) #11
  %bf.load5 = load i32, ptr %this1, align 4
  %bf.lshr = lshr i32 %bf.load5, 1
  %bf.clear6 = and i32 %bf.lshr, 1
  %call7 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call4, i32 %bf.clear6) #11
  %call8 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call7, ptr @.str.2) #11
  %bf.load9 = load i32, ptr %this1, align 4
  %bf.lshr10 = lshr i32 %bf.load9, 2
  %bf.clear11 = and i32 %bf.lshr10, 1
  %call12 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call8, i32 %bf.clear11) #11
  %call13 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call12, ptr @.str.3) #11
  ret void
}

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(104) ptr @_ZN4llvm4errsEv() #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %this, ptr %Str) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %Str.addr = alloca ptr, align 8
  %agg.tmp = alloca %"class.llvm::StringRef", align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %Str, ptr %Str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %Str.addr, align 8
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.tmp, ptr %0) #11
  %call = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsENS_9StringRefE(ptr nonnull align 8 dereferenceable(48) %this1, ptr align 8 dead_on_return %agg.tmp) #11
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %this, i32 %N) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %N.addr = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store i32 %N, ptr %N.addr, align 4
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i32, ptr %N.addr, align 4
  %call = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEm(ptr nonnull align 8 dereferenceable(48) %this1, i32 %0) #11
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN5clang23ConstructionContextItem15getKindAsStringENS0_8ItemKindE(ptr dead_on_unwind noalias writable sret(%"class.llvm::StringRef") align 8 %agg.result, i32 %K) #0 comdat align 2 {
entry:
  %result.ptr = alloca ptr, align 8
  %K.addr = alloca i32, align 4
  store ptr %agg.result, ptr %result.ptr, align 8
  store i32 %K, ptr %K.addr, align 4
  %0 = load i32, ptr %K.addr, align 4
  switch i32 %0, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
    i32 2, label %sw.bb2
    i32 3, label %sw.bb3
    i32 4, label %sw.bb4
    i32 5, label %sw.bb5
    i32 6, label %sw.bb6
    i32 7, label %sw.bb7
    i32 8, label %sw.bb8
    i32 9, label %sw.bb9
  ]

sw.bb:                                            ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.4) #11
  br label %return

sw.bb1:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.5) #11
  br label %return

sw.bb2:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.6) #11
  br label %return

sw.bb3:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.7) #11
  br label %return

sw.bb4:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.8) #11
  br label %return

sw.bb5:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.9) #11
  br label %return

sw.bb6:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.10) #11
  br label %return

sw.bb7:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.11) #11
  br label %return

sw.bb8:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.12) #11
  br label %return

sw.bb9:                                           ; preds = %entry
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr @.str.13) #11
  br label %return

sw.epilog:                                        ; preds = %entry
  call void @_ZN4llvm25llvm_unreachable_internalEPKcS1_j(ptr @.str.14, ptr @.str.15, i32 63) #12
  unreachable

return:                                           ; preds = %sw.bb9, %sw.bb8, %sw.bb7, %sw.bb6, %sw.bb5, %sw.bb4, %sw.bb3, %sw.bb2, %sw.bb1, %sw.bb
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %this, ptr %Str) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %Str.addr = alloca ptr, align 8
  %agg.tmp = alloca %"class.std::basic_string_view", align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %Str, ptr %Str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %Str.addr, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load ptr, ptr %Str.addr, align 8
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.tmp, ptr %1) #13
  br label %cond.end

cond.false:                                       ; preds = %entry
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1Ev(ptr nonnull align 8 dereferenceable(16) %agg.tmp) #13
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  call void @_ZN4llvm9StringRefC1ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this1, ptr align 8 dead_on_return %agg.tmp) #11
  ret void
}

; Function Attrs: convergent noreturn
declare dso_local void @_ZN4llvm25llvm_unreachable_internalEPKcS1_j(ptr, ptr, i32) #2

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNK5clang23ConstructionContextItem15getKindAsStringEv(ptr dead_on_unwind noalias writable sret(%"class.llvm::StringRef") align 8 %agg.result, ptr nonnull align 8 dereferenceable(16) %this) #0 comdat align 2 {
entry:
  %result.ptr = alloca ptr, align 8
  %this.addr = alloca ptr, align 8
  store ptr %agg.result, ptr %result.ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i32 @_ZNK5clang23ConstructionContextItem7getKindEv(ptr nonnull align 8 dereferenceable(16) %this1) #11
  call void @_ZN5clang23ConstructionContextItem15getKindAsStringENS0_8ItemKindE(ptr dead_on_unwind writable sret(%"class.llvm::StringRef") align 8 %agg.result, i32 %call) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i32 @_ZNK5clang23ConstructionContextItem7getKindEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Kind = getelementptr inbounds nuw %"class.clang::ConstructionContextItem", ptr %this1, i32 0, i32 1
  %0 = load i32, ptr %Kind, align 8
  ret i32 %0
}

; Function Attrs: convergent mustprogress noinline optnone
define dso_local void @_Z4initv() #0 {
entry:
  call void @_ZN5dmcre4load3cxx10initializeEv() #11
  ret void
}

; Function Attrs: convergent
declare dllimport void @_ZN5dmcre4load3cxx10initializeEv() #1

; Function Attrs: convergent mustprogress noinline optnone
define dso_local ptr @_Z11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerE(ptr align 8 dead_on_return %Filename, ptr %DiagnosticConsumer) #0 personality ptr @__gxx_personality_seh0 {
entry:
  %Filename.indirect_addr = alloca ptr, align 8
  %DiagnosticConsumer.addr = alloca ptr, align 8
  %FileManager = alloca ptr, align 8
  %agg.tmp = alloca %"class.llvm::IntrusiveRefCntPtr", align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %cleanup.isactive = alloca i1, align 1
  %agg.tmp3 = alloca %"class.llvm::IntrusiveRefCntPtr", align 8
  %DiagnosticsEngine = alloca ptr, align 8
  %agg.tmp8 = alloca %"class.llvm::IntrusiveRefCntPtr.30", align 8
  %cleanup.isactive13 = alloca i1, align 1
  %SourceManager = alloca ptr, align 8
  %agg.tmp23 = alloca %"class.std::function", align 8
  %ref.tmp = alloca %class.anon, align 8
  store ptr %Filename, ptr %Filename.indirect_addr, align 8
  store ptr %DiagnosticConsumer, ptr %DiagnosticConsumer.addr, align 8
  %call = call noalias nonnull ptr @_Znwy(i64 720) #14
  store i1 true, ptr %cleanup.isactive, align 1
  invoke void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EPS2_(ptr nonnull align 8 dereferenceable(8) %agg.tmp, ptr null) #11
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  invoke void @_ZN5clang11FileManagerC1ERKNS_17FileSystemOptionsEN4llvm18IntrusiveRefCntPtrINS4_3vfs10FileSystemEEE(ptr nonnull align 8 dereferenceable(716) %call, ptr nonnull align 8 dereferenceable(32) @_ZN5dmcre4load3cxx9internals17FileSystemOptionsE, ptr align 8 %agg.tmp) #11
          to label %invoke.cont2 unwind label %lpad1

invoke.cont2:                                     ; preds = %invoke.cont
  store i1 false, ptr %cleanup.isactive, align 1
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp) #13
  store ptr %call, ptr %FileManager, align 8
  %0 = load ptr, ptr %FileManager, align 8
  call void @_ZN4llvm3vfs17getRealFileSystemEv(ptr dead_on_unwind writable sret(%"class.llvm::IntrusiveRefCntPtr") align 8 %agg.tmp3) #11
  invoke void @_ZN5clang11FileManager20setVirtualFileSystemEN4llvm18IntrusiveRefCntPtrINS1_3vfs10FileSystemEEE(ptr nonnull align 8 dereferenceable(716) %0, ptr align 8 %agg.tmp3) #11
          to label %invoke.cont5 unwind label %lpad4

invoke.cont5:                                     ; preds = %invoke.cont2
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp3) #13
  %call7 = call noalias nonnull ptr @_Znwy(i64 15256) #14
  store i1 true, ptr %cleanup.isactive13, align 1
  invoke void @_ZN5clang13DiagnosticIDs6createEv(ptr dead_on_unwind writable sret(%"class.llvm::IntrusiveRefCntPtr.30") align 8 %agg.tmp8) #11
          to label %invoke.cont10 unwind label %lpad9

invoke.cont10:                                    ; preds = %invoke.cont5
  %1 = load ptr, ptr %DiagnosticConsumer.addr, align 8
  invoke void @_ZN5clang17DiagnosticsEngineC1EN4llvm18IntrusiveRefCntPtrINS_13DiagnosticIDsEEERNS_17DiagnosticOptionsEPNS_18DiagnosticConsumerEb(ptr nonnull align 8 dereferenceable(15256) %call7, ptr align 8 %agg.tmp8, ptr nonnull align 8 dereferenceable(264) @_ZN5dmcre4load3cxx9internals17DiagnosticOptionsE, ptr %1, i1 zeroext false) #11
          to label %invoke.cont12 unwind label %lpad11

invoke.cont12:                                    ; preds = %invoke.cont10
  store i1 false, ptr %cleanup.isactive13, align 1
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp8) #13
  store ptr %call7, ptr %DiagnosticsEngine, align 8
  %call19 = call noalias nonnull ptr @_Znwy(i64 776) #14
  %2 = load ptr, ptr %DiagnosticsEngine, align 8
  %3 = load ptr, ptr %FileManager, align 8
  invoke void @_ZN5clang13SourceManagerC1ERNS_17DiagnosticsEngineERNS_11FileManagerEb(ptr nonnull align 8 dereferenceable(776) %call19, ptr nonnull align 8 dereferenceable(15256) %2, ptr nonnull align 8 dereferenceable(716) %3, i1 zeroext true) #11
          to label %invoke.cont21 unwind label %lpad20

invoke.cont21:                                    ; preds = %invoke.cont12
  store ptr %call19, ptr %SourceManager, align 8
  %4 = load ptr, ptr %DiagnosticsEngine, align 8
  %5 = load ptr, ptr %SourceManager, align 8
  call void @_ZN5clang17DiagnosticsEngine16setSourceManagerEPNS_13SourceManagerE(ptr nonnull align 8 dereferenceable(15256) %4, ptr %5) #11
  %6 = load ptr, ptr %DiagnosticsEngine, align 8
  %7 = load ptr, ptr %SourceManager, align 8
  %8 = load ptr, ptr %FileManager, align 8
  %9 = load ptr, ptr @_ZN5dmcre4load3cxx9internals10TargetInfoE, align 8
  %10 = getelementptr inbounds nuw %class.anon, ptr %ref.tmp, i32 0, i32 0
  %11 = load ptr, ptr %DiagnosticsEngine, align 8
  store ptr %11, ptr %10, align 8
  %12 = getelementptr inbounds nuw %class.anon, ptr %ref.tmp, i32 0, i32 1
  %13 = load ptr, ptr %SourceManager, align 8
  store ptr %13, ptr %12, align 8
  %14 = getelementptr inbounds nuw %class.anon, ptr %ref.tmp, i32 0, i32 2
  %15 = load ptr, ptr %FileManager, align 8
  store ptr %15, ptr %14, align 8
  call void @"_ZNSt8functionIFvvEEC1IZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0vEEOT_"(ptr nonnull align 8 dereferenceable(32) %agg.tmp23, ptr nonnull align 8 dereferenceable(24) %ref.tmp) #11
  %call26 = invoke ptr @_ZN5dmcre4load3cxx28GetCompilerForLanguageServerEPN5clang17DiagnosticsEngineEPNS2_13SourceManagerEPNS2_11FileManagerEPNS2_19HeaderSearchOptionsEPNS2_19PreprocessorOptionsEPNS2_11LangOptionsEPNS2_10TargetInfoEPNS2_14CodeGenOptionsESt8functionIFvvEE(ptr %6, ptr %7, ptr %8, ptr @_ZN5dmcre4load3cxx6config19HeaderSearchOptionsE, ptr @_ZN5dmcre4load3cxx6config19PreprocessorOptionsE, ptr @_ZN5dmcre4load3cxx6config15LanguageOptionsE, ptr %9, ptr @_ZN5dmcre4load3cxx6config14CodeGenOptionsE, ptr align 8 %agg.tmp23) #11
          to label %invoke.cont25 unwind label %lpad24

invoke.cont25:                                    ; preds = %invoke.cont21
  call void @_ZNSt8functionIFvvEED1Ev(ptr nonnull align 8 dereferenceable(32) %agg.tmp23) #13
  ret ptr %call26

lpad:                                             ; preds = %entry
  %16 = landingpad { ptr, i32 }
          cleanup
  %17 = extractvalue { ptr, i32 } %16, 0
  store ptr %17, ptr %exn.slot, align 8
  %18 = extractvalue { ptr, i32 } %16, 1
  store i32 %18, ptr %ehselector.slot, align 4
  br label %ehcleanup

lpad1:                                            ; preds = %invoke.cont
  %19 = landingpad { ptr, i32 }
          cleanup
  %20 = extractvalue { ptr, i32 } %19, 0
  store ptr %20, ptr %exn.slot, align 8
  %21 = extractvalue { ptr, i32 } %19, 1
  store i32 %21, ptr %ehselector.slot, align 4
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp) #13
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad1, %lpad
  %cleanup.is_active = load i1, ptr %cleanup.isactive, align 1
  br i1 %cleanup.is_active, label %cleanup.action, label %cleanup.done

cleanup.action:                                   ; preds = %ehcleanup
  call void @_ZdlPv(ptr %call) #15
  br label %cleanup.done

cleanup.done:                                     ; preds = %cleanup.action, %ehcleanup
  br label %eh.resume

lpad4:                                            ; preds = %invoke.cont2
  %22 = landingpad { ptr, i32 }
          cleanup
  %23 = extractvalue { ptr, i32 } %22, 0
  store ptr %23, ptr %exn.slot, align 8
  %24 = extractvalue { ptr, i32 } %22, 1
  store i32 %24, ptr %ehselector.slot, align 4
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp3) #13
  br label %eh.resume

lpad9:                                            ; preds = %invoke.cont5
  %25 = landingpad { ptr, i32 }
          cleanup
  %26 = extractvalue { ptr, i32 } %25, 0
  store ptr %26, ptr %exn.slot, align 8
  %27 = extractvalue { ptr, i32 } %25, 1
  store i32 %27, ptr %ehselector.slot, align 4
  br label %ehcleanup15

lpad11:                                           ; preds = %invoke.cont10
  %28 = landingpad { ptr, i32 }
          cleanup
  %29 = extractvalue { ptr, i32 } %28, 0
  store ptr %29, ptr %exn.slot, align 8
  %30 = extractvalue { ptr, i32 } %28, 1
  store i32 %30, ptr %ehselector.slot, align 4
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp8) #13
  br label %ehcleanup15

ehcleanup15:                                      ; preds = %lpad11, %lpad9
  %cleanup.is_active16 = load i1, ptr %cleanup.isactive13, align 1
  br i1 %cleanup.is_active16, label %cleanup.action17, label %cleanup.done18

cleanup.action17:                                 ; preds = %ehcleanup15
  call void @_ZdlPv(ptr %call7) #15
  br label %cleanup.done18

cleanup.done18:                                   ; preds = %cleanup.action17, %ehcleanup15
  br label %eh.resume

lpad20:                                           ; preds = %invoke.cont12
  %31 = landingpad { ptr, i32 }
          cleanup
  %32 = extractvalue { ptr, i32 } %31, 0
  store ptr %32, ptr %exn.slot, align 8
  %33 = extractvalue { ptr, i32 } %31, 1
  store i32 %33, ptr %ehselector.slot, align 4
  call void @_ZdlPv(ptr %call19) #15
  br label %eh.resume

lpad24:                                           ; preds = %invoke.cont21
  %34 = landingpad { ptr, i32 }
          cleanup
  %35 = extractvalue { ptr, i32 } %34, 0
  store ptr %35, ptr %exn.slot, align 8
  %36 = extractvalue { ptr, i32 } %34, 1
  store i32 %36, ptr %ehselector.slot, align 4
  call void @_ZNSt8functionIFvvEED1Ev(ptr nonnull align 8 dereferenceable(32) %agg.tmp23) #13
  br label %eh.resume

eh.resume:                                        ; preds = %lpad24, %lpad20, %cleanup.done18, %lpad4, %cleanup.done
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val28 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val28
}

; Function Attrs: convergent nobuiltin allocsize(0)
declare dso_local noalias nonnull ptr @_Znwy(i64) #4

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EPS2_(ptr nonnull align 8 dereferenceable(8) %this, ptr %obj) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %obj.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EPS2_(ptr nonnull align 8 dereferenceable(8) %this1, ptr %0) #11
  ret void
}

declare dso_local i32 @__gxx_personality_seh0(...)

; Function Attrs: convergent
declare dso_local void @_ZN5clang11FileManagerC1ERKNS_17FileSystemOptionsEN4llvm18IntrusiveRefCntPtrINS4_3vfs10FileSystemEEE(ptr nonnull align 8 dereferenceable(716), ptr nonnull align 8 dereferenceable(32), ptr align 8) unnamed_addr #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #13
  ret void
}

; Function Attrs: convergent nobuiltin nounwind
declare dso_local void @_ZdlPv(ptr) #5

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN5clang11FileManager20setVirtualFileSystemEN4llvm18IntrusiveRefCntPtrINS1_3vfs10FileSystemEEE(ptr nonnull align 8 dereferenceable(716) %this, ptr align 8 %FS) #0 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %FS.indirect_addr = alloca ptr, align 8
  %agg.tmp = alloca %"class.llvm::IntrusiveRefCntPtr", align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store ptr %FS, ptr %FS.indirect_addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EOS3_(ptr nonnull align 8 dereferenceable(8) %agg.tmp, ptr nonnull align 8 dereferenceable(8) %FS) #11
  %FS2 = getelementptr inbounds nuw %"class.clang::FileManager", ptr %this1, i32 0, i32 2
  %call = invoke nonnull align 8 dereferenceable(8) ptr @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEaSES3_(ptr nonnull align 8 dereferenceable(8) %FS2, ptr align 8 %agg.tmp) #11
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp) #13
  ret void

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = extractvalue { ptr, i32 } %0, 0
  store ptr %1, ptr %exn.slot, align 8
  %2 = extractvalue { ptr, i32 } %0, 1
  store i32 %2, ptr %ehselector.slot, align 4
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED1Ev(ptr nonnull align 8 dereferenceable(8) %agg.tmp) #13
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val3 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val3
}

; Function Attrs: convergent
declare dso_local void @_ZN4llvm3vfs17getRealFileSystemEv(ptr dead_on_unwind writable sret(%"class.llvm::IntrusiveRefCntPtr") align 8) #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN5clang13DiagnosticIDs6createEv(ptr dead_on_unwind noalias writable sret(%"class.llvm::IntrusiveRefCntPtr.30") align 8 %agg.result) #0 comdat align 2 {
entry:
  %result.ptr = alloca ptr, align 8
  store ptr %agg.result, ptr %result.ptr, align 8
  call void @_ZN4llvm19makeIntrusiveRefCntIN5clang13DiagnosticIDsEJEEENS_18IntrusiveRefCntPtrIT_EEDpOT0_(ptr dead_on_unwind writable sret(%"class.llvm::IntrusiveRefCntPtr.30") align 8 %agg.result) #11
  ret void
}

; Function Attrs: convergent
declare dso_local void @_ZN5clang17DiagnosticsEngineC1EN4llvm18IntrusiveRefCntPtrINS_13DiagnosticIDsEEERNS_17DiagnosticOptionsEPNS_18DiagnosticConsumerEb(ptr nonnull align 8 dereferenceable(15256), ptr align 8, ptr nonnull align 8 dereferenceable(264), ptr, i1 zeroext) unnamed_addr #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #13
  ret void
}

; Function Attrs: convergent
declare dso_local void @_ZN5clang13SourceManagerC1ERNS_17DiagnosticsEngineERNS_11FileManagerEb(ptr nonnull align 8 dereferenceable(776), ptr nonnull align 8 dereferenceable(15256), ptr nonnull align 8 dereferenceable(716), i1 zeroext) unnamed_addr #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN5clang17DiagnosticsEngine16setSourceManagerEPNS_13SourceManagerE(ptr nonnull align 8 dereferenceable(15256) %this, ptr %SrcMgr) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %SrcMgr.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %SrcMgr, ptr %SrcMgr.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %DiagStatesByLoc = getelementptr inbounds nuw %"class.clang::DiagnosticsEngine", ptr %this1, i32 0, i32 19
  %call = call zeroext i1 @_ZNK5clang17DiagnosticsEngine12DiagStateMap5emptyEv(ptr nonnull align 8 dereferenceable(68) %DiagStatesByLoc) #11
  br i1 %call, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  call void @_assert(ptr @.str.16, ptr @.str.17, i32 633) #11
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %0 = phi i1 [ true, %entry ], [ false, %lor.rhs ]
  %1 = load ptr, ptr %SrcMgr.addr, align 8
  %SourceMgr = getelementptr inbounds nuw %"class.clang::DiagnosticsEngine", ptr %this1, i32 0, i32 17
  store ptr %1, ptr %SourceMgr, align 8
  ret void
}

; Function Attrs: convergent
declare dllimport ptr @_ZN5dmcre4load3cxx28GetCompilerForLanguageServerEPN5clang17DiagnosticsEngineEPNS2_13SourceManagerEPNS2_11FileManagerEPNS2_19HeaderSearchOptionsEPNS2_19PreprocessorOptionsEPNS2_11LangOptionsEPNS2_10TargetInfoEPNS2_14CodeGenOptionsESt8functionIFvvEE(ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr align 8) #1

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt8functionIFvvEEC1IZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0vEEOT_"(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(24) %__f) unnamed_addr #0 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__f.addr, align 8
  call void @"_ZNSt8functionIFvvEEC2IZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0vEEOT_"(ptr nonnull align 8 dereferenceable(32) %this1, ptr nonnull align 8 dereferenceable(24) %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt8functionIFvvEED1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt8functionIFvvEED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #13
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsENS_9StringRefE(ptr nonnull align 8 dereferenceable(48) %this, ptr align 8 dead_on_return %Str) #0 comdat align 2 {
entry:
  %retval = alloca ptr, align 8
  %this.addr = alloca ptr, align 8
  %Str.indirect_addr = alloca ptr, align 8
  %Size = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %Str, ptr %Str.indirect_addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNK4llvm9StringRef4sizeEv(ptr nonnull align 8 dereferenceable(16) %Str) #11
  store i64 %call, ptr %Size, align 8
  %0 = load i64, ptr %Size, align 8
  %OutBufEnd = getelementptr inbounds nuw %"class.llvm::raw_ostream", ptr %this1, i32 0, i32 3
  %1 = load ptr, ptr %OutBufEnd, align 8
  %OutBufCur = getelementptr inbounds nuw %"class.llvm::raw_ostream", ptr %this1, i32 0, i32 4
  %2 = load ptr, ptr %OutBufCur, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %1 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %2 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %cmp = icmp ugt i64 %0, %sub.ptr.sub
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call ptr @_ZNK4llvm9StringRef4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #11
  %3 = load i64, ptr %Size, align 8
  %call3 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostream5writeEPKcy(ptr nonnull align 8 dereferenceable(48) %this1, ptr %call2, i64 %3) #11
  store ptr %call3, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %4 = load i64, ptr %Size, align 8
  %tobool = icmp ne i64 %4, 0
  br i1 %tobool, label %if.then4, label %if.end8

if.then4:                                         ; preds = %if.end
  %OutBufCur5 = getelementptr inbounds nuw %"class.llvm::raw_ostream", ptr %this1, i32 0, i32 4
  %5 = load ptr, ptr %OutBufCur5, align 8
  %call6 = call ptr @_ZNK4llvm9StringRef4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #11
  %6 = load i64, ptr %Size, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %5, ptr align 1 %call6, i64 %6, i1 false)
  %7 = load i64, ptr %Size, align 8
  %OutBufCur7 = getelementptr inbounds nuw %"class.llvm::raw_ostream", ptr %this1, i32 0, i32 4
  %8 = load ptr, ptr %OutBufCur7, align 8
  %add.ptr = getelementptr inbounds nuw i8, ptr %8, i64 %7
  store ptr %add.ptr, ptr %OutBufCur7, align 8
  br label %if.end8

if.end8:                                          ; preds = %if.then4, %if.end
  store ptr %this1, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end8, %if.then
  %9 = load ptr, ptr %retval, align 8
  ret ptr %9
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNK4llvm9StringRef4sizeEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Length = getelementptr inbounds nuw %"class.llvm::StringRef", ptr %this1, i32 0, i32 1
  %0 = load i64, ptr %Length, align 8
  ret i64 %0
}

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostream5writeEPKcy(ptr nonnull align 8 dereferenceable(48), ptr, i64) #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNK4llvm9StringRef4dataEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Data = getelementptr inbounds nuw %"class.llvm::StringRef", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %Data, align 8
  ret ptr %0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #6

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEm(ptr nonnull align 8 dereferenceable(48), i32) #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc(ptr nonnull align 8 dereferenceable(16) %this, ptr nonnull %__str) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__str.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__str, ptr %__str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__str.addr, align 8
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2EPKc(ptr nonnull align 8 dereferenceable(16) %this1, ptr %0) #13
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1Ev(ptr nonnull align 8 dereferenceable(16) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2Ev(ptr nonnull align 8 dereferenceable(16) %this1) #13
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm9StringRefC1ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this, ptr align 8 dead_on_return %Str) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %Str.indirect_addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %Str, ptr %Str.indirect_addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZN4llvm9StringRefC2ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this1, ptr align 8 dead_on_return %Str) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2EPKc(ptr nonnull align 8 dereferenceable(16) %this, ptr nonnull %__str) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__str.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__str, ptr %__str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_len = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %__str.addr, align 8
  %call = invoke i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr %0) #11
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  store i64 %call, ptr %_M_len, align 8
  %_M_str = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 1
  %1 = load ptr, ptr %__str.addr, align 8
  store ptr %1, ptr %_M_str, align 8
  ret void

terminate.lpad:                                   ; preds = %entry
  %2 = landingpad { ptr, i32 }
          catch ptr null
  %3 = extractvalue { ptr, i32 } %2, 0
  call void @__clang_call_terminate(ptr %3) #16
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr %__s) #3 comdat align 2 {
entry:
  %__s.addr = alloca ptr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  %0 = load ptr, ptr %__s.addr, align 8
  %call = call i64 @strlen(ptr %0) #13
  ret i64 %call
}

; Function Attrs: convergent noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(ptr %0) #7 comdat {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #17
  call void @_ZSt9terminatev() #16
  unreachable
}

declare dso_local ptr @__cxa_begin_catch(ptr)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: convergent nounwind
declare dso_local i64 @strlen(ptr) #8

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2Ev(ptr nonnull align 8 dereferenceable(16) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_len = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 0
  store i64 0, ptr %_M_len, align 8
  %_M_str = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 1
  store ptr null, ptr %_M_str, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm9StringRefC2ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this, ptr align 8 dead_on_return %Str) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %Str.indirect_addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %Str, ptr %Str.indirect_addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Data = getelementptr inbounds nuw %"class.llvm::StringRef", ptr %this1, i32 0, i32 0
  %call = call ptr @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #13
  store ptr %call, ptr %Data, align 8
  %Length = getelementptr inbounds nuw %"class.llvm::StringRef", ptr %this1, i32 0, i32 1
  %call2 = call i64 @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4sizeEv(ptr nonnull align 8 dereferenceable(16) %Str) #13
  store i64 %call2, ptr %Length, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_str = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 1
  %0 = load ptr, ptr %_M_str, align 8
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4sizeEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_len = getelementptr inbounds nuw %"class.std::basic_string_view", ptr %this1, i32 0, i32 0
  %0 = load i64, ptr %_M_len, align 8
  ret i64 %0
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC1EOS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr nonnull align 8 dereferenceable(8) %S) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %S.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %S, ptr %S.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %S.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EOS3_(ptr nonnull align 8 dereferenceable(8) %this1, ptr nonnull align 8 dereferenceable(8) %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEaSES3_(ptr nonnull align 8 dereferenceable(8) %this, ptr align 8 %S) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %S.indirect_addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %S, ptr %S.indirect_addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE4swapERS3_(ptr nonnull align 8 dereferenceable(8) %this1, ptr nonnull align 8 dereferenceable(8) %S) #11
  ret ptr %this1
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EOS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr nonnull align 8 dereferenceable(8) %S) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %S.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %S, ptr %S.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %S.addr, align 8, !nonnull !5, !align !6
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %0, i32 0, i32 0
  %1 = load ptr, ptr %Obj2, align 8
  store ptr %1, ptr %Obj, align 8
  %2 = load ptr, ptr %S.addr, align 8, !nonnull !5, !align !6
  %Obj3 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %2, i32 0, i32 0
  store ptr null, ptr %Obj3, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE4swapERS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr nonnull align 8 dereferenceable(8) %other) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %other.addr = alloca ptr, align 8
  %tmp = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %other, ptr %other.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %other.addr, align 8, !nonnull !5, !align !6
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %0, i32 0, i32 0
  %1 = load ptr, ptr %Obj, align 8
  store ptr %1, ptr %tmp, align 8
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %2 = load ptr, ptr %Obj2, align 8
  %3 = load ptr, ptr %other.addr, align 8, !nonnull !5, !align !6
  %Obj3 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %3, i32 0, i32 0
  store ptr %2, ptr %Obj3, align 8
  %4 = load ptr, ptr %tmp, align 8
  %Obj4 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  store ptr %4, ptr %Obj4, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm19makeIntrusiveRefCntIN5clang13DiagnosticIDsEJEEENS_18IntrusiveRefCntPtrIT_EEDpOT0_(ptr dead_on_unwind noalias writable sret(%"class.llvm::IntrusiveRefCntPtr.30") align 8 %agg.result) #0 comdat personality ptr @__gxx_personality_seh0 {
entry:
  %result.ptr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %agg.result, ptr %result.ptr, align 8
  %call = call noalias nonnull ptr @_Znwy(i64 24) #14
  invoke void @_ZN5clang13DiagnosticIDsC1Ev(ptr nonnull align 8 dereferenceable(24) %call) #11
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC1EPS2_(ptr nonnull align 8 dereferenceable(8) %agg.result, ptr %call) #11
  ret void

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = extractvalue { ptr, i32 } %0, 0
  store ptr %1, ptr %exn.slot, align 8
  %2 = extractvalue { ptr, i32 } %0, 1
  store i32 %2, ptr %ehselector.slot, align 4
  call void @_ZdlPv(ptr %call) #15
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val1 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val1
}

; Function Attrs: convergent
declare dso_local void @_ZN5clang13DiagnosticIDsC1Ev(ptr nonnull align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC1EPS2_(ptr nonnull align 8 dereferenceable(8) %this, ptr %obj) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %obj.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC2EPS2_(ptr nonnull align 8 dereferenceable(8) %this1, ptr %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEEC2EPS2_(ptr nonnull align 8 dereferenceable(8) %this, ptr %obj) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %obj.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr.30", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %obj.addr, align 8
  store ptr %0, ptr %Obj, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE6retainEv(ptr nonnull align 8 dereferenceable(8) %this1) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE6retainEv(ptr nonnull align 8 dereferenceable(8) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr.30", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %Obj, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr.30", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %Obj2, align 8
  call void @_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE6retainEPS2_(ptr %1) #11
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE6retainEPS2_(ptr %obj) #0 comdat align 2 {
entry:
  %obj.addr = alloca ptr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  call void @_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE6RetainEv(ptr nonnull align 4 dereferenceable(4) %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE6RetainEv(ptr nonnull align 4 dereferenceable(4) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %RefCount = getelementptr inbounds nuw %"class.llvm::RefCountedBase.261", ptr %this1, i32 0, i32 0
  %0 = load i32, ptr %RefCount, align 4
  %inc = add i32 %0, 1
  store i32 %inc, ptr %RefCount, align 4
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local zeroext i1 @_ZNK5clang17DiagnosticsEngine12DiagStateMap5emptyEv(ptr nonnull align 8 dereferenceable(68) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Files = getelementptr inbounds nuw %"class.clang::DiagnosticsEngine::DiagStateMap", ptr %this1, i32 0, i32 0
  %call = call zeroext i1 @_ZNKSt3mapIN5clang6FileIDENS0_17DiagnosticsEngine12DiagStateMap4FileESt4lessIS1_ESaISt4pairIKS1_S4_EEE5emptyEv(ptr nonnull align 8 dereferenceable(48) %Files) #13
  ret i1 %call
}

; Function Attrs: convergent
declare dllimport void @_assert(ptr, ptr, i32) #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local zeroext i1 @_ZNKSt3mapIN5clang6FileIDENS0_17DiagnosticsEngine12DiagStateMap4FileESt4lessIS1_ESaISt4pairIKS1_S4_EEE5emptyEv(ptr nonnull align 8 dereferenceable(48) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_t = getelementptr inbounds nuw %"class.std::map", ptr %this1, i32 0, i32 0
  %call = call zeroext i1 @_ZNKSt8_Rb_treeIN5clang6FileIDESt4pairIKS1_NS0_17DiagnosticsEngine12DiagStateMap4FileEESt10_Select1stIS7_ESt4lessIS1_ESaIS7_EE5emptyEv(ptr nonnull align 8 dereferenceable(48) %_M_t) #13
  ret i1 %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local zeroext i1 @_ZNKSt8_Rb_treeIN5clang6FileIDESt4pairIKS1_NS0_17DiagnosticsEngine12DiagStateMap4FileEESt10_Select1stIS7_ESt4lessIS1_ESaIS7_EE5emptyEv(ptr nonnull align 8 dereferenceable(48) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_impl = getelementptr inbounds nuw %"class.std::_Rb_tree", ptr %this1, i32 0, i32 0
  %add.ptr = getelementptr inbounds i8, ptr %_M_impl, i64 8
  %_M_node_count = getelementptr inbounds nuw %"struct.std::_Rb_tree_header", ptr %add.ptr, i32 0, i32 1
  %0 = load i64, ptr %_M_node_count, align 8
  %cmp = icmp eq i64 %0, 0
  ret i1 %cmp
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt8functionIFvvEED2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt14_Function_baseD2Ev(ptr nonnull align 8 dereferenceable(24) %this1) #13
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt14_Function_baseD2Ev(ptr nonnull align 8 dereferenceable(24) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_manager = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 1
  %0 = load ptr, ptr %_M_manager, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %_M_manager2 = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 1
  %1 = load ptr, ptr %_M_manager2, align 8
  %_M_functor = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 0
  %_M_functor3 = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 0
  %call = invoke zeroext i1 %1(ptr nonnull align 8 dereferenceable(16) %_M_functor, ptr nonnull align 8 dereferenceable(16) %_M_functor3, i32 3) #11
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %if.then
  br label %if.end

if.end:                                           ; preds = %invoke.cont, %entry
  ret void

terminate.lpad:                                   ; preds = %if.then
  %2 = landingpad { ptr, i32 }
          catch ptr null
  %3 = extractvalue { ptr, i32 } %2, 0
  call void @__clang_call_terminate(ptr %3) #16
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEED2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  invoke void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE7releaseEv(ptr nonnull align 8 dereferenceable(8) %this1) #11
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #16
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrIN5clang13DiagnosticIDsEE7releaseEv(ptr nonnull align 8 dereferenceable(8) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr.30", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %Obj, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr.30", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %Obj2, align 8
  call void @_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE7releaseEPS2_(ptr %1) #11
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm22IntrusiveRefCntPtrInfoIN5clang13DiagnosticIDsEE7releaseEPS2_(ptr %obj) #0 comdat align 2 {
entry:
  %obj.addr = alloca ptr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  call void @_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE7ReleaseEv(ptr nonnull align 4 dereferenceable(4) %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNK4llvm14RefCountedBaseIN5clang13DiagnosticIDsEE7ReleaseEv(ptr nonnull align 4 dereferenceable(4) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %RefCount = getelementptr inbounds nuw %"class.llvm::RefCountedBase.261", ptr %this1, i32 0, i32 0
  %0 = load i32, ptr %RefCount, align 4
  %cmp = icmp ugt i32 %0, 0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  call void @_assert(ptr @.str.18, ptr @.str.19, i32 101) #11
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %1 = phi i1 [ true, %entry ], [ false, %lor.rhs ]
  %RefCount2 = getelementptr inbounds nuw %"class.llvm::RefCountedBase.261", ptr %this1, i32 0, i32 0
  %2 = load i32, ptr %RefCount2, align 4
  %dec = add i32 %2, -1
  store i32 %dec, ptr %RefCount2, align 4
  %cmp3 = icmp eq i32 %dec, 0
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %lor.end
  %isnull = icmp eq ptr %this1, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %if.then
  call void @_ZN5clang13DiagnosticIDsD1Ev(ptr nonnull align 8 dereferenceable(24) %this1) #13
  call void @_ZdlPv(ptr %this1) #15
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %if.then
  br label %if.end

if.end:                                           ; preds = %delete.end, %lor.end
  ret void
}

; Function Attrs: convergent nounwind
declare dso_local void @_ZN5clang13DiagnosticIDsD1Ev(ptr nonnull align 8 dereferenceable(24)) unnamed_addr #8

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEED2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  invoke void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE7releaseEv(ptr nonnull align 8 dereferenceable(8) %this1) #11
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #16
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE7releaseEv(ptr nonnull align 8 dereferenceable(8) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %Obj, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %Obj2, align 8
  call void @_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE7releaseEPS2_(ptr %1) #11
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE7releaseEPS2_(ptr %obj) #0 comdat align 2 {
entry:
  %obj.addr = alloca ptr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  %add.ptr = getelementptr inbounds i8, ptr %0, i64 8
  call void @_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE7ReleaseEv(ptr nonnull align 4 dereferenceable(4) %add.ptr) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE7ReleaseEv(ptr nonnull align 4 dereferenceable(4) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %NewRefCount = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %RefCount = getelementptr inbounds nuw %"class.llvm::ThreadSafeRefCountedBase", ptr %this1, i32 0, i32 0
  %call = call i32 @_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order(ptr nonnull align 4 dereferenceable(4) %RefCount, i32 1, i32 4) #13
  %sub = sub nsw i32 %call, 1
  store i32 %sub, ptr %NewRefCount, align 4
  %0 = load i32, ptr %NewRefCount, align 4
  %cmp = icmp sge i32 %0, 0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  call void @_assert(ptr @.str.20, ptr @.str.19, i32 135) #11
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %1 = phi i1 [ true, %entry ], [ false, %lor.rhs ]
  %2 = load i32, ptr %NewRefCount, align 4
  %cmp2 = icmp eq i32 %2, 0
  br i1 %cmp2, label %if.then, label %if.end

if.then:                                          ; preds = %lor.end
  %sub.ptr = getelementptr inbounds i8, ptr %this1, i64 -8
  %isnull = icmp eq ptr %sub.ptr, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %if.then
  %vtable = load ptr, ptr %sub.ptr, align 8
  %vfn = getelementptr inbounds ptr, ptr %vtable, i64 1
  %3 = load ptr, ptr %vfn, align 8
  call void %3(ptr nonnull align 8 dereferenceable(12) %sub.ptr) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %if.then
  br label %if.end

if.end:                                           ; preds = %delete.end, %lor.end
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i32 @_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order(ptr nonnull align 4 dereferenceable(4) %this, i32 %__i, i32 %__m) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__i.addr = alloca i32, align 4
  %__m.addr = alloca i32, align 4
  %.atomictmp = alloca i32, align 4
  %atomic-temp = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store i32 %__i, ptr %__i.addr, align 4
  store i32 %__m, ptr %__m.addr, align 4
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_i = getelementptr inbounds nuw %"struct.std::__atomic_base", ptr %this1, i32 0, i32 0
  %0 = load i32, ptr %__m.addr, align 4
  %1 = load i32, ptr %__i.addr, align 4
  store i32 %1, ptr %.atomictmp, align 4
  switch i32 %0, label %monotonic [
    i32 1, label %acquire
    i32 2, label %acquire
    i32 3, label %release
    i32 4, label %acqrel
    i32 5, label %seqcst
  ]

monotonic:                                        ; preds = %entry
  %2 = load i32, ptr %.atomictmp, align 4
  %3 = atomicrmw sub ptr %_M_i, i32 %2 monotonic, align 4
  store i32 %3, ptr %atomic-temp, align 4
  br label %atomic.continue

acquire:                                          ; preds = %entry, %entry
  %4 = load i32, ptr %.atomictmp, align 4
  %5 = atomicrmw sub ptr %_M_i, i32 %4 acquire, align 4
  store i32 %5, ptr %atomic-temp, align 4
  br label %atomic.continue

release:                                          ; preds = %entry
  %6 = load i32, ptr %.atomictmp, align 4
  %7 = atomicrmw sub ptr %_M_i, i32 %6 release, align 4
  store i32 %7, ptr %atomic-temp, align 4
  br label %atomic.continue

acqrel:                                           ; preds = %entry
  %8 = load i32, ptr %.atomictmp, align 4
  %9 = atomicrmw sub ptr %_M_i, i32 %8 acq_rel, align 4
  store i32 %9, ptr %atomic-temp, align 4
  br label %atomic.continue

seqcst:                                           ; preds = %entry
  %10 = load i32, ptr %.atomictmp, align 4
  %11 = atomicrmw sub ptr %_M_i, i32 %10 seq_cst, align 4
  store i32 %11, ptr %atomic-temp, align 4
  br label %atomic.continue

atomic.continue:                                  ; preds = %seqcst, %acqrel, %release, %acquire, %monotonic
  %12 = load i32, ptr %atomic-temp, align 4
  ret i32 %12
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEEC2EPS2_(ptr nonnull align 8 dereferenceable(8) %this, ptr %obj) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %obj.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %obj.addr, align 8
  store ptr %0, ptr %Obj, align 8
  call void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE6retainEv(ptr nonnull align 8 dereferenceable(8) %this1) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm18IntrusiveRefCntPtrINS_3vfs10FileSystemEE6retainEv(ptr nonnull align 8 dereferenceable(8) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %Obj = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %Obj, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %Obj2 = getelementptr inbounds nuw %"class.llvm::IntrusiveRefCntPtr", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %Obj2, align 8
  call void @_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE6retainEPS2_(ptr %1) #11
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZN4llvm22IntrusiveRefCntPtrInfoINS_3vfs10FileSystemEE6retainEPS2_(ptr %obj) #0 comdat align 2 {
entry:
  %obj.addr = alloca ptr, align 8
  store ptr %obj, ptr %obj.addr, align 8
  %0 = load ptr, ptr %obj.addr, align 8
  %add.ptr = getelementptr inbounds i8, ptr %0, i64 8
  call void @_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE6RetainEv(ptr nonnull align 4 dereferenceable(4) %add.ptr) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNK4llvm24ThreadSafeRefCountedBaseINS_3vfs10FileSystemEE6RetainEv(ptr nonnull align 4 dereferenceable(4) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %RefCount = getelementptr inbounds nuw %"class.llvm::ThreadSafeRefCountedBase", ptr %this1, i32 0, i32 0
  %call = call i32 @_ZNSt13__atomic_baseIiE9fetch_addEiSt12memory_order(ptr nonnull align 4 dereferenceable(4) %RefCount, i32 1, i32 0) #13
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i32 @_ZNSt13__atomic_baseIiE9fetch_addEiSt12memory_order(ptr nonnull align 4 dereferenceable(4) %this, i32 %__i, i32 %__m) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__i.addr = alloca i32, align 4
  %__m.addr = alloca i32, align 4
  %.atomictmp = alloca i32, align 4
  %atomic-temp = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store i32 %__i, ptr %__i.addr, align 4
  store i32 %__m, ptr %__m.addr, align 4
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_i = getelementptr inbounds nuw %"struct.std::__atomic_base", ptr %this1, i32 0, i32 0
  %0 = load i32, ptr %__m.addr, align 4
  %1 = load i32, ptr %__i.addr, align 4
  store i32 %1, ptr %.atomictmp, align 4
  switch i32 %0, label %monotonic [
    i32 1, label %acquire
    i32 2, label %acquire
    i32 3, label %release
    i32 4, label %acqrel
    i32 5, label %seqcst
  ]

monotonic:                                        ; preds = %entry
  %2 = load i32, ptr %.atomictmp, align 4
  %3 = atomicrmw add ptr %_M_i, i32 %2 monotonic, align 4
  store i32 %3, ptr %atomic-temp, align 4
  br label %atomic.continue

acquire:                                          ; preds = %entry, %entry
  %4 = load i32, ptr %.atomictmp, align 4
  %5 = atomicrmw add ptr %_M_i, i32 %4 acquire, align 4
  store i32 %5, ptr %atomic-temp, align 4
  br label %atomic.continue

release:                                          ; preds = %entry
  %6 = load i32, ptr %.atomictmp, align 4
  %7 = atomicrmw add ptr %_M_i, i32 %6 release, align 4
  store i32 %7, ptr %atomic-temp, align 4
  br label %atomic.continue

acqrel:                                           ; preds = %entry
  %8 = load i32, ptr %.atomictmp, align 4
  %9 = atomicrmw add ptr %_M_i, i32 %8 acq_rel, align 4
  store i32 %9, ptr %atomic-temp, align 4
  br label %atomic.continue

seqcst:                                           ; preds = %entry
  %10 = load i32, ptr %.atomictmp, align 4
  %11 = atomicrmw add ptr %_M_i, i32 %10 seq_cst, align 4
  store i32 %11, ptr %atomic-temp, align 4
  br label %atomic.continue

atomic.continue:                                  ; preds = %seqcst, %acqrel, %release, %acquire, %monotonic
  %12 = load i32, ptr %atomic-temp, align 4
  ret i32 %12
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt8functionIFvvEEC2IZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0vEEOT_"(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(24) %__f) unnamed_addr #0 align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds i8, ptr %this1, i64 0
  call void @llvm.memset.p0.i64(ptr align 8 %0, i8 0, i64 24, i1 false)
  call void @_ZNSt14_Function_baseC2Ev(ptr nonnull align 8 dereferenceable(24) %this1) #13
  %_M_invoker = getelementptr inbounds nuw %"class.std::function", ptr %this1, i32 0, i32 1
  store ptr null, ptr %_M_invoker, align 8
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  %call = call zeroext i1 @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E21_M_not_empty_functionIS6_EEbRKT_"(ptr nonnull align 8 dereferenceable(24) %1) #13
  br i1 %call, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %_M_functor = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 0
  %2 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  invoke void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E15_M_init_functorIS6_EEvRSt9_Any_dataOT_"(ptr nonnull align 8 dereferenceable(16) %_M_functor, ptr nonnull align 8 dereferenceable(24) %2) #11
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.then
  %_M_invoker2 = getelementptr inbounds nuw %"class.std::function", ptr %this1, i32 0, i32 1
  store ptr @"_ZNSt17_Function_handlerIFvvEZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_invokeERKSt9_Any_data", ptr %_M_invoker2, align 8
  %_M_manager = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 1
  store ptr @"_ZNSt17_Function_handlerIFvvEZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_managerERSt9_Any_dataRKS8_St18_Manager_operation", ptr %_M_manager, align 8
  br label %if.end

lpad:                                             ; preds = %if.then
  %3 = landingpad { ptr, i32 }
          cleanup
  %4 = extractvalue { ptr, i32 } %3, 0
  store ptr %4, ptr %exn.slot, align 8
  %5 = extractvalue { ptr, i32 } %3, 1
  store i32 %5, ptr %ehselector.slot, align 4
  call void @_ZNSt14_Function_baseD2Ev(ptr nonnull align 8 dereferenceable(24) %this1) #13
  br label %eh.resume

if.end:                                           ; preds = %invoke.cont, %entry
  ret void

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val3 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #10

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt14_Function_baseC2Ev(ptr nonnull align 8 dereferenceable(24) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_functor = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 0
  store ptr null, ptr %_M_functor, align 8
  %_M_manager = getelementptr inbounds nuw %"class.std::_Function_base", ptr %this1, i32 0, i32 1
  store ptr null, ptr %_M_manager, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal zeroext i1 @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E21_M_not_empty_functionIS6_EEbRKT_"(ptr nonnull align 8 dereferenceable(24) %0) #3 align 2 {
entry:
  %.addr = alloca ptr, align 8
  store ptr %0, ptr %.addr, align 8
  ret i1 true
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E15_M_init_functorIS6_EEvRSt9_Any_dataOT_"(ptr nonnull align 8 dereferenceable(16) %__functor, ptr nonnull align 8 dereferenceable(24) %__f) #0 align 2 {
entry:
  %__functor.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %agg.tmp = alloca %"struct.std::integral_constant", align 1
  store ptr %__functor, ptr %__functor.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %0 = load ptr, ptr %__functor.addr, align 8, !nonnull !5, !align !6
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %agg.tmp, i32 0, i32 0
  %2 = load i8, ptr %coerce.dive, align 1
  call void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_createIS6_EEvRSt9_Any_dataOT_St17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %0, ptr nonnull align 8 dereferenceable(24) %1, i8 %2) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt17_Function_handlerIFvvEZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_invokeERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %__functor) #0 align 2 {
entry:
  %__functor.addr = alloca ptr, align 8
  store ptr %__functor, ptr %__functor.addr, align 8
  %0 = load ptr, ptr %__functor.addr, align 8, !nonnull !5, !align !6
  %call = call ptr @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E14_M_get_pointerERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %0) #13
  call void @"_ZSt10__invoke_rIvRZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0JEENSt9enable_ifIX16is_invocable_r_vIT_T0_DpT1_EES8_E4typeEOS9_DpOSA_"(ptr nonnull align 8 dereferenceable(24) %call) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define internal zeroext i1 @"_ZNSt17_Function_handlerIFvvEZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_managerERSt9_Any_dataRKS8_St18_Manager_operation"(ptr nonnull align 8 dereferenceable(16) %__dest, ptr nonnull align 8 dereferenceable(16) %__source, i32 %__op) #0 align 2 {
entry:
  %__dest.addr = alloca ptr, align 8
  %__source.addr = alloca ptr, align 8
  %__op.addr = alloca i32, align 4
  store ptr %__dest, ptr %__dest.addr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  store i32 %__op, ptr %__op.addr, align 4
  %0 = load i32, ptr %__op.addr, align 4
  switch i32 %0, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
  ]

sw.bb:                                            ; preds = %entry
  %1 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt9_Any_data9_M_accessIPKSt9type_infoEERT_v(ptr nonnull align 8 dereferenceable(16) %1) #13
  store ptr @"_ZTIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0", ptr %call, align 8
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  %2 = load ptr, ptr %__source.addr, align 8, !nonnull !5, !align !6
  %call2 = call ptr @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E14_M_get_pointerERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %2) #13
  %3 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call3 = call nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %3) #13
  store ptr %call2, ptr %call3, align 8
  br label %sw.epilog

sw.default:                                       ; preds = %entry
  %4 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %5 = load ptr, ptr %__source.addr, align 8, !nonnull !5, !align !6
  %6 = load i32, ptr %__op.addr, align 4
  %call4 = call zeroext i1 @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_managerERSt9_Any_dataRKS8_St18_Manager_operation"(ptr nonnull align 8 dereferenceable(16) %4, ptr nonnull align 8 dereferenceable(16) %5, i32 %6) #11
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb1, %sw.bb
  ret i1 false
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_createIS6_EEvRSt9_Any_dataOT_St17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %__dest, ptr nonnull align 8 dereferenceable(24) %__f, i8 %.coerce) #0 align 2 {
entry:
  %0 = alloca %"struct.std::integral_constant", align 1
  %__dest.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %0, i32 0, i32 0
  store i8 %.coerce, ptr %coerce.dive, align 1
  store ptr %__dest, ptr %__dest.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %call = call noalias nonnull ptr @_Znwy(i64 24) #14
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %call, ptr align 8 %1, i64 24, i1 false)
  %2 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call1 = call nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %2) #13
  store ptr %call, ptr %call1, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %this) #3 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNSt9_Any_data9_M_accessEv(ptr nonnull align 8 dereferenceable(16) %this1) #13
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt9_Any_data9_M_accessEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %arrayidx = getelementptr inbounds [16 x i8], ptr %this1, i64 0, i64 0
  ret ptr %arrayidx
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZSt10__invoke_rIvRZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0JEENSt9enable_ifIX16is_invocable_r_vIT_T0_DpT1_EES8_E4typeEOS9_DpOSA_"(ptr nonnull align 8 dereferenceable(24) %__fn) #0 {
entry:
  %__fn.addr = alloca ptr, align 8
  %agg.tmp = alloca %"struct.std::__invoke_other", align 1
  store ptr %__fn, ptr %__fn.addr, align 8
  %0 = load ptr, ptr %__fn.addr, align 8, !nonnull !5, !align !6
  %coerce.dive = getelementptr inbounds nuw %"struct.std::__invoke_other", ptr %agg.tmp, i32 0, i32 0
  %1 = load i8, ptr %coerce.dive, align 1
  call void @"_ZSt13__invoke_implIvRZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0JEET_St14__invoke_otherOT0_DpOT1_"(i8 %1, ptr nonnull align 8 dereferenceable(24) %0) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal ptr @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E14_M_get_pointerERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %__source) #3 align 2 {
entry:
  %__source.addr = alloca ptr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  %0 = load ptr, ptr %__source.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @"_ZNKSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERKT_v"(ptr nonnull align 8 dereferenceable(16) %0) #13
  %1 = load ptr, ptr %call, align 8
  ret ptr %1
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZSt13__invoke_implIvRZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0JEET_St14__invoke_otherOT0_DpOT1_"(i8 %.coerce, ptr nonnull align 8 dereferenceable(24) %__f) #0 {
entry:
  %0 = alloca %"struct.std::__invoke_other", align 1
  %__f.addr = alloca ptr, align 8
  %coerce.dive = getelementptr inbounds nuw %"struct.std::__invoke_other", ptr %0, i32 0, i32 0
  store i8 %.coerce, ptr %coerce.dive, align 1
  store ptr %__f, ptr %__f.addr, align 8
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  call void @"_ZZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEENK3$_0clEv"(ptr nonnull align 8 dereferenceable(24) %1) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal void @"_ZZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEENK3$_0clEv"(ptr nonnull align 8 dereferenceable(24) %this) #3 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds nuw %class.anon, ptr %this1, i32 0, i32 1
  %1 = load ptr, ptr %0, align 8
  %isnull = icmp eq ptr %1, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  call void @_ZN5clang13SourceManagerD1Ev(ptr nonnull align 8 dereferenceable(776) %1) #13
  call void @_ZdlPv(ptr %1) #15
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = getelementptr inbounds nuw %class.anon, ptr %this1, i32 0, i32 0
  %3 = load ptr, ptr %2, align 8
  %isnull2 = icmp eq ptr %3, null
  br i1 %isnull2, label %delete.end4, label %delete.notnull3

delete.notnull3:                                  ; preds = %delete.end
  call void @_ZN5clang17DiagnosticsEngineD1Ev(ptr nonnull align 8 dereferenceable(15256) %3) #13
  call void @_ZdlPv(ptr %3) #15
  br label %delete.end4

delete.end4:                                      ; preds = %delete.notnull3, %delete.end
  %4 = getelementptr inbounds nuw %class.anon, ptr %this1, i32 0, i32 2
  %5 = load ptr, ptr %4, align 8
  %isnull5 = icmp eq ptr %5, null
  br i1 %isnull5, label %delete.end7, label %delete.notnull6

delete.notnull6:                                  ; preds = %delete.end4
  call void @_ZN5clang11FileManagerD1Ev(ptr nonnull align 8 dereferenceable(716) %5) #13
  call void @_ZdlPv(ptr %5) #15
  br label %delete.end7

delete.end7:                                      ; preds = %delete.notnull6, %delete.end4
  ret void
}

; Function Attrs: convergent nounwind
declare dso_local void @_ZN5clang13SourceManagerD1Ev(ptr nonnull align 8 dereferenceable(776)) unnamed_addr #8

; Function Attrs: convergent nounwind
declare dso_local void @_ZN5clang17DiagnosticsEngineD1Ev(ptr nonnull align 8 dereferenceable(15256)) unnamed_addr #8

; Function Attrs: convergent nounwind
declare dso_local void @_ZN5clang11FileManagerD1Ev(ptr nonnull align 8 dereferenceable(716)) unnamed_addr #8

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal nonnull align 8 dereferenceable(8) ptr @"_ZNKSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERKT_v"(ptr nonnull align 8 dereferenceable(16) %this) #3 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNKSt9_Any_data9_M_accessEv(ptr nonnull align 8 dereferenceable(16) %this1) #13
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt9_Any_data9_M_accessEv(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %arrayidx = getelementptr inbounds [16 x i8], ptr %this1, i64 0, i64 0
  ret ptr %arrayidx
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSt9_Any_data9_M_accessIPKSt9type_infoEERT_v(ptr nonnull align 8 dereferenceable(16) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNSt9_Any_data9_M_accessEv(ptr nonnull align 8 dereferenceable(16) %this1) #13
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define internal zeroext i1 @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_managerERSt9_Any_dataRKS8_St18_Manager_operation"(ptr nonnull align 8 dereferenceable(16) %__dest, ptr nonnull align 8 dereferenceable(16) %__source, i32 %__op) #0 align 2 {
entry:
  %__dest.addr = alloca ptr, align 8
  %__source.addr = alloca ptr, align 8
  %__op.addr = alloca i32, align 4
  %agg.tmp = alloca %"struct.std::integral_constant", align 1
  store ptr %__dest, ptr %__dest.addr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  store i32 %__op, ptr %__op.addr, align 4
  %0 = load i32, ptr %__op.addr, align 4
  switch i32 %0, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
    i32 2, label %sw.bb4
    i32 3, label %sw.bb6
  ]

sw.bb:                                            ; preds = %entry
  %1 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt9_Any_data9_M_accessIPKSt9type_infoEERT_v(ptr nonnull align 8 dereferenceable(16) %1) #13
  store ptr @"_ZTIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0", ptr %call, align 8
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  %2 = load ptr, ptr %__source.addr, align 8, !nonnull !5, !align !6
  %call2 = call ptr @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E14_M_get_pointerERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %2) #13
  %3 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call3 = call nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %3) #13
  store ptr %call2, ptr %call3, align 8
  br label %sw.epilog

sw.bb4:                                           ; preds = %entry
  %4 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %5 = load ptr, ptr %__source.addr, align 8, !nonnull !5, !align !6
  %call5 = call ptr @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E14_M_get_pointerERKSt9_Any_data"(ptr nonnull align 8 dereferenceable(16) %5) #13
  call void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E15_M_init_functorIRKS6_EEvRSt9_Any_dataOT_"(ptr nonnull align 8 dereferenceable(16) %4, ptr nonnull align 8 dereferenceable(24) %call5) #11
  br label %sw.epilog

sw.bb6:                                           ; preds = %entry
  %6 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %agg.tmp, i32 0, i32 0
  %7 = load i8, ptr %coerce.dive, align 1
  call void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_destroyERSt9_Any_dataSt17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %6, i8 %7) #11
  br label %sw.epilog

sw.epilog:                                        ; preds = %entry, %sw.bb6, %sw.bb4, %sw.bb1, %sw.bb
  ret i1 false
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E15_M_init_functorIRKS6_EEvRSt9_Any_dataOT_"(ptr nonnull align 8 dereferenceable(16) %__functor, ptr nonnull align 8 dereferenceable(24) %__f) #0 align 2 {
entry:
  %__functor.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %agg.tmp = alloca %"struct.std::integral_constant", align 1
  store ptr %__functor, ptr %__functor.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %0 = load ptr, ptr %__functor.addr, align 8, !nonnull !5, !align !6
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %agg.tmp, i32 0, i32 0
  %2 = load i8, ptr %coerce.dive, align 1
  call void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_createIRKS6_EEvRSt9_Any_dataOT_St17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %0, ptr nonnull align 8 dereferenceable(24) %1, i8 %2) #11
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E10_M_destroyERSt9_Any_dataSt17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %__victim, i8 %.coerce) #3 align 2 {
entry:
  %0 = alloca %"struct.std::integral_constant", align 1
  %__victim.addr = alloca ptr, align 8
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %0, i32 0, i32 0
  store i8 %.coerce, ptr %coerce.dive, align 1
  store ptr %__victim, ptr %__victim.addr, align 8
  %1 = load ptr, ptr %__victim.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %1) #13
  %2 = load ptr, ptr %call, align 8
  %isnull = icmp eq ptr %2, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  call void @_ZdlPv(ptr %2) #15
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define internal void @"_ZNSt14_Function_base13_Base_managerIZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0E9_M_createIRKS6_EEvRSt9_Any_dataOT_St17integral_constantIbLb0EE"(ptr nonnull align 8 dereferenceable(16) %__dest, ptr nonnull align 8 dereferenceable(24) %__f, i8 %.coerce) #0 align 2 {
entry:
  %0 = alloca %"struct.std::integral_constant", align 1
  %__dest.addr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %coerce.dive = getelementptr inbounds nuw %"struct.std::integral_constant", ptr %0, i32 0, i32 0
  store i8 %.coerce, ptr %coerce.dive, align 1
  store ptr %__dest, ptr %__dest.addr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  %call = call noalias nonnull ptr @_Znwy(i64 24) #14
  %1 = load ptr, ptr %__f.addr, align 8, !nonnull !5, !align !6
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %call, ptr align 8 %1, i64 24, i1 false)
  %2 = load ptr, ptr %__dest.addr, align 8, !nonnull !5, !align !6
  %call1 = call nonnull align 8 dereferenceable(8) ptr @"_ZNSt9_Any_data9_M_accessIPZ11getCompilerN4llvm9StringRefEPN5clang18DiagnosticConsumerEE3$_0EERT_v"(ptr nonnull align 8 dereferenceable(16) %2) #13
  store ptr %call, ptr %call1, align 8
  ret void
}

attributes #0 = { convergent mustprogress noinline optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #1 = { convergent "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #2 = { convergent noreturn "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #3 = { convergent mustprogress noinline nounwind optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #4 = { convergent nobuiltin allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #5 = { convergent nobuiltin nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { convergent noinline noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #8 = { convergent nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #9 = { alwaysinline convergent mustprogress nounwind "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #10 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #11 = { convergent }
attributes #12 = { convergent noreturn }
attributes #13 = { convergent nounwind }
attributes #14 = { builtin convergent allocsize(0) }
attributes #15 = { builtin convergent nounwind }
attributes #16 = { noreturn nounwind }
attributes #17 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}
!llvm.ident = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 23.1.3", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug)
!1 = !DIFile(filename: "<stdin>", directory: "")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"clang version 23.1.3"}
!5 = !{}
!6 = !{i64 8}
