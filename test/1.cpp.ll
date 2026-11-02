; ModuleID = '1.cpp'
source_filename = "1.cpp"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-w64-windows-gnu"

%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type <{ ptr, i32, [4 x i8] }>
%"class.std::locale" = type { ptr }
%"class.llvm::StringRef" = type { ptr, i64 }
%"class.std::filesystem::__cxx11::path" = type { %"class.std::__cxx11::basic_string", %"struct.std::filesystem::__cxx11::path::_List" }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<wchar_t>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<wchar_t>::_Alloc_hider" = type { ptr }
%union.anon = type { i64, [8 x i8] }
%"struct.std::filesystem::__cxx11::path::_List" = type { %"class.std::unique_ptr" }
%"class.std::unique_ptr" = type { %"struct.std::__uniq_ptr_data" }
%"struct.std::__uniq_ptr_data" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Head_base.1" }
%"struct.std::_Head_base.1" = type { ptr }
%"class.llvm::raw_ostream" = type { ptr, i32, ptr, ptr, ptr, i8, i32 }
%"class.std::basic_string_view" = type { i64, ptr }
%"struct.std::filesystem::__cxx11::path::_Codecvt" = type { %"class.std::codecvt_utf8_utf16" }
%"class.std::codecvt_utf8_utf16" = type { %"class.std::__codecvt_utf8_utf16_base" }
%"class.std::__codecvt_utf8_utf16_base" = type { %"class.std::codecvt", i32, i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base.base", ptr }
%"class.std::__codecvt_abstract_base.base" = type { %"class.std::locale::facet.base" }
%"class.std::locale::facet.base" = type <{ ptr, i32 }>
%struct._Mbstatet = type { i32, i16, i16 }
%"class.std::__cxx11::basic_string.3" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon.7 }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { ptr }
%union.anon.7 = type { i64, [8 x i8] }
%"class.std::allocator.4" = type { i8 }
%"class.std::error_code" = type { i32, ptr }
%"class.std::allocator" = type { i8 }
%"struct.std::forward_iterator_tag" = type { i8 }
%struct._Guard = type { ptr }

$_ZNK5clang13AtomicOptions4dumpEv = comdat any

$_ZN4llvm11raw_ostreamlsEPKc = comdat any

$_ZN4llvm11raw_ostreamlsEj = comdat any

$_ZNSt10filesystem7__cxx114pathC1IA6_cS1_EERKT_NS1_6formatE = comdat any

$_ZNSt10filesystem7__cxx114pathD1Ev = comdat any

$_ZN4llvm11raw_ostreamlsENS_9StringRefE = comdat any

$_ZN4llvm9StringRefC1EPKc = comdat any

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

$_ZNSt10filesystem7__cxx114pathD2Ev = comdat any

$_ZNSt10filesystem7__cxx114path5_ListD1Ev = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev = comdat any

$_ZNSt10filesystem7__cxx114path5_ListD2Ev = comdat any

$_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED1Ev = comdat any

$_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED2Ev = comdat any

$_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE6_M_ptrEv = comdat any

$_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE11get_deleterEv = comdat any

$_ZSt3getILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_ = comdat any

$_ZSt12__get_helperILy0EPNSt10filesystem7__cxx114path5_List5_ImplEJNS3_13_Impl_deleterEEERT0_RSt11_Tuple_implIXT_EJS7_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEE7_M_headERS7_ = comdat any

$_ZNSt10_Head_baseILy0EPNSt10filesystem7__cxx114path5_List5_ImplELb0EE7_M_headERS6_ = comdat any

$_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE10_M_deleterEv = comdat any

$_ZSt3getILy1EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_ = comdat any

$_ZSt12__get_helperILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterEJEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILy1EJNSt10filesystem7__cxx114path5_List13_Impl_deleterEEE7_M_headERS5_ = comdat any

$_ZNSt10_Head_baseILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterELb1EE7_M_headERS5_ = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED2Ev = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD1Ev = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_is_localEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_destroyEy = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv = comdat any

$_ZNSt19__ptr_traits_ptr_toIPKwS0_Lb0EE10pointer_toERS0_ = comdat any

$_ZNSt16allocator_traitsISaIwEE10deallocateERS0_Pwy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv = comdat any

$_ZNSt15__new_allocatorIwE10deallocateEPwy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD2Ev = comdat any

$_ZNSt10filesystem7__cxx114pathC2IA6_cS1_EERKT_NS1_6formatE = comdat any

$_ZNSt10filesystem7__cxx114path10_S_convertISt17basic_string_viewIcSt11char_traitsIcEEEEDaT_ = comdat any

$_ZNSt10filesystem7__cxx118__detail17__effective_rangeIA6_cEEDaRKT_ = comdat any

$_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_ = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EvQ26is_default_constructible_vIT1_E = comdat any

$_ZNSt10filesystem7__cxx114path8_CodecvtIwEC1Ev = comdat any

$_ZSt20__str_codecvt_in_allIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_E = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EOS4_ = comdat any

$_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev = comdat any

$_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EvQ26is_default_constructible_vIT1_E = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC1EPwOS3_ = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_init_local_bufEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy = comdat any

$_ZNSt19__ptr_traits_ptr_toIPwwLb0EE10pointer_toERw = comdat any

$_ZNSt15__new_allocatorIwEC2Ev = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC2EPwOS3_ = comdat any

$_ZNSt15__new_allocatorIwEC2ERKS0_ = comdat any

$_ZNSt11char_traitsIwE6assignERwRKw = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_lengthEy = comdat any

$_ZNSt10filesystem7__cxx114path8_CodecvtIwEC2Ev = comdat any

$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EEC2Ey = comdat any

$_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev = comdat any

$_ZSt3minImERKT_S2_S2_ = comdat any

$_ZNSt25__codecvt_utf8_utf16_baseIwEC2EmSt12codecvt_modey = comdat any

$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev = comdat any

$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev = comdat any

$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED2Ev = comdat any

$_ZSt16__str_codecvt_inIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_ERSE_Ry = comdat any

$_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_ = comdat any

$_ZSt16__do_str_codecvtINSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEEcSt7codecvtIwc9_MbstatetES7_MS8_KFNSt12codecvt_base6resultERS7_PKcSD_RSD_PwSF_RSF_EEbPKT0_SL_RT_RKT1_RT2_RyT3_ = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5clearEv = comdat any

$_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE10max_lengthEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEy = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4backEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEyw = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6appendEyw = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE14_M_replace_auxEyyyw = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE15_M_check_lengthEyyPKc = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8capacityEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_moveEPwPKwy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_mutateEyyPKwy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_S_assignEPwyw = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv = comdat any

$_ZNSt16allocator_traitsISaIwEE8max_sizeERKS0_ = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv = comdat any

$_ZSt3minIyERKT_S2_S2_ = comdat any

$_ZNSt11char_traitsIwE4moveEPwPKwy = comdat any

$wmemmove = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_createERyy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_copyEPwPKwy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEPw = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_capacityEy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_S_allocateERS3_y = comdat any

$_ZNSt16allocator_traitsISaIwEE8allocateERS0_y = comdat any

$_ZNSt15__new_allocatorIwE8allocateEyPKv = comdat any

$_ZNKSt15__new_allocatorIwE11_M_max_sizeEv = comdat any

$_ZNSt11char_traitsIwE4copyEPwPKwy = comdat any

$wmemcpy = comdat any

$_ZNSt11char_traitsIwE6assignEPwyw = comdat any

$wmemset = comdat any

$_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5emptyEv = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EOS4_ = comdat any

$_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_use_local_dataEv = comdat any

$_ZNSt10filesystem7__cxx114path8_CodecvtIwED2Ev = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_ = comdat any

$_ZSt15make_error_codeSt4errc = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev = comdat any

$_ZNSt15__new_allocatorIcEC2Ev = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev = comdat any

$_ZNSt19__ptr_traits_ptr_toIPccLb0EE10pointer_toERc = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_ = comdat any

$_ZNSt15__new_allocatorIcEC2ERKS0_ = comdat any

$_ZSt8distanceIPKcENSt15iterator_traitsIT_E15difference_typeES3_S3_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERyy = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEy = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE17_M_init_local_bufEv = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsIPKcEEvPcT_S9_ = comdat any

$_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEy = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev = comdat any

$_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE8max_sizeEv = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_S_allocateERS3_y = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv = comdat any

$_ZNSt16allocator_traitsISaIcEE8max_sizeERKS0_ = comdat any

$_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv = comdat any

$_ZNSt16allocator_traitsISaIcEE8allocateERS0_y = comdat any

$_ZNSt15__new_allocatorIcE8allocateEyPKv = comdat any

$_ZNKSt15__new_allocatorIcE11_M_max_sizeEv = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_S_copyEPcPKcy = comdat any

$_ZSt12__niter_baseIPKcET_S2_ = comdat any

$_ZNSt11char_traitsIcE6assignERcRKc = comdat any

$_ZNSt11char_traitsIcE4copyEPcPKcy = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_lengthEy = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv = comdat any

$_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_is_localEv = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_destroyEy = comdat any

$_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv = comdat any

$_ZNSt19__ptr_traits_ptr_toIPKcS0_Lb0EE10pointer_toERS0_ = comdat any

$_ZNSt16allocator_traitsISaIcEE10deallocateERS0_Pcy = comdat any

$_ZNSt15__new_allocatorIcE10deallocateEPcy = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev = comdat any

$_ZNSt10error_codeC1EiRKNSt3_V214error_categoryE = comdat any

$_ZNSt10error_codeC2EiRKNSt3_V214error_categoryE = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev = comdat any

$_ZTVNSt10filesystem7__cxx114path8_CodecvtIwEE = comdat any

$_ZTINSt10filesystem7__cxx114path8_CodecvtIwEE = comdat any

$_ZTSNSt10filesystem7__cxx114path8_CodecvtIwEE = comdat any

$_ZTISt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = comdat any

$_ZTSSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = comdat any

$_ZTISt25__codecvt_utf8_utf16_baseIwE = comdat any

$_ZTSSt25__codecvt_utf8_utf16_baseIwE = comdat any

$_ZTISt7codecvtIwc9_MbstatetE = comdat any

$_ZTSSt7codecvtIwc9_MbstatetE = comdat any

$_ZTISt23__codecvt_abstract_baseIwc9_MbstatetE = comdat any

$_ZTSSt23__codecvt_abstract_baseIwc9_MbstatetE = comdat any

$_ZTINSt6locale5facetE = comdat any

$_ZTSNSt6locale5facetE = comdat any

$_ZTISt12codecvt_base = comdat any

$_ZTSSt12codecvt_base = comdat any

$_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = comdat any

$_ZTINSt10filesystem7__cxx1116filesystem_errorE = comdat any

$_ZTSNSt10filesystem7__cxx1116filesystem_errorE = comdat any

$_ZTISt12system_error = comdat any

$_ZTSSt12system_error = comdat any

$_ZTISt13runtime_error = comdat any

$_ZTSSt13runtime_error = comdat any

$_ZTISt9exception = comdat any

$_ZTSSt9exception = comdat any

@.str = private unnamed_addr constant [18 x i8] c"\0A remote_memory: \00", align 1
@.str.1 = private unnamed_addr constant [24 x i8] c"\0A fine_grained_memory: \00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"\0A ignore_denormal_mode: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"2.cpp\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"3.cpp\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str.6 = private unnamed_addr constant [14 x i8] c"test complete\00", align 1
@_ZTVNSt10filesystem7__cxx114path8_CodecvtIwEE = linkonce_odr dso_local constant { [11 x ptr] } { [11 x ptr] [ptr null, ptr @_ZTINSt10filesystem7__cxx114path8_CodecvtIwEE, ptr @_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev, ptr @_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE6do_outER9_MbstatetPKwS4_RS4_PcS6_RS6_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE10do_unshiftER9_MbstatetPcS3_RS3_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE5do_inER9_MbstatetPKcS4_RS4_PwS6_RS6_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE11do_encodingEv, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE16do_always_noconvEv, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE9do_lengthER9_MbstatetPKcS4_y, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE13do_max_lengthEv] }, comdat, align 8
@_ZTINSt10filesystem7__cxx114path8_CodecvtIwEE = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSNSt10filesystem7__cxx114path8_CodecvtIwEE, ptr @_ZTISt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE }, comdat, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global [0 x ptr]
@_ZTSNSt10filesystem7__cxx114path8_CodecvtIwEE = linkonce_odr dso_local constant [42 x i8] c"NSt10filesystem7__cxx114path8_CodecvtIwEE\00", comdat, align 1
@_ZTISt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE, ptr @_ZTISt25__codecvt_utf8_utf16_baseIwE }, comdat, align 8
@_ZTSSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = linkonce_odr dso_local constant [55 x i8] c"St18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE\00", comdat, align 1
@_ZTISt25__codecvt_utf8_utf16_baseIwE = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSSt25__codecvt_utf8_utf16_baseIwE, ptr @_ZTISt7codecvtIwc9_MbstatetE }, comdat, align 8
@_ZTSSt25__codecvt_utf8_utf16_baseIwE = linkonce_odr dso_local constant [33 x i8] c"St25__codecvt_utf8_utf16_baseIwE\00", comdat, align 1
@_ZTISt7codecvtIwc9_MbstatetE = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSSt7codecvtIwc9_MbstatetE, ptr @_ZTISt23__codecvt_abstract_baseIwc9_MbstatetE }, comdat, align 8
@_ZTSSt7codecvtIwc9_MbstatetE = linkonce_odr dso_local constant [25 x i8] c"St7codecvtIwc9_MbstatetE\00", comdat, align 1
@_ZTISt23__codecvt_abstract_baseIwc9_MbstatetE = linkonce_odr dso_local constant { ptr, ptr, i32, i32, ptr, i64, ptr, i64 } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv121__vmi_class_type_infoE, i64 2), ptr @_ZTSSt23__codecvt_abstract_baseIwc9_MbstatetE, i32 0, i32 2, ptr @_ZTINSt6locale5facetE, i64 2, ptr @_ZTISt12codecvt_base, i64 2 }, comdat, align 8
@_ZTVN10__cxxabiv121__vmi_class_type_infoE = external global [0 x ptr]
@_ZTSSt23__codecvt_abstract_baseIwc9_MbstatetE = linkonce_odr dso_local constant [42 x i8] c"St23__codecvt_abstract_baseIwc9_MbstatetE\00", comdat, align 1
@_ZTINSt6locale5facetE = linkonce_odr dso_local constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @_ZTSNSt6locale5facetE }, comdat, align 8
@_ZTVN10__cxxabiv117__class_type_infoE = external global [0 x ptr]
@_ZTSNSt6locale5facetE = linkonce_odr dso_local constant [18 x i8] c"NSt6locale5facetE\00", comdat, align 1
@_ZTISt12codecvt_base = linkonce_odr dso_local constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @_ZTSSt12codecvt_base }, comdat, align 8
@_ZTSSt12codecvt_base = linkonce_odr dso_local constant [17 x i8] c"St12codecvt_base\00", comdat, align 1
@_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE = linkonce_odr dso_local constant { [11 x ptr] } { [11 x ptr] [ptr null, ptr @_ZTISt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE, ptr @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev, ptr @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE6do_outER9_MbstatetPKwS4_RS4_PcS6_RS6_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE10do_unshiftER9_MbstatetPcS3_RS3_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE5do_inER9_MbstatetPKcS4_RS4_PwS6_RS6_, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE11do_encodingEv, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE16do_always_noconvEv, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE9do_lengthER9_MbstatetPKcS4_y, ptr @_ZNKSt25__codecvt_utf8_utf16_baseIwE13do_max_lengthEv] }, comdat, align 8
@_ZTVSt25__codecvt_utf8_utf16_baseIwE = external constant { [11 x ptr] }, align 8
@.str.7 = private unnamed_addr constant [29 x i8] c"basic_string::_M_replace_aux\00", align 1
@.str.8 = private unnamed_addr constant [24 x i8] c"basic_string::_M_create\00", align 1
@.str.9 = private unnamed_addr constant [56 x i8] c"C:\\msys64\\ucrt64\\include\\c++\\16.2.0/bits/basic_string.h\00", align 1
@__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv = private unnamed_addr constant [136 x i8] c"reference std::basic_string<wchar_t>::front() [_CharT = wchar_t, _Traits = std::char_traits<wchar_t>, _Alloc = std::allocator<wchar_t>]\00", align 1
@.str.10 = private unnamed_addr constant [9 x i8] c"!empty()\00", align 1
@__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy = private unnamed_addr constant [150 x i8] c"reference std::basic_string<wchar_t>::operator[](size_type) [_CharT = wchar_t, _Traits = std::char_traits<wchar_t>, _Alloc = std::allocator<wchar_t>]\00", align 1
@.str.11 = private unnamed_addr constant [16 x i8] c"__pos <= size()\00", align 1
@__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4backEv = private unnamed_addr constant [135 x i8] c"reference std::basic_string<wchar_t>::back() [_CharT = wchar_t, _Traits = std::char_traits<wchar_t>, _Alloc = std::allocator<wchar_t>]\00", align 1
@.str.12 = private unnamed_addr constant [34 x i8] c"Cannot convert character sequence\00", align 1
@_ZTINSt10filesystem7__cxx1116filesystem_errorE = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSNSt10filesystem7__cxx1116filesystem_errorE, ptr @_ZTISt12system_error }, comdat, align 8
@_ZTSNSt10filesystem7__cxx1116filesystem_errorE = linkonce_odr dso_local constant [43 x i8] c"NSt10filesystem7__cxx1116filesystem_errorE\00", comdat, align 1
@_ZTISt12system_error = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSSt12system_error, ptr @_ZTISt13runtime_error }, comdat, align 8
@_ZTSSt12system_error = linkonce_odr dso_local constant [17 x i8] c"St12system_error\00", comdat, align 1
@_ZTISt13runtime_error = linkonce_odr dso_local constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSSt13runtime_error, ptr @_ZTISt9exception }, comdat, align 8
@_ZTSSt13runtime_error = linkonce_odr dso_local constant [18 x i8] c"St13runtime_error\00", comdat, align 1
@_ZTISt9exception = linkonce_odr dso_local constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @_ZTSSt9exception }, comdat, align 8
@_ZTSSt9exception = linkonce_odr dso_local constant [13 x i8] c"St9exception\00", comdat, align 1
@.str.13 = private unnamed_addr constant [50 x i8] c"basic_string: construction from null is not valid\00", align 1
@llvm.used = appending global [2 x ptr] [ptr @_ZNK5clang13AtomicOptions4dumpEv, ptr @_ZNK5clang13AtomicOptions4dumpEv], section "llvm.metadata"

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNK5clang13AtomicOptions4dumpEv(ptr nonnull align 4 dereferenceable(4) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call nonnull align 8 dereferenceable(104) ptr @_ZN4llvm4errsEv() #17
  %call2 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call, ptr @.str) #17
  %bf.load = load i32, ptr %this1, align 4
  %bf.clear = and i32 %bf.load, 1
  %call3 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call2, i32 %bf.clear) #17
  %call4 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call3, ptr @.str.1) #17
  %bf.load5 = load i32, ptr %this1, align 4
  %bf.lshr = lshr i32 %bf.load5, 1
  %bf.clear6 = and i32 %bf.lshr, 1
  %call7 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call4, i32 %bf.clear6) #17
  %call8 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call7, ptr @.str.2) #17
  %bf.load9 = load i32, ptr %this1, align 4
  %bf.lshr10 = lshr i32 %bf.load9, 2
  %bf.clear11 = and i32 %bf.lshr10, 1
  %call12 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEj(ptr nonnull align 8 dereferenceable(48) %call8, i32 %bf.clear11) #17
  %call13 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEPKc(ptr nonnull align 8 dereferenceable(48) %call12, ptr @.str.3) #17
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
  call void @_ZN4llvm9StringRefC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.tmp, ptr %0) #17
  %call = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsENS_9StringRefE(ptr nonnull align 8 dereferenceable(48) %this1, ptr align 8 dead_on_return %agg.tmp) #17
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
  %call = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEm(ptr nonnull align 8 dereferenceable(48) %this1, i32 %0) #17
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline norecurse optnone
define dso_local i32 @main(i32 %argc, ptr %argv) #2 personality ptr @__gxx_personality_seh0 {
entry:
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 8
  %agg.tmp = alloca %"class.std::filesystem::__cxx11::path", align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %agg.tmp1 = alloca %"class.std::filesystem::__cxx11::path", align 8
  store i32 %argc, ptr %argc.addr, align 4
  store ptr %argv, ptr %argv.addr, align 8
  call void @_ZNSt10filesystem7__cxx114pathC1IA6_cS1_EERKT_NS1_6formatE(ptr nonnull align 8 dereferenceable(40) %agg.tmp, ptr nonnull align 1 dereferenceable(6) @.str.4, i8 2) #17
  %call = invoke ptr @_ZN5dmcre4load3cxx9ToProcessENS0_6DomainENSt10filesystem7__cxx114pathE(i32 1, ptr align 8 %agg.tmp) #17
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  call void @_ZNSt10filesystem7__cxx114pathD1Ev(ptr nonnull align 8 dereferenceable(40) %agg.tmp) #18
  call void @_ZNSt10filesystem7__cxx114pathC1IA6_cS1_EERKT_NS1_6formatE(ptr nonnull align 8 dereferenceable(40) %agg.tmp1, ptr nonnull align 1 dereferenceable(6) @.str.5, i8 2) #17
  %call4 = invoke ptr @_ZN5dmcre4load3cxx9ToProcessENS0_6DomainENSt10filesystem7__cxx114pathE(i32 1, ptr align 8 %agg.tmp1) #17
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %invoke.cont
  call void @_ZNSt10filesystem7__cxx114pathD1Ev(ptr nonnull align 8 dereferenceable(40) %agg.tmp1) #18
  %call5 = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr @.str.6) #17
  %call6 = call nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8) %call5, ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_) #17
  ret i32 0

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = extractvalue { ptr, i32 } %0, 0
  store ptr %1, ptr %exn.slot, align 8
  %2 = extractvalue { ptr, i32 } %0, 1
  store i32 %2, ptr %ehselector.slot, align 4
  call void @_ZNSt10filesystem7__cxx114pathD1Ev(ptr nonnull align 8 dereferenceable(40) %agg.tmp) #18
  br label %eh.resume

lpad2:                                            ; preds = %invoke.cont
  %3 = landingpad { ptr, i32 }
          cleanup
  %4 = extractvalue { ptr, i32 } %3, 0
  store ptr %4, ptr %exn.slot, align 8
  %5 = extractvalue { ptr, i32 } %3, 1
  store i32 %5, ptr %ehselector.slot, align 4
  call void @_ZNSt10filesystem7__cxx114pathD1Ev(ptr nonnull align 8 dereferenceable(40) %agg.tmp1) #18
  br label %eh.resume

eh.resume:                                        ; preds = %lpad2, %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val7 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val7
}

; Function Attrs: convergent
declare dllimport ptr @_ZN5dmcre4load3cxx9ToProcessENS0_6DomainENSt10filesystem7__cxx114pathE(i32, ptr align 8) #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114pathC1IA6_cS1_EERKT_NS1_6formatE(ptr nonnull align 8 dereferenceable(40) %this, ptr nonnull align 1 dereferenceable(6) %__source, i8 %0) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__source.addr = alloca ptr, align 8
  %.addr = alloca i8, align 1
  store ptr %this, ptr %this.addr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  store i8 %0, ptr %.addr, align 1
  %this1 = load ptr, ptr %this.addr, align 8
  %1 = load ptr, ptr %__source.addr, align 8
  %2 = load i8, ptr %.addr, align 1
  call void @_ZNSt10filesystem7__cxx114pathC2IA6_cS1_EERKT_NS1_6formatE(ptr nonnull align 8 dereferenceable(40) %this1, ptr nonnull align 1 dereferenceable(6) %1, i8 %2) #17
  ret void
}

declare dso_local i32 @__gxx_personality_seh0(...)

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114pathD1Ev(ptr nonnull align 8 dereferenceable(40) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10filesystem7__cxx114pathD2Ev(ptr nonnull align 8 dereferenceable(40) %this1) #18
  ret void
}

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8), ptr) #1

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8), ptr) #1

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(ptr nonnull align 8 dereferenceable(8)) #1

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
  %call = call i64 @_ZNK4llvm9StringRef4sizeEv(ptr nonnull align 8 dereferenceable(16) %Str) #17
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
  %call2 = call ptr @_ZNK4llvm9StringRef4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #17
  %3 = load i64, ptr %Size, align 8
  %call3 = call nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostream5writeEPKcy(ptr nonnull align 8 dereferenceable(48) %this1, ptr %call2, i64 %3) #17
  store ptr %call3, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %4 = load i64, ptr %Size, align 8
  %tobool = icmp ne i64 %4, 0
  br i1 %tobool, label %if.then4, label %if.end8

if.then4:                                         ; preds = %if.end
  %OutBufCur5 = getelementptr inbounds nuw %"class.llvm::raw_ostream", ptr %this1, i32 0, i32 4
  %5 = load ptr, ptr %OutBufCur5, align 8
  %call6 = call ptr @_ZNK4llvm9StringRef4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #17
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
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.tmp, ptr %1) #18
  br label %cond.end

cond.false:                                       ; preds = %entry
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1Ev(ptr nonnull align 8 dereferenceable(16) %agg.tmp) #18
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  call void @_ZN4llvm9StringRefC1ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this1, ptr align 8 dead_on_return %agg.tmp) #17
  ret void
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
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #4

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc(ptr nonnull align 8 dereferenceable(16) %this, ptr nonnull %__str) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__str.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__str, ptr %__str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__str.addr, align 8
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2EPKc(ptr nonnull align 8 dereferenceable(16) %this1, ptr %0) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1Ev(ptr nonnull align 8 dereferenceable(16) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC2Ev(ptr nonnull align 8 dereferenceable(16) %this1) #18
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
  call void @_ZN4llvm9StringRefC2ESt17basic_string_viewIcSt11char_traitsIcEE(ptr nonnull align 8 dereferenceable(16) %this1, ptr align 8 dead_on_return %Str) #17
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
  %call = invoke i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr %0) #17
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
  call void @__clang_call_terminate(ptr %3) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr %__s) #3 comdat align 2 {
entry:
  %__s.addr = alloca ptr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  %0 = load ptr, ptr %__s.addr, align 8
  %call = call i64 @strlen(ptr %0) #18
  ret i64 %call
}

; Function Attrs: convergent noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(ptr %0) #5 comdat {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #20
  call void @_ZSt9terminatev() #19
  unreachable
}

declare dso_local ptr @__cxa_begin_catch(ptr)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: convergent nounwind
declare dso_local i64 @strlen(ptr) #6

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
  %call = call ptr @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv(ptr nonnull align 8 dereferenceable(16) %Str) #18
  store ptr %call, ptr %Data, align 8
  %Length = getelementptr inbounds nuw %"class.llvm::StringRef", ptr %this1, i32 0, i32 1
  %call2 = call i64 @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4sizeEv(ptr nonnull align 8 dereferenceable(16) %Str) #18
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

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(48) ptr @_ZN4llvm11raw_ostreamlsEm(ptr nonnull align 8 dereferenceable(48), i32) #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114pathD2Ev(ptr nonnull align 8 dereferenceable(40) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_cmpts = getelementptr inbounds nuw %"class.std::filesystem::__cxx11::path", ptr %this1, i32 0, i32 1
  call void @_ZNSt10filesystem7__cxx114path5_ListD1Ev(ptr nonnull align 8 dereferenceable(8) %_M_cmpts) #18
  %_M_pathname = getelementptr inbounds nuw %"class.std::filesystem::__cxx11::path", ptr %this1, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev(ptr nonnull align 8 dereferenceable(32) %_M_pathname) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path5_ListD1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10filesystem7__cxx114path5_ListD2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path5_ListD2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_impl = getelementptr inbounds nuw %"struct.std::filesystem::__cxx11::path::_List", ptr %this1, i32 0, i32 0
  call void @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED1Ev(ptr nonnull align 8 dereferenceable(8) %_M_impl) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEED2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__ptr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_t = getelementptr inbounds nuw %"class.std::unique_ptr", ptr %this1, i32 0, i32 0
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE6_M_ptrEv(ptr nonnull align 8 dereferenceable(8) %_M_t) #18
  store ptr %call, ptr %__ptr, align 8
  %0 = load ptr, ptr %__ptr, align 8, !nonnull !5, !align !6
  %1 = load ptr, ptr %0, align 8
  %cmp = icmp ne ptr %1, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call nonnull align 1 dereferenceable(1) ptr @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE11get_deleterEv(ptr nonnull align 8 dereferenceable(8) %this1) #18
  %2 = load ptr, ptr %__ptr, align 8, !nonnull !5, !align !6
  %3 = load ptr, ptr %2, align 8
  call void @_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE(ptr nonnull align 1 dereferenceable(1) %call2, ptr %3) #18
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %4 = load ptr, ptr %__ptr, align 8, !nonnull !5, !align !6
  store ptr null, ptr %4, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE6_M_ptrEv(ptr nonnull align 8 dereferenceable(8) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_t = getelementptr inbounds nuw %"class.std::__uniq_ptr_impl", ptr %this1, i32 0, i32 0
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZSt3getILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_(ptr nonnull align 8 dereferenceable(8) %_M_t) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt10unique_ptrINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE11get_deleterEv(ptr nonnull align 8 dereferenceable(8) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_t = getelementptr inbounds nuw %"class.std::unique_ptr", ptr %this1, i32 0, i32 0
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE10_M_deleterEv(ptr nonnull align 8 dereferenceable(8) %_M_t) #18
  ret ptr %call
}

; Function Attrs: convergent nounwind
declare dso_local void @_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE(ptr nonnull align 1 dereferenceable(1), ptr) #6

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZSt3getILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_(ptr nonnull align 8 dereferenceable(8) %__t) #3 comdat {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZSt12__get_helperILy0EPNSt10filesystem7__cxx114path5_List5_ImplEJNS3_13_Impl_deleterEEERT0_RSt11_Tuple_implIXT_EJS7_DpT1_EE(ptr nonnull align 8 dereferenceable(8) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZSt12__get_helperILy0EPNSt10filesystem7__cxx114path5_List5_ImplEJNS3_13_Impl_deleterEEERT0_RSt11_Tuple_implIXT_EJS7_DpT1_EE(ptr nonnull align 8 dereferenceable(8) %__t) #3 comdat {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt11_Tuple_implILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEE7_M_headERS7_(ptr nonnull align 8 dereferenceable(8) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSt11_Tuple_implILy0EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEE7_M_headERS7_(ptr nonnull align 8 dereferenceable(8) %__t) #3 comdat align 2 {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt10_Head_baseILy0EPNSt10filesystem7__cxx114path5_List5_ImplELb0EE7_M_headERS6_(ptr nonnull align 8 dereferenceable(8) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSt10_Head_baseILy0EPNSt10filesystem7__cxx114path5_List5_ImplELb0EE7_M_headERS6_(ptr nonnull align 8 dereferenceable(8) %__b) #3 comdat align 2 {
entry:
  %__b.addr = alloca ptr, align 8
  store ptr %__b, ptr %__b.addr, align 8
  %0 = load ptr, ptr %__b.addr, align 8, !nonnull !5, !align !6
  %_M_head_impl = getelementptr inbounds nuw %"struct.std::_Head_base.1", ptr %0, i32 0, i32 0
  ret ptr %_M_head_impl
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt15__uniq_ptr_implINSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEE10_M_deleterEv(ptr nonnull align 8 dereferenceable(8) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_t = getelementptr inbounds nuw %"class.std::__uniq_ptr_impl", ptr %this1, i32 0, i32 0
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZSt3getILy1EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_(ptr nonnull align 8 dereferenceable(8) %_M_t) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZSt3getILy1EJPNSt10filesystem7__cxx114path5_List5_ImplENS3_13_Impl_deleterEEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSB_(ptr nonnull align 8 dereferenceable(8) %__t) #3 comdat {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5, !align !6
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZSt12__get_helperILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterEJEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE(ptr nonnull align 1 dereferenceable(1) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZSt12__get_helperILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterEJEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE(ptr nonnull align 1 dereferenceable(1) %__t) #3 comdat {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZNSt11_Tuple_implILy1EJNSt10filesystem7__cxx114path5_List13_Impl_deleterEEE7_M_headERS5_(ptr nonnull align 1 dereferenceable(1) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt11_Tuple_implILy1EJNSt10filesystem7__cxx114path5_List13_Impl_deleterEEE7_M_headERS5_(ptr nonnull align 1 dereferenceable(1) %__t) #3 comdat align 2 {
entry:
  %__t.addr = alloca ptr, align 8
  store ptr %__t, ptr %__t.addr, align 8
  %0 = load ptr, ptr %__t.addr, align 8, !nonnull !5
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZNSt10_Head_baseILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterELb1EE7_M_headERS5_(ptr nonnull align 1 dereferenceable(1) %0) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt10_Head_baseILy1ENSt10filesystem7__cxx114path5_List13_Impl_deleterELb1EE7_M_headERS5_(ptr nonnull align 1 dereferenceable(1) %__b) #3 comdat align 2 {
entry:
  %__b.addr = alloca ptr, align 8
  store ptr %__b, ptr %__b.addr, align 8
  %0 = load ptr, ptr %__b.addr, align 8, !nonnull !5
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD1Ev(ptr nonnull align 8 dereferenceable(8) %_M_dataplus) #18
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  br i1 %call, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  %1 = load i64, ptr %0, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_destroyEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %1) #18
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %this) #0 comdat align 2 {
entry:
  %retval = alloca i1, align 1
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %call2 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %cmp = icmp eq ptr %call, %call2
  br i1 %cmp, label %if.then, label %if.end5

if.then:                                          ; preds = %entry
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 1
  %0 = load i64, ptr %_M_string_length, align 8
  %cmp3 = icmp ugt i64 %0, 7
  br i1 %cmp3, label %if.then4, label %if.end

if.then4:                                         ; preds = %if.then
  unreachable

if.end:                                           ; preds = %if.then
  store i1 true, ptr %retval, align 1
  br label %return

if.end5:                                          ; preds = %entry
  store i1 false, ptr %retval, align 1
  br label %return

return:                                           ; preds = %if.end5, %if.end
  %1 = load i1, ptr %retval, align 1
  ret i1 %1
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_destroyEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__size) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__size.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__size, ptr %__size.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = invoke nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %call2 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load i64, ptr %__size.addr, align 8
  %add = add i64 %0, 1
  invoke void @_ZNSt16allocator_traitsISaIwEE10deallocateERS0_Pwy(ptr nonnull align 1 dereferenceable(1) %call, ptr %call2, i64 %add) #17
          to label %invoke.cont3 unwind label %terminate.lpad

invoke.cont3:                                     ; preds = %invoke.cont
  ret void

terminate.lpad:                                   ; preds = %invoke.cont, %entry
  %1 = landingpad { ptr, i32 }
          catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  call void @__clang_call_terminate(ptr %2) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<wchar_t>::_Alloc_hider", ptr %_M_dataplus, i32 0, i32 0
  %0 = load ptr, ptr %_M_p, align 8
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  %arraydecay = getelementptr inbounds [8 x i16], ptr %0, i64 0, i64 0
  %call = call ptr @_ZNSt19__ptr_traits_ptr_toIPKwS0_Lb0EE10pointer_toERS0_(ptr nonnull align 2 dereferenceable(2) %arraydecay) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt19__ptr_traits_ptr_toIPKwS0_Lb0EE10pointer_toERS0_(ptr nonnull align 2 dereferenceable(2) %__r) #3 comdat align 2 {
entry:
  %__r.addr = alloca ptr, align 8
  store ptr %__r, ptr %__r.addr, align 8
  %0 = load ptr, ptr %__r.addr, align 8, !nonnull !5, !align !7
  ret ptr %0
}

; Function Attrs: alwaysinline convergent mustprogress
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaIwEE10deallocateERS0_Pwy(ptr nonnull align 1 dereferenceable(1) %__a, ptr %__p, i64 %__n) #7 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load ptr, ptr %__p.addr, align 8
  %2 = load i64, ptr %__n.addr, align 8
  call void @_ZNSaIwE10deallocateEPwy(ptr nonnull align 1 dereferenceable(1) %0, ptr %1, i64 %2) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  ret ptr %_M_dataplus
}

; Function Attrs: alwaysinline convergent mustprogress
define available_externally dso_local void @_ZNSaIwE10deallocateEPwy(ptr nonnull align 1 dereferenceable(1) %this, ptr %__p, i64 %__n) #7 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  %1 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt15__new_allocatorIwE10deallocateEPwy(ptr nonnull align 1 dereferenceable(1) %this1, ptr %0, i64 %1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIwE10deallocateEPwy(ptr nonnull align 1 dereferenceable(1) %this, ptr %__p, i64 %__n) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  call void @_ZdlPv(ptr %0) #21
  ret void
}

; Function Attrs: convergent nobuiltin nounwind
declare dso_local void @_ZdlPv(ptr) #8

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderD2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIwED2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIwED2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114pathC2IA6_cS1_EERKT_NS1_6formatE(ptr nonnull align 8 dereferenceable(40) %this, ptr nonnull align 1 dereferenceable(6) %__source, i8 %0) unnamed_addr #0 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__source.addr = alloca ptr, align 8
  %.addr = alloca i8, align 1
  %agg.tmp = alloca %"class.std::basic_string_view", align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  store i8 %0, ptr %.addr, align 1
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_pathname = getelementptr inbounds nuw %"class.std::filesystem::__cxx11::path", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %__source.addr, align 8, !nonnull !5
  call void @_ZNSt10filesystem7__cxx118__detail17__effective_rangeIA6_cEEDaRKT_(ptr dead_on_unwind writable sret(%"class.std::basic_string_view") align 8 %agg.tmp, ptr nonnull align 1 dereferenceable(6) %1) #17
  call void @_ZNSt10filesystem7__cxx114path10_S_convertISt17basic_string_viewIcSt11char_traitsIcEEEEDaT_(ptr dead_on_unwind writable sret(%"class.std::__cxx11::basic_string") align 8 %_M_pathname, ptr align 8 dead_on_return %agg.tmp) #17
  %_M_cmpts = getelementptr inbounds nuw %"class.std::filesystem::__cxx11::path", ptr %this1, i32 0, i32 1
  invoke void @_ZNSt10filesystem7__cxx114path5_ListC1Ev(ptr nonnull align 8 dereferenceable(8) %_M_cmpts) #17
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  invoke void @_ZNSt10filesystem7__cxx114path14_M_split_cmptsEv(ptr nonnull align 8 dereferenceable(40) %this1) #17
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %invoke.cont
  ret void

lpad:                                             ; preds = %entry
  %2 = landingpad { ptr, i32 }
          cleanup
  %3 = extractvalue { ptr, i32 } %2, 0
  store ptr %3, ptr %exn.slot, align 8
  %4 = extractvalue { ptr, i32 } %2, 1
  store i32 %4, ptr %ehselector.slot, align 4
  br label %ehcleanup

lpad2:                                            ; preds = %invoke.cont
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = extractvalue { ptr, i32 } %5, 0
  store ptr %6, ptr %exn.slot, align 8
  %7 = extractvalue { ptr, i32 } %5, 1
  store i32 %7, ptr %ehselector.slot, align 4
  call void @_ZNSt10filesystem7__cxx114path5_ListD1Ev(ptr nonnull align 8 dereferenceable(8) %_M_cmpts) #18
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad2, %lpad
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev(ptr nonnull align 8 dereferenceable(32) %_M_pathname) #18
  br label %eh.resume

eh.resume:                                        ; preds = %ehcleanup
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val4 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val4
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path10_S_convertISt17basic_string_viewIcSt11char_traitsIcEEEEDaT_(ptr dead_on_unwind noalias writable sret(%"class.std::__cxx11::basic_string") align 8 %agg.result, ptr align 8 dead_on_return %__str) #0 comdat align 2 {
entry:
  %result.ptr = alloca ptr, align 8
  %__str.indirect_addr = alloca ptr, align 8
  store ptr %agg.result, ptr %result.ptr, align 8
  store ptr %__str, ptr %__str.indirect_addr, align 8
  %call = call ptr @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv(ptr nonnull align 8 dereferenceable(16) %__str) #18
  %call1 = call ptr @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4dataEv(ptr nonnull align 8 dereferenceable(16) %__str) #18
  %call2 = call i64 @_ZNKSt17basic_string_viewIcSt11char_traitsIcEE4sizeEv(ptr nonnull align 8 dereferenceable(16) %__str) #18
  %add.ptr = getelementptr inbounds nuw i8, ptr %call1, i64 %call2
  call void @_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_(ptr dead_on_unwind writable sret(%"class.std::__cxx11::basic_string") align 8 %agg.result, ptr %call, ptr %add.ptr) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx118__detail17__effective_rangeIA6_cEEDaRKT_(ptr dead_on_unwind noalias writable sret(%"class.std::basic_string_view") align 8 %agg.result, ptr nonnull align 1 dereferenceable(6) %__source) #3 comdat {
entry:
  %result.ptr = alloca ptr, align 8
  %__source.addr = alloca ptr, align 8
  store ptr %agg.result, ptr %result.ptr, align 8
  store ptr %__source, ptr %__source.addr, align 8
  %0 = load ptr, ptr %__source.addr, align 8, !nonnull !5
  %arraydecay = getelementptr inbounds [6 x i8], ptr %0, i64 0, i64 0
  call void @_ZNSt17basic_string_viewIcSt11char_traitsIcEEC1EPKc(ptr nonnull align 8 dereferenceable(16) %agg.result, ptr %arraydecay) #18
  ret void
}

; Function Attrs: convergent
declare dso_local void @_ZNSt10filesystem7__cxx114path5_ListC1Ev(ptr nonnull align 8 dereferenceable(8)) unnamed_addr #1

; Function Attrs: convergent
declare dso_local void @_ZNSt10filesystem7__cxx114path14_M_split_cmptsEv(ptr nonnull align 8 dereferenceable(40)) #1

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_(ptr dead_on_unwind noalias writable sret(%"class.std::__cxx11::basic_string") align 8 %agg.result, ptr %__f, ptr %__l) #0 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %result.ptr = alloca ptr, align 8
  %__f.addr = alloca ptr, align 8
  %__l.addr = alloca ptr, align 8
  %__wstr = alloca %"class.std::__cxx11::basic_string", align 8
  %__cvt = alloca %"struct.std::filesystem::__cxx11::path::_Codecvt", align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %cleanup.dest.slot = alloca i32, align 4
  store ptr %agg.result, ptr %result.ptr, align 8
  store ptr %__f, ptr %__f.addr, align 8
  store ptr %__l, ptr %__l.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EvQ26is_default_constructible_vIT1_E(ptr nonnull align 8 dereferenceable(32) %__wstr) #18
  invoke void @_ZNSt10filesystem7__cxx114path8_CodecvtIwEC1Ev(ptr nonnull align 8 dereferenceable(32) %__cvt) #17
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %0 = load ptr, ptr %__f.addr, align 8
  %1 = load ptr, ptr %__l.addr, align 8
  %call = invoke zeroext i1 @_ZSt20__str_codecvt_in_allIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_E(ptr %0, ptr %1, ptr nonnull align 8 dereferenceable(32) %__wstr, ptr nonnull align 8 dereferenceable(24) %__cvt) #17
          to label %invoke.cont2 unwind label %lpad1

invoke.cont2:                                     ; preds = %invoke.cont
  br i1 %call, label %if.then, label %if.end

if.then:                                          ; preds = %invoke.cont2
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EOS4_(ptr nonnull align 8 dereferenceable(32) %agg.result, ptr nonnull align 8 dereferenceable(32) %__wstr) #18
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

lpad:                                             ; preds = %entry
  %2 = landingpad { ptr, i32 }
          cleanup
  %3 = extractvalue { ptr, i32 } %2, 0
  store ptr %3, ptr %exn.slot, align 8
  %4 = extractvalue { ptr, i32 } %2, 1
  store i32 %4, ptr %ehselector.slot, align 4
  br label %ehcleanup

lpad1:                                            ; preds = %invoke.cont
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = extractvalue { ptr, i32 } %5, 0
  store ptr %6, ptr %exn.slot, align 8
  %7 = extractvalue { ptr, i32 } %5, 1
  store i32 %7, ptr %ehselector.slot, align 4
  call void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev(ptr nonnull align 8 dereferenceable(32) %__cvt) #18
  br label %ehcleanup

if.end:                                           ; preds = %invoke.cont2
  store i32 0, ptr %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  call void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev(ptr nonnull align 8 dereferenceable(32) %__cvt) #18
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev(ptr nonnull align 8 dereferenceable(32) %__wstr) #18
  %cleanup.dest = load i32, ptr %cleanup.dest.slot, align 4
  switch i32 %cleanup.dest, label %unreachable [
    i32 0, label %cleanup.cont
    i32 1, label %return
  ]

cleanup.cont:                                     ; preds = %cleanup
  call void @_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv() #22
  unreachable

ehcleanup:                                        ; preds = %lpad1, %lpad
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEED1Ev(ptr nonnull align 8 dereferenceable(32) %__wstr) #18
  br label %eh.resume

return:                                           ; preds = %cleanup
  ret void

eh.resume:                                        ; preds = %ehcleanup
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val4 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val4

unreachable:                                      ; preds = %cleanup
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EvQ26is_default_constructible_vIT1_E(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EvQ26is_default_constructible_vIT1_E(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path8_CodecvtIwEC1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10filesystem7__cxx114path8_CodecvtIwEC2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local zeroext i1 @_ZSt20__str_codecvt_in_allIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_E(ptr %__first, ptr %__last, ptr nonnull align 8 dereferenceable(32) %__outstr, ptr nonnull align 8 dereferenceable(24) %__cvt) #0 comdat {
entry:
  %__first.addr = alloca ptr, align 8
  %__last.addr = alloca ptr, align 8
  %__outstr.addr = alloca ptr, align 8
  %__cvt.addr = alloca ptr, align 8
  %__state = alloca %struct._Mbstatet, align 4
  %__n = alloca i64, align 8
  store ptr %__first, ptr %__first.addr, align 8
  store ptr %__last, ptr %__last.addr, align 8
  store ptr %__outstr, ptr %__outstr.addr, align 8
  store ptr %__cvt, ptr %__cvt.addr, align 8
  call void @llvm.memset.p0.i64(ptr align 4 %__state, i8 0, i64 8, i1 false)
  %0 = load ptr, ptr %__first.addr, align 8
  %1 = load ptr, ptr %__last.addr, align 8
  %2 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %3 = load ptr, ptr %__cvt.addr, align 8, !nonnull !5, !align !6
  %call = call zeroext i1 @_ZSt16__str_codecvt_inIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_ERSE_Ry(ptr %0, ptr %1, ptr nonnull align 8 dereferenceable(32) %2, ptr nonnull align 8 dereferenceable(24) %3, ptr nonnull align 4 dereferenceable(8) %__state, ptr nonnull align 8 dereferenceable(8) %__n) #17
  br i1 %call, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %4 = load i64, ptr %__n, align 8
  %5 = load ptr, ptr %__last.addr, align 8
  %6 = load ptr, ptr %__first.addr, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %5 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %6 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %cmp = icmp eq i64 %4, %sub.ptr.sub
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %7 = phi i1 [ false, %entry ], [ %cmp, %land.rhs ]
  ret i1 %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC1EOS4_(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(32) %__str) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__str.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__str, ptr %__str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__str.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EOS4_(ptr nonnull align 8 dereferenceable(32) %this1, ptr nonnull align 8 dereferenceable(32) %0) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline noreturn optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv() #10 comdat personality ptr @__gxx_personality_seh0 {
entry:
  %ref.tmp = alloca %"class.std::__cxx11::basic_string.3", align 8
  %ref.tmp1 = alloca %"class.std::allocator.4", align 1
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %agg.tmp = alloca %"class.std::error_code", align 8
  %cleanup.isactive = alloca i1, align 1
  store i1 true, ptr %cleanup.isactive, align 1
  %exception = call ptr @__cxa_allocate_exception(i64 48) #20
  call void @_ZNSaIcEC1Ev(ptr nonnull align 1 dereferenceable(1) %ref.tmp1) #18
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_(ptr nonnull align 8 dereferenceable(32) %ref.tmp, ptr @.str.12, ptr nonnull align 1 dereferenceable(1) %ref.tmp1) #17
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  call void @_ZSt15make_error_codeSt4errc(ptr dead_on_unwind writable sret(%"class.std::error_code") align 8 %agg.tmp, i32 42) #18
  invoke void @_ZNSt10filesystem7__cxx1116filesystem_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt10error_code(ptr nonnull align 8 dereferenceable(48) %exception, ptr nonnull align 8 dereferenceable(32) %ref.tmp, ptr align 8 dead_on_return %agg.tmp) #17
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %invoke.cont
  store i1 false, ptr %cleanup.isactive, align 1
  invoke void @__cxa_throw(ptr %exception, ptr @_ZTINSt10filesystem7__cxx1116filesystem_errorE, ptr @_ZNSt10filesystem7__cxx1116filesystem_errorD1Ev) #23
          to label %unreachable unwind label %lpad2

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = extractvalue { ptr, i32 } %0, 0
  store ptr %1, ptr %exn.slot, align 8
  %2 = extractvalue { ptr, i32 } %0, 1
  store i32 %2, ptr %ehselector.slot, align 4
  br label %ehcleanup

lpad2:                                            ; preds = %invoke.cont3, %invoke.cont
  %3 = landingpad { ptr, i32 }
          cleanup
  %4 = extractvalue { ptr, i32 } %3, 0
  store ptr %4, ptr %exn.slot, align 8
  %5 = extractvalue { ptr, i32 } %3, 1
  store i32 %5, ptr %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr nonnull align 8 dereferenceable(32) %ref.tmp) #18
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad2, %lpad
  call void @_ZNSaIcED1Ev(ptr nonnull align 1 dereferenceable(1) %ref.tmp1) #18
  %cleanup.is_active = load i1, ptr %cleanup.isactive, align 1
  br i1 %cleanup.is_active, label %cleanup.action, label %cleanup.done

cleanup.action:                                   ; preds = %ehcleanup
  call void @__cxa_free_exception(ptr %exception) #20
  br label %cleanup.done

cleanup.done:                                     ; preds = %cleanup.action, %ehcleanup
  br label %eh.resume

eh.resume:                                        ; preds = %cleanup.done
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val5 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val5

unreachable:                                      ; preds = %invoke.cont3
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EvQ26is_default_constructible_vIT1_E(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %ref.tmp = alloca %"class.std::allocator", align 1
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  %call = invoke ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  call void @_ZNSaIwEC1Ev(ptr nonnull align 1 dereferenceable(1) %ref.tmp) #18
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC1EPwOS3_(ptr nonnull align 8 dereferenceable(8) %_M_dataplus, ptr %call, ptr nonnull align 1 dereferenceable(1) %ref.tmp) #17
          to label %invoke.cont2 unwind label %terminate.lpad

invoke.cont2:                                     ; preds = %invoke.cont
  call void @_ZNSaIwED1Ev(ptr nonnull align 1 dereferenceable(1) %ref.tmp) #18
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 0) #17
          to label %invoke.cont3 unwind label %terminate.lpad

invoke.cont3:                                     ; preds = %invoke.cont2
  ret void

terminate.lpad:                                   ; preds = %invoke.cont2, %invoke.cont, %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  %arraydecay = getelementptr inbounds [8 x i16], ptr %0, i64 0, i64 0
  %call = call ptr @_ZNSt19__ptr_traits_ptr_toIPwwLb0EE10pointer_toERw(ptr nonnull align 2 dereferenceable(2) %arraydecay) #18
  ret ptr %call
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIwEC1Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIwEC2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC1EPwOS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__dat, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__dat.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__dat, ptr %__dat.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__dat.addr, align 8
  %1 = load ptr, ptr %__a.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC2EPwOS3_(ptr nonnull align 8 dereferenceable(8) %this1, ptr %0, ptr nonnull align 1 dereferenceable(1) %1) #17
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIwED1Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIwED2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %ref.tmp = alloca i16, align 2
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load i64, ptr %__n.addr, align 8
  %arrayidx = getelementptr inbounds nuw i16, ptr %call, i64 %0
  store i16 0, ptr %ref.tmp, align 2
  call void @_ZNSt11char_traitsIwE6assignERwRKw(ptr nonnull align 2 dereferenceable(2) %arrayidx, ptr nonnull align 2 dereferenceable(2) %ref.tmp) #18
  %1 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt19__ptr_traits_ptr_toIPwwLb0EE10pointer_toERw(ptr nonnull align 2 dereferenceable(2) %__r) #3 comdat align 2 {
entry:
  %__r.addr = alloca ptr, align 8
  store ptr %__r, ptr %__r.addr, align 8
  %0 = load ptr, ptr %__r.addr, align 8, !nonnull !5, !align !7
  ret ptr %0
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIwEC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt15__new_allocatorIwEC2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIwEC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC2EPwOS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__dat, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__dat.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__dat, ptr %__dat.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  call void @_ZNSaIwEC2ERKS_(ptr nonnull align 1 dereferenceable(1) %this1, ptr nonnull align 1 dereferenceable(1) %0) #18
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<wchar_t>::_Alloc_hider", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %__dat.addr, align 8
  store ptr %1, ptr %_M_p, align 8
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIwEC2ERKS_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  call void @_ZNSt15__new_allocatorIwEC2ERKS0_(ptr nonnull align 1 dereferenceable(1) %this1, ptr nonnull align 1 dereferenceable(1) %0) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIwEC2ERKS0_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %0) unnamed_addr #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %0, ptr %.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt11char_traitsIwE6assignERwRKw(ptr nonnull align 2 dereferenceable(2) %__c1, ptr nonnull align 2 dereferenceable(2) %__c2) #3 comdat align 2 {
entry:
  %__c1.addr = alloca ptr, align 8
  %__c2.addr = alloca ptr, align 8
  store ptr %__c1, ptr %__c1.addr, align 8
  store ptr %__c2, ptr %__c2.addr, align 8
  %0 = load ptr, ptr %__c2.addr, align 8, !nonnull !5, !align !7
  %1 = load i16, ptr %0, align 2
  %2 = load ptr, ptr %__c1.addr, align 8, !nonnull !5, !align !7
  store i16 %1, ptr %2, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_lengthEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__length) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__length.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__length, ptr %__length.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__length.addr, align 8
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 1
  store i64 %0, ptr %_M_string_length, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path8_CodecvtIwEC2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EEC2Ey(ptr nonnull align 8 dereferenceable(32) %this1, i64 0) #17
  store ptr getelementptr inbounds inrange(-16, 72) ({ [11 x ptr] }, ptr @_ZTVNSt10filesystem7__cxx114path8_CodecvtIwEE, i32 0, i32 0, i32 2), ptr %this1, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EEC2Ey(ptr nonnull align 8 dereferenceable(32) %this, i64 %__refs) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__refs.addr = alloca i64, align 8
  %ref.tmp = alloca i32, align 4
  %ref.tmp2 = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store i64 %__refs, ptr %__refs.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  store i32 1114111, ptr %ref.tmp, align 4
  store i32 1114111, ptr %ref.tmp2, align 4
  %call = call nonnull align 4 dereferenceable(4) ptr @_ZSt3minImERKT_S2_S2_(ptr nonnull align 4 dereferenceable(4) %ref.tmp, ptr nonnull align 4 dereferenceable(4) %ref.tmp2) #17
  %0 = load i32, ptr %call, align 4
  %1 = load i64, ptr %__refs.addr, align 8
  call void @_ZNSt25__codecvt_utf8_utf16_baseIwEC2EmSt12codecvt_modey(ptr nonnull align 8 dereferenceable(32) %this1, i32 %0, i32 0, i64 %1) #17
  store ptr getelementptr inbounds inrange(-16, 72) ({ [11 x ptr] }, ptr @_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE, i32 0, i32 0, i32 2), ptr %this1, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  call void @_ZdlPv(ptr %this1) #21
  ret void
}

; Function Attrs: convergent
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE6do_outER9_MbstatetPKwS4_RS4_PcS6_RS6_(ptr nonnull align 8 dereferenceable(32), ptr nonnull align 4 dereferenceable(8), ptr, ptr, ptr nonnull align 8 dereferenceable(8), ptr, ptr, ptr nonnull align 8 dereferenceable(8)) unnamed_addr #1

; Function Attrs: convergent
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE10do_unshiftER9_MbstatetPcS3_RS3_(ptr nonnull align 8 dereferenceable(32), ptr nonnull align 4 dereferenceable(8), ptr, ptr, ptr nonnull align 8 dereferenceable(8)) unnamed_addr #1

; Function Attrs: convergent
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE5do_inER9_MbstatetPKcS4_RS4_PwS6_RS6_(ptr nonnull align 8 dereferenceable(32), ptr nonnull align 4 dereferenceable(8), ptr, ptr, ptr nonnull align 8 dereferenceable(8), ptr, ptr, ptr nonnull align 8 dereferenceable(8)) unnamed_addr #1

; Function Attrs: convergent nounwind
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE11do_encodingEv(ptr nonnull align 8 dereferenceable(32)) unnamed_addr #6

; Function Attrs: convergent nounwind
declare dso_local zeroext i1 @_ZNKSt25__codecvt_utf8_utf16_baseIwE16do_always_noconvEv(ptr nonnull align 8 dereferenceable(32)) unnamed_addr #6

; Function Attrs: convergent
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE9do_lengthER9_MbstatetPKcS4_y(ptr nonnull align 8 dereferenceable(32), ptr nonnull align 4 dereferenceable(8), ptr, ptr, i64) unnamed_addr #1

; Function Attrs: convergent nounwind
declare dso_local i32 @_ZNKSt25__codecvt_utf8_utf16_baseIwE13do_max_lengthEv(ptr nonnull align 8 dereferenceable(32)) unnamed_addr #6

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 4 dereferenceable(4) ptr @_ZSt3minImERKT_S2_S2_(ptr nonnull align 4 dereferenceable(4) %__a, ptr nonnull align 4 dereferenceable(4) %__b) #3 comdat {
entry:
  %retval = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  %__b.addr = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store ptr %__b, ptr %__b.addr, align 8
  %0 = load ptr, ptr %__b.addr, align 8, !nonnull !5, !align !8
  %1 = load i32, ptr %0, align 4
  %2 = load ptr, ptr %__a.addr, align 8, !nonnull !5, !align !8
  %3 = load i32, ptr %2, align 4
  %cmp = icmp ult i32 %1, %3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load ptr, ptr %__b.addr, align 8, !nonnull !5, !align !8
  store ptr %4, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %5 = load ptr, ptr %__a.addr, align 8, !nonnull !5, !align !8
  store ptr %5, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %6 = load ptr, ptr %retval, align 8
  ret ptr %6
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt25__codecvt_utf8_utf16_baseIwEC2EmSt12codecvt_modey(ptr nonnull align 8 dereferenceable(32) %this, i32 %__maxcode, i32 %__mode, i64 %__refs) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__maxcode.addr = alloca i32, align 4
  %__mode.addr = alloca i32, align 4
  %__refs.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i32 %__maxcode, ptr %__maxcode.addr, align 4
  store i32 %__mode, ptr %__mode.addr, align 4
  store i64 %__refs, ptr %__refs.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__refs.addr, align 8
  call void @_ZNSt7codecvtIwc9_MbstatetEC2Ey(ptr nonnull align 8 dereferenceable(24) %this1, i64 %0) #17
  store ptr getelementptr inbounds inrange(-16, 72) ({ [11 x ptr] }, ptr @_ZTVSt25__codecvt_utf8_utf16_baseIwE, i32 0, i32 0, i32 2), ptr %this1, align 8
  %_M_maxcode = getelementptr inbounds nuw %"class.std::__codecvt_utf8_utf16_base", ptr %this1, i32 0, i32 1
  %1 = load i32, ptr %__maxcode.addr, align 4
  store i32 %1, ptr %_M_maxcode, align 8
  %_M_mode = getelementptr inbounds nuw %"class.std::__codecvt_utf8_utf16_base", ptr %this1, i32 0, i32 2
  %2 = load i32, ptr %__mode.addr, align 4
  store i32 %2, ptr %_M_mode, align 4
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  call void @_ZdlPv(ptr %this1) #21
  ret void
}

; Function Attrs: convergent
declare dso_local void @_ZNSt7codecvtIwc9_MbstatetEC2Ey(ptr nonnull align 8 dereferenceable(24), i64) unnamed_addr #1

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: convergent nounwind
declare dso_local void @_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev(ptr nonnull align 8 dereferenceable(32)) unnamed_addr #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #11

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local zeroext i1 @_ZSt16__str_codecvt_inIwSt11char_traitsIwESaIwE9_MbstatetEbPKcS5_RNSt7__cxx1112basic_stringIT_T0_T1_EERKSt7codecvtIS8_cT2_ERSE_Ry(ptr %__first, ptr %__last, ptr nonnull align 8 dereferenceable(32) %__outstr, ptr nonnull align 8 dereferenceable(24) %__cvt, ptr nonnull align 4 dereferenceable(8) %__state, ptr nonnull align 8 dereferenceable(8) %__count) #0 comdat {
entry:
  %__first.addr = alloca ptr, align 8
  %__last.addr = alloca ptr, align 8
  %__outstr.addr = alloca ptr, align 8
  %__cvt.addr = alloca ptr, align 8
  %__state.addr = alloca ptr, align 8
  %__count.addr = alloca ptr, align 8
  %__fn = alloca { i64, i64 }, align 8
  %byval-temp = alloca { i64, i64 }, align 8
  store ptr %__first, ptr %__first.addr, align 8
  store ptr %__last, ptr %__last.addr, align 8
  store ptr %__outstr, ptr %__outstr.addr, align 8
  store ptr %__cvt, ptr %__cvt.addr, align 8
  store ptr %__state, ptr %__state.addr, align 8
  store ptr %__count, ptr %__count.addr, align 8
  store { i64, i64 } { i64 ptrtoint (ptr @_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_ to i64), i64 0 }, ptr %__fn, align 8
  %0 = load ptr, ptr %__first.addr, align 8
  %1 = load ptr, ptr %__last.addr, align 8
  %2 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %3 = load ptr, ptr %__cvt.addr, align 8, !nonnull !5, !align !6
  %4 = load ptr, ptr %__state.addr, align 8, !nonnull !5, !align !8
  %5 = load ptr, ptr %__count.addr, align 8, !nonnull !5, !align !6
  %6 = load { i64, i64 }, ptr %__fn, align 8
  store { i64, i64 } %6, ptr %byval-temp, align 8
  %call = call zeroext i1 @_ZSt16__do_str_codecvtINSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEEcSt7codecvtIwc9_MbstatetES7_MS8_KFNSt12codecvt_base6resultERS7_PKcSD_RSD_PwSF_RSF_EEbPKT0_SL_RT_RKT1_RT2_RyT3_(ptr %0, ptr %1, ptr nonnull align 8 dereferenceable(32) %2, ptr nonnull align 8 dereferenceable(24) %3, ptr nonnull align 4 dereferenceable(8) %4, ptr nonnull align 8 dereferenceable(8) %5, ptr align 8 dead_on_return %byval-temp) #17
  ret i1 %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local i32 @_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_(ptr nonnull align 8 dereferenceable(12) %this, ptr nonnull align 4 dereferenceable(8) %__state, ptr %__from, ptr %__from_end, ptr nonnull align 8 dereferenceable(8) %__from_next, ptr %__to, ptr %__to_end, ptr nonnull align 8 dereferenceable(8) %__to_next) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__state.addr = alloca ptr, align 8
  %__from.addr = alloca ptr, align 8
  %__from_end.addr = alloca ptr, align 8
  %__from_next.addr = alloca ptr, align 8
  %__to.addr = alloca ptr, align 8
  %__to_end.addr = alloca ptr, align 8
  %__to_next.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__state, ptr %__state.addr, align 8
  store ptr %__from, ptr %__from.addr, align 8
  store ptr %__from_end, ptr %__from_end.addr, align 8
  store ptr %__from_next, ptr %__from_next.addr, align 8
  store ptr %__to, ptr %__to.addr, align 8
  store ptr %__to_end, ptr %__to_end.addr, align 8
  store ptr %__to_next, ptr %__to_next.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__state.addr, align 8, !nonnull !5, !align !8
  %1 = load ptr, ptr %__from.addr, align 8
  %2 = load ptr, ptr %__from_end.addr, align 8
  %3 = load ptr, ptr %__from_next.addr, align 8, !nonnull !5, !align !6
  %4 = load ptr, ptr %__to.addr, align 8
  %5 = load ptr, ptr %__to_end.addr, align 8
  %6 = load ptr, ptr %__to_next.addr, align 8, !nonnull !5, !align !6
  %vtable = load ptr, ptr %this1, align 8
  %vfn = getelementptr inbounds ptr, ptr %vtable, i64 4
  %7 = load ptr, ptr %vfn, align 8
  %call = call i32 %7(ptr nonnull align 8 dereferenceable(12) %this1, ptr nonnull align 4 dereferenceable(8) %0, ptr %1, ptr %2, ptr nonnull align 8 dereferenceable(8) %3, ptr %4, ptr %5, ptr nonnull align 8 dereferenceable(8) %6) #17
  ret i32 %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local zeroext i1 @_ZSt16__do_str_codecvtINSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEEcSt7codecvtIwc9_MbstatetES7_MS8_KFNSt12codecvt_base6resultERS7_PKcSD_RSD_PwSF_RSF_EEbPKT0_SL_RT_RKT1_RT2_RyT3_(ptr %__first, ptr %__last, ptr nonnull align 8 dereferenceable(32) %__outstr, ptr nonnull align 8 dereferenceable(24) %__cvt, ptr nonnull align 4 dereferenceable(8) %__state, ptr nonnull align 8 dereferenceable(8) %__count, ptr align 8 dead_on_return %0) #0 comdat {
entry:
  %retval = alloca i1, align 1
  %__first.addr = alloca ptr, align 8
  %__last.addr = alloca ptr, align 8
  %__outstr.addr = alloca ptr, align 8
  %__cvt.addr = alloca ptr, align 8
  %__state.addr = alloca ptr, align 8
  %__count.addr = alloca ptr, align 8
  %__fn.addr = alloca { i64, i64 }, align 8
  %__outchars = alloca i64, align 8
  %__next = alloca ptr, align 8
  %__maxlen = alloca i32, align 4
  %__result = alloca i32, align 4
  %__outnext = alloca ptr, align 8
  %__outlast = alloca ptr, align 8
  %__fn = load { i64, i64 }, ptr %0, align 8
  store ptr %__first, ptr %__first.addr, align 8
  store ptr %__last, ptr %__last.addr, align 8
  store ptr %__outstr, ptr %__outstr.addr, align 8
  store ptr %__cvt, ptr %__cvt.addr, align 8
  store ptr %__state, ptr %__state.addr, align 8
  store ptr %__count, ptr %__count.addr, align 8
  store { i64, i64 } %__fn, ptr %__fn.addr, align 8
  %1 = load ptr, ptr %__first.addr, align 8
  %2 = load ptr, ptr %__last.addr, align 8
  %cmp = icmp eq ptr %1, %2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %3 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5clearEv(ptr nonnull align 8 dereferenceable(32) %3) #18
  %4 = load ptr, ptr %__count.addr, align 8, !nonnull !5, !align !6
  store i64 0, ptr %4, align 8
  store i1 true, ptr %retval, align 1
  br label %return

if.end:                                           ; preds = %entry
  store i64 0, ptr %__outchars, align 8
  %5 = load ptr, ptr %__first.addr, align 8
  store ptr %5, ptr %__next, align 8
  %6 = load ptr, ptr %__cvt.addr, align 8, !nonnull !5, !align !6
  %call = call i32 @_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE10max_lengthEv(ptr nonnull align 8 dereferenceable(12) %6) #18
  %add = add nsw i32 %call, 1
  store i32 %add, ptr %__maxlen, align 4
  br label %do.body

do.body:                                          ; preds = %land.end, %if.end
  %7 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %8 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %call1 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %8) #18
  %9 = load ptr, ptr %__last.addr, align 8
  %10 = load ptr, ptr %__next, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %9 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %10 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %11 = load i32, ptr %__maxlen, align 4
  %conv = sext i32 %11 to i64
  %mul = mul nsw i64 %sub.ptr.sub, %conv
  %add2 = add i64 %call1, %mul
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEy(ptr nonnull align 8 dereferenceable(32) %7, i64 %add2) #17
  %12 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %call3 = call nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv(ptr nonnull align 8 dereferenceable(32) %12) #18
  %13 = load i64, ptr %__outchars, align 8
  %add.ptr = getelementptr inbounds nuw i16, ptr %call3, i64 %13
  store ptr %add.ptr, ptr %__outnext, align 8
  %14 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %call4 = call nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4backEv(ptr nonnull align 8 dereferenceable(32) %14) #18
  %add.ptr5 = getelementptr inbounds i16, ptr %call4, i64 1
  store ptr %add.ptr5, ptr %__outlast, align 8
  %15 = load ptr, ptr %__cvt.addr, align 8, !nonnull !5, !align !6
  %16 = load { i64, i64 }, ptr %__fn.addr, align 8
  %memptr.adj = extractvalue { i64, i64 } %16, 1
  %17 = getelementptr inbounds i8, ptr %15, i64 %memptr.adj
  %memptr.ptr = extractvalue { i64, i64 } %16, 0
  %18 = and i64 %memptr.ptr, 1
  %memptr.isvirtual = icmp ne i64 %18, 0
  br i1 %memptr.isvirtual, label %memptr.virtual, label %memptr.nonvirtual

memptr.virtual:                                   ; preds = %do.body
  %vtable = load ptr, ptr %17, align 8
  %19 = sub i64 %memptr.ptr, 1
  %20 = getelementptr i8, ptr %vtable, i64 %19, !nosanitize !5
  %memptr.virtualfn = load ptr, ptr %20, align 8, !nosanitize !5
  br label %memptr.end

memptr.nonvirtual:                                ; preds = %do.body
  %memptr.nonvirtualfn = inttoptr i64 %memptr.ptr to ptr
  br label %memptr.end

memptr.end:                                       ; preds = %memptr.nonvirtual, %memptr.virtual
  %21 = phi ptr [ %memptr.virtualfn, %memptr.virtual ], [ %memptr.nonvirtualfn, %memptr.nonvirtual ]
  %22 = load ptr, ptr %__state.addr, align 8, !nonnull !5, !align !8
  %23 = load ptr, ptr %__next, align 8
  %24 = load ptr, ptr %__last.addr, align 8
  %25 = load ptr, ptr %__outnext, align 8
  %26 = load ptr, ptr %__outlast, align 8
  %call6 = call i32 %21(ptr nonnull align 8 dereferenceable(24) %17, ptr nonnull align 4 dereferenceable(8) %22, ptr %23, ptr %24, ptr nonnull align 8 dereferenceable(8) %__next, ptr %25, ptr %26, ptr nonnull align 8 dereferenceable(8) %__outnext) #17
  store i32 %call6, ptr %__result, align 4
  %27 = load ptr, ptr %__outnext, align 8
  %28 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %call7 = call nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv(ptr nonnull align 8 dereferenceable(32) %28) #18
  %sub.ptr.lhs.cast8 = ptrtoint ptr %27 to i64
  %sub.ptr.rhs.cast9 = ptrtoint ptr %call7 to i64
  %sub.ptr.sub10 = sub i64 %sub.ptr.lhs.cast8, %sub.ptr.rhs.cast9
  %sub.ptr.div = sdiv exact i64 %sub.ptr.sub10, 2
  store i64 %sub.ptr.div, ptr %__outchars, align 8
  br label %do.cond

do.cond:                                          ; preds = %memptr.end
  %29 = load i32, ptr %__result, align 4
  %cmp11 = icmp eq i32 %29, 1
  br i1 %cmp11, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %do.cond
  %30 = load ptr, ptr %__next, align 8
  %31 = load ptr, ptr %__last.addr, align 8
  %cmp12 = icmp ne ptr %30, %31
  br i1 %cmp12, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %land.lhs.true
  %32 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %call13 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %32) #18
  %33 = load i64, ptr %__outchars, align 8
  %sub = sub i64 %call13, %33
  %34 = load i32, ptr %__maxlen, align 4
  %conv14 = sext i32 %34 to i64
  %cmp15 = icmp slt i64 %sub, %conv14
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %do.cond
  %35 = phi i1 [ false, %land.lhs.true ], [ false, %do.cond ], [ %cmp15, %land.rhs ]
  br i1 %35, label %do.body, label %do.end, !llvm.loop !9

do.end:                                           ; preds = %land.end
  %36 = load i32, ptr %__result, align 4
  %cmp16 = icmp eq i32 %36, 2
  br i1 %cmp16, label %if.then17, label %if.end21

if.then17:                                        ; preds = %do.end
  %37 = load ptr, ptr %__next, align 8
  %38 = load ptr, ptr %__first.addr, align 8
  %sub.ptr.lhs.cast18 = ptrtoint ptr %37 to i64
  %sub.ptr.rhs.cast19 = ptrtoint ptr %38 to i64
  %sub.ptr.sub20 = sub i64 %sub.ptr.lhs.cast18, %sub.ptr.rhs.cast19
  %39 = load ptr, ptr %__count.addr, align 8, !nonnull !5, !align !6
  store i64 %sub.ptr.sub20, ptr %39, align 8
  store i1 false, ptr %retval, align 1
  br label %return

if.end21:                                         ; preds = %do.end
  %40 = load ptr, ptr %__outstr.addr, align 8, !nonnull !5, !align !6
  %41 = load i64, ptr %__outchars, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEy(ptr nonnull align 8 dereferenceable(32) %40, i64 %41) #17
  %42 = load ptr, ptr %__next, align 8
  %43 = load ptr, ptr %__first.addr, align 8
  %sub.ptr.lhs.cast22 = ptrtoint ptr %42 to i64
  %sub.ptr.rhs.cast23 = ptrtoint ptr %43 to i64
  %sub.ptr.sub24 = sub i64 %sub.ptr.lhs.cast22, %sub.ptr.rhs.cast23
  %44 = load ptr, ptr %__count.addr, align 8, !nonnull !5, !align !6
  store i64 %sub.ptr.sub24, ptr %44, align 8
  store i1 true, ptr %retval, align 1
  br label %return

return:                                           ; preds = %if.end21, %if.then17, %if.then
  %45 = load i1, ptr %retval, align 1
  ret i1 %45
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5clearEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 0) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i32 @_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE10max_lengthEv(ptr nonnull align 8 dereferenceable(12) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %vtable = load ptr, ptr %this1, align 8
  %vfn = getelementptr inbounds ptr, ptr %vtable, i64 8
  %0 = load ptr, ptr %vfn, align 8
  %call = call i32 %0(ptr nonnull align 8 dereferenceable(12) %this1) #18
  ret i32 %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEyw(ptr nonnull align 8 dereferenceable(32) %this1, i64 %0, i16 0) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__sz = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 1
  %0 = load i64, ptr %_M_string_length, align 8
  store i64 %0, ptr %__sz, align 8
  %1 = load i64, ptr %__sz, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp = icmp ugt i64 %1, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  unreachable

if.end:                                           ; preds = %entry
  %2 = load i64, ptr %__sz, align 8
  ret i64 %2
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  br label %do.body

do.body:                                          ; preds = %entry
  %call = call zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5emptyEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %lnot = xor i1 %call, true
  %lnot2 = xor i1 %lnot, true
  br i1 %lnot2, label %if.then, label %if.end

if.then:                                          ; preds = %do.body
  call void @_ZSt21__glibcxx_assert_failPKciS0_S0_(ptr @.str.9, i32 1452, ptr @__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5frontEv, ptr @.str.10) #24
  unreachable

if.end:                                           ; preds = %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end
  br label %do.end

do.end:                                           ; preds = %do.cond
  %call3 = invoke nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 0) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %do.end
  ret ptr %call3

terminate.lpad:                                   ; preds = %do.end
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4backEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  br label %do.body

do.body:                                          ; preds = %entry
  %call = call zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5emptyEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %lnot = xor i1 %call, true
  %lnot2 = xor i1 %lnot, true
  br i1 %lnot2, label %if.then, label %if.end

if.then:                                          ; preds = %do.body
  call void @_ZSt21__glibcxx_assert_failPKciS0_S0_(ptr @.str.9, i32 1476, ptr @__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4backEv, ptr @.str.10) #24
  unreachable

if.end:                                           ; preds = %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end
  br label %do.end

do.end:                                           ; preds = %do.cond
  %call3 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %sub = sub i64 %call3, 1
  %call4 = call nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %sub) #17
  ret ptr %call4
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6resizeEyw(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n, i16 %__c) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__c.addr = alloca i16, align 2
  %__size = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store i16 %__c, ptr %__c.addr, align 2
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  store i64 %call, ptr %__size, align 8
  %0 = load i64, ptr %__size, align 8
  %1 = load i64, ptr %__n.addr, align 8
  %cmp = icmp ult i64 %0, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i64, ptr %__n.addr, align 8
  %3 = load i64, ptr %__size, align 8
  %sub = sub i64 %2, %3
  %4 = load i16, ptr %__c.addr, align 2
  %call2 = call nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6appendEyw(ptr nonnull align 8 dereferenceable(32) %this1, i64 %sub, i16 %4) #17
  br label %if.end5

if.else:                                          ; preds = %entry
  %5 = load i64, ptr %__n.addr, align 8
  %6 = load i64, ptr %__size, align 8
  %cmp3 = icmp ult i64 %5, %6
  br i1 %cmp3, label %if.then4, label %if.end

if.then4:                                         ; preds = %if.else
  %7 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %7) #17
  br label %if.end

if.end:                                           ; preds = %if.then4, %if.else
  br label %if.end5

if.end5:                                          ; preds = %if.end, %if.then
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6appendEyw(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n, i16 %__c) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__c.addr = alloca i16, align 2
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store i16 %__c, ptr %__c.addr, align 2
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %0 = load i64, ptr %__n.addr, align 8
  %1 = load i16, ptr %__c.addr, align 2
  %call2 = call nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE14_M_replace_auxEyyyw(ptr nonnull align 8 dereferenceable(32) %this1, i64 %call, i64 0, i64 %0, i16 %1) #17
  ret ptr %call2
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE14_M_replace_auxEyyyw(ptr nonnull align 8 dereferenceable(32) %this, i64 %__pos1, i64 %__n1, i64 %__n2, i16 %__c) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__pos1.addr = alloca i64, align 8
  %__n1.addr = alloca i64, align 8
  %__n2.addr = alloca i64, align 8
  %__c.addr = alloca i16, align 2
  %__old_size = alloca i64, align 8
  %__new_size = alloca i64, align 8
  %__p = alloca ptr, align 8
  %__how_much = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__pos1, ptr %__pos1.addr, align 8
  store i64 %__n1, ptr %__n1.addr, align 8
  store i64 %__n2, ptr %__n2.addr, align 8
  store i16 %__c, ptr %__c.addr, align 2
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__n1.addr, align 8
  %1 = load i64, ptr %__n2.addr, align 8
  call void @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE15_M_check_lengthEyyPKc(ptr nonnull align 8 dereferenceable(32) %this1, i64 %0, i64 %1, ptr @.str.7) #17
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  store i64 %call, ptr %__old_size, align 8
  %2 = load i64, ptr %__old_size, align 8
  %3 = load i64, ptr %__n2.addr, align 8
  %add = add i64 %2, %3
  %4 = load i64, ptr %__n1.addr, align 8
  %sub = sub i64 %add, %4
  store i64 %sub, ptr %__new_size, align 8
  %5 = load i64, ptr %__new_size, align 8
  %call2 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8capacityEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp = icmp ule i64 %5, %call2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call3 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %6 = load i64, ptr %__pos1.addr, align 8
  %add.ptr = getelementptr inbounds nuw i16, ptr %call3, i64 %6
  store ptr %add.ptr, ptr %__p, align 8
  %7 = load i64, ptr %__old_size, align 8
  %8 = load i64, ptr %__pos1.addr, align 8
  %sub4 = sub i64 %7, %8
  %9 = load i64, ptr %__n1.addr, align 8
  %sub5 = sub i64 %sub4, %9
  store i64 %sub5, ptr %__how_much, align 8
  %10 = load i64, ptr %__how_much, align 8
  %tobool = icmp ne i64 %10, 0
  br i1 %tobool, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %if.then
  %11 = load i64, ptr %__n1.addr, align 8
  %12 = load i64, ptr %__n2.addr, align 8
  %cmp6 = icmp ne i64 %11, %12
  br i1 %cmp6, label %if.then7, label %if.end

if.then7:                                         ; preds = %land.lhs.true
  %13 = load ptr, ptr %__p, align 8
  %14 = load i64, ptr %__n2.addr, align 8
  %add.ptr8 = getelementptr inbounds nuw i16, ptr %13, i64 %14
  %15 = load ptr, ptr %__p, align 8
  %16 = load i64, ptr %__n1.addr, align 8
  %add.ptr9 = getelementptr inbounds nuw i16, ptr %15, i64 %16
  %17 = load i64, ptr %__how_much, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_moveEPwPKwy(ptr %add.ptr8, ptr %add.ptr9, i64 %17) #17
  br label %if.end

if.end:                                           ; preds = %if.then7, %land.lhs.true, %if.then
  br label %if.end10

if.else:                                          ; preds = %entry
  %18 = load i64, ptr %__pos1.addr, align 8
  %19 = load i64, ptr %__n1.addr, align 8
  %20 = load i64, ptr %__n2.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_mutateEyyPKwy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %18, i64 %19, ptr null, i64 %20) #17
  br label %if.end10

if.end10:                                         ; preds = %if.else, %if.end
  %21 = load i64, ptr %__n2.addr, align 8
  %tobool11 = icmp ne i64 %21, 0
  br i1 %tobool11, label %if.then12, label %if.end15

if.then12:                                        ; preds = %if.end10
  %call13 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %22 = load i64, ptr %__pos1.addr, align 8
  %add.ptr14 = getelementptr inbounds nuw i16, ptr %call13, i64 %22
  %23 = load i64, ptr %__n2.addr, align 8
  %24 = load i16, ptr %__c.addr, align 2
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_S_assignEPwyw(ptr %add.ptr14, i64 %23, i16 %24) #17
  br label %if.end15

if.end15:                                         ; preds = %if.then12, %if.end10
  %25 = load i64, ptr %__new_size, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %25) #17
  ret ptr %this1
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE15_M_check_lengthEyyPKc(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n1, i64 %__n2, ptr %__s) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n1.addr = alloca i64, align 8
  %__n2.addr = alloca i64, align 8
  %__s.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n1, ptr %__n1.addr, align 8
  store i64 %__n2, ptr %__n2.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %call2 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %0 = load i64, ptr %__n1.addr, align 8
  %sub = sub i64 %call2, %0
  %sub3 = sub i64 %call, %sub
  %1 = load i64, ptr %__n2.addr, align 8
  %cmp = icmp ult i64 %sub3, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %__s.addr, align 8
  call void @_ZSt20__throw_length_errorPKc(ptr %2) #25
  unreachable

if.end:                                           ; preds = %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8capacityEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__sz = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = invoke zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  br i1 %call, label %cond.true, label %cond.false

cond.true:                                        ; preds = %invoke.cont
  br label %cond.end

cond.false:                                       ; preds = %invoke.cont
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  %1 = load i64, ptr %0, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ 7, %cond.true ], [ %1, %cond.false ]
  store i64 %cond, ptr %__sz, align 8
  %2 = load i64, ptr %__sz, align 8
  %cmp = icmp ult i64 %2, 7
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %cond.end
  %3 = load i64, ptr %__sz, align 8
  %call2 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp3 = icmp ugt i64 %3, %call2
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %cond.end
  unreachable

if.end:                                           ; preds = %lor.lhs.false
  %4 = load i64, ptr %__sz, align 8
  ret i64 %4

terminate.lpad:                                   ; preds = %entry
  %5 = landingpad { ptr, i32 }
          catch ptr null
  %6 = extractvalue { ptr, i32 } %5, 0
  call void @__clang_call_terminate(ptr %6) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_moveEPwPKwy(ptr %__d, ptr %__s, i64 %__n) #0 comdat align 2 {
entry:
  %__d.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__d, ptr %__d.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__d.addr, align 8
  %2 = load ptr, ptr %__s.addr, align 8
  call void @_ZNSt11char_traitsIwE6assignERwRKw(ptr nonnull align 2 dereferenceable(2) %1, ptr nonnull align 2 dereferenceable(2) %2) #18
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load ptr, ptr %__d.addr, align 8
  %4 = load ptr, ptr %__s.addr, align 8
  %5 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt11char_traitsIwE4moveEPwPKwy(ptr %3, ptr %4, i64 %5) #17
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_mutateEyyPKwy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__pos, i64 %__len1, ptr %__s, i64 %__len2) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__pos.addr = alloca i64, align 8
  %__len1.addr = alloca i64, align 8
  %__s.addr = alloca ptr, align 8
  %__len2.addr = alloca i64, align 8
  %__how_much = alloca i64, align 8
  %__new_capacity = alloca i64, align 8
  %__r = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__pos, ptr %__pos.addr, align 8
  store i64 %__len1, ptr %__len1.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store i64 %__len2, ptr %__len2.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %0 = load i64, ptr %__pos.addr, align 8
  %sub = sub i64 %call, %0
  %1 = load i64, ptr %__len1.addr, align 8
  %sub2 = sub i64 %sub, %1
  store i64 %sub2, ptr %__how_much, align 8
  %call3 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %2 = load i64, ptr %__len2.addr, align 8
  %add = add i64 %call3, %2
  %3 = load i64, ptr %__len1.addr, align 8
  %sub4 = sub i64 %add, %3
  store i64 %sub4, ptr %__new_capacity, align 8
  %call5 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8capacityEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %call6 = call ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_createERyy(ptr nonnull align 8 dereferenceable(32) %this1, ptr nonnull align 8 dereferenceable(8) %__new_capacity, i64 %call5) #17
  store ptr %call6, ptr %__r, align 8
  %4 = load i64, ptr %__pos.addr, align 8
  %tobool = icmp ne i64 %4, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %5 = load ptr, ptr %__r, align 8
  %call7 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %6 = load i64, ptr %__pos.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_copyEPwPKwy(ptr %5, ptr %call7, i64 %6) #17
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %7 = load ptr, ptr %__s.addr, align 8
  %tobool8 = icmp ne ptr %7, null
  br i1 %tobool8, label %land.lhs.true, label %if.end11

land.lhs.true:                                    ; preds = %if.end
  %8 = load i64, ptr %__len2.addr, align 8
  %tobool9 = icmp ne i64 %8, 0
  br i1 %tobool9, label %if.then10, label %if.end11

if.then10:                                        ; preds = %land.lhs.true
  %9 = load ptr, ptr %__r, align 8
  %10 = load i64, ptr %__pos.addr, align 8
  %add.ptr = getelementptr inbounds nuw i16, ptr %9, i64 %10
  %11 = load ptr, ptr %__s.addr, align 8
  %12 = load i64, ptr %__len2.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_copyEPwPKwy(ptr %add.ptr, ptr %11, i64 %12) #17
  br label %if.end11

if.end11:                                         ; preds = %if.then10, %land.lhs.true, %if.end
  %13 = load i64, ptr %__how_much, align 8
  %tobool12 = icmp ne i64 %13, 0
  br i1 %tobool12, label %if.then13, label %if.end19

if.then13:                                        ; preds = %if.end11
  %14 = load ptr, ptr %__r, align 8
  %15 = load i64, ptr %__pos.addr, align 8
  %add.ptr14 = getelementptr inbounds nuw i16, ptr %14, i64 %15
  %16 = load i64, ptr %__len2.addr, align 8
  %add.ptr15 = getelementptr inbounds nuw i16, ptr %add.ptr14, i64 %16
  %call16 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %17 = load i64, ptr %__pos.addr, align 8
  %add.ptr17 = getelementptr inbounds nuw i16, ptr %call16, i64 %17
  %18 = load i64, ptr %__len1.addr, align 8
  %add.ptr18 = getelementptr inbounds nuw i16, ptr %add.ptr17, i64 %18
  %19 = load i64, ptr %__how_much, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_copyEPwPKwy(ptr %add.ptr15, ptr %add.ptr18, i64 %19) #17
  br label %if.end19

if.end19:                                         ; preds = %if.then13, %if.end11
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %20 = load ptr, ptr %__r, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEPw(ptr nonnull align 8 dereferenceable(32) %this1, ptr %20) #17
  %21 = load i64, ptr %__new_capacity, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_capacityEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %21) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_S_assignEPwyw(ptr %__d, i64 %__n, i16 %__c) #0 comdat align 2 {
entry:
  %__d.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__c.addr = alloca i16, align 2
  store ptr %__d, ptr %__d.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store i16 %__c, ptr %__c.addr, align 2
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__d.addr, align 8
  call void @_ZNSt11char_traitsIwE6assignERwRKw(ptr nonnull align 2 dereferenceable(2) %1, ptr nonnull align 2 dereferenceable(2) %__c.addr) #18
  br label %if.end

if.else:                                          ; preds = %entry
  %2 = load ptr, ptr %__d.addr, align 8
  %3 = load i64, ptr %__n.addr, align 8
  %4 = load i16, ptr %__c.addr, align 2
  %call = call ptr @_ZNSt11char_traitsIwE6assignEPwyw(ptr %2, i64 %3, i16 %4) #17
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__diffmax = alloca i64, align 8
  %__allocmax = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  store i64 4611686018427387903, ptr %__diffmax, align 8
  %call = invoke nonnull align 1 dereferenceable(1) ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %call2 = call i64 @_ZNSt16allocator_traitsISaIwEE8max_sizeERKS0_(ptr nonnull align 1 dereferenceable(1) %call) #18
  store i64 %call2, ptr %__allocmax, align 8
  %call4 = invoke nonnull align 8 dereferenceable(8) ptr @_ZSt3minIyERKT_S2_S2_(ptr nonnull align 8 dereferenceable(8) %__diffmax, ptr nonnull align 8 dereferenceable(8) %__allocmax) #17
          to label %invoke.cont3 unwind label %terminate.lpad

invoke.cont3:                                     ; preds = %invoke.cont
  %0 = load i64, ptr %call4, align 8
  %sub = sub i64 %0, 1
  ret i64 %sub

terminate.lpad:                                   ; preds = %invoke.cont, %entry
  %1 = landingpad { ptr, i32 }
          catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  call void @__clang_call_terminate(ptr %2) #19
  unreachable
}

; Function Attrs: cold convergent noreturn
declare dso_local void @_ZSt20__throw_length_errorPKc(ptr) #12

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i64 @_ZNSt16allocator_traitsISaIwEE8max_sizeERKS0_(ptr nonnull align 1 dereferenceable(1) %__a) #9 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  ret i64 9223372036854775807
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  ret ptr %_M_dataplus
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) ptr @_ZSt3minIyERKT_S2_S2_(ptr nonnull align 8 dereferenceable(8) %__a, ptr nonnull align 8 dereferenceable(8) %__b) #3 comdat {
entry:
  %retval = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  %__b.addr = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store ptr %__b, ptr %__b.addr, align 8
  %0 = load ptr, ptr %__b.addr, align 8, !nonnull !5, !align !6
  %1 = load i64, ptr %0, align 8
  %2 = load ptr, ptr %__a.addr, align 8, !nonnull !5, !align !6
  %3 = load i64, ptr %2, align 8
  %cmp = icmp ult i64 %1, %3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load ptr, ptr %__b.addr, align 8, !nonnull !5, !align !6
  store ptr %4, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %5 = load ptr, ptr %__a.addr, align 8, !nonnull !5, !align !6
  store ptr %5, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %6 = load ptr, ptr %retval, align 8
  ret ptr %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt11char_traitsIwE4moveEPwPKwy(ptr %__s1, ptr %__s2, i64 %__n) #3 comdat align 2 {
entry:
  %retval = alloca ptr, align 8
  %__s1.addr = alloca ptr, align 8
  %__s2.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__s1, ptr %__s1.addr, align 8
  store ptr %__s2, ptr %__s2.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__s1.addr, align 8
  store ptr %1, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__s1.addr, align 8
  %3 = load ptr, ptr %__s2.addr, align 8
  %4 = load i64, ptr %__n.addr, align 8
  %call = call ptr @wmemmove(ptr %2, ptr %3, i64 %4) #18
  store ptr %call, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load ptr, ptr %retval, align 8
  ret ptr %5
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @wmemmove(ptr %_S1, ptr %_S2, i64 %_N) #3 comdat {
entry:
  %_S1.addr = alloca ptr, align 8
  %_S2.addr = alloca ptr, align 8
  %_N.addr = alloca i64, align 8
  store ptr %_S1, ptr %_S1.addr, align 8
  store ptr %_S2, ptr %_S2.addr, align 8
  store i64 %_N, ptr %_N.addr, align 8
  %0 = load ptr, ptr %_S1.addr, align 8
  %1 = load ptr, ptr %_S2.addr, align 8
  %2 = load i64, ptr %_N.addr, align 8
  %mul = mul i64 %2, 2
  call void @llvm.memmove.p0.p0.i64(ptr align 2 %0, ptr align 2 %1, i64 %mul, i1 false)
  ret ptr %0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr writeonly captures(none), ptr readonly captures(none), i64, i1 immarg) #4

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret i64 %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_createERyy(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(8) %__capacity, i64 %__old_capacity) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__capacity.addr = alloca ptr, align 8
  %__old_capacity.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__capacity, ptr %__capacity.addr, align 8
  store i64 %__old_capacity, ptr %__old_capacity.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %1 = load i64, ptr %0, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp = icmp ugt i64 %1, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @_ZSt20__throw_length_errorPKc(ptr @.str.8) #25
  unreachable

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %3 = load i64, ptr %2, align 8
  %4 = load i64, ptr %__old_capacity.addr, align 8
  %cmp2 = icmp ugt i64 %3, %4
  br i1 %cmp2, label %land.lhs.true, label %if.end11

land.lhs.true:                                    ; preds = %if.end
  %5 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %6 = load i64, ptr %5, align 8
  %7 = load i64, ptr %__old_capacity.addr, align 8
  %mul = mul i64 2, %7
  %cmp3 = icmp ult i64 %6, %mul
  br i1 %cmp3, label %if.then4, label %if.end11

if.then4:                                         ; preds = %land.lhs.true
  %8 = load i64, ptr %__old_capacity.addr, align 8
  %mul5 = mul i64 2, %8
  %9 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  store i64 %mul5, ptr %9, align 8
  %10 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %11 = load i64, ptr %10, align 8
  %call6 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp7 = icmp ugt i64 %11, %call6
  br i1 %cmp7, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.then4
  %call9 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %12 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  store i64 %call9, ptr %12, align 8
  br label %if.end10

if.end10:                                         ; preds = %if.then8, %if.then4
  br label %if.end11

if.end11:                                         ; preds = %if.end10, %land.lhs.true, %if.end
  %call12 = call nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %13 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %14 = load i64, ptr %13, align 8
  %add = add i64 %14, 1
  %call13 = call ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_S_allocateERS3_y(ptr nonnull align 1 dereferenceable(1) %call12, i64 %add) #17
  ret ptr %call13
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_S_copyEPwPKwy(ptr %__d, ptr %__s, i64 %__n) #0 comdat align 2 {
entry:
  %__d.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__d, ptr %__d.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__d.addr, align 8
  %2 = load ptr, ptr %__s.addr, align 8
  call void @_ZNSt11char_traitsIwE6assignERwRKw(ptr nonnull align 2 dereferenceable(2) %1, ptr nonnull align 2 dereferenceable(2) %2) #18
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load ptr, ptr %__d.addr, align 8
  %4 = load ptr, ptr %__s.addr, align 8
  %5 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt11char_traitsIwE4copyEPwPKwy(ptr %3, ptr %4, i64 %5) #17
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEPw(ptr nonnull align 8 dereferenceable(32) %this, ptr %__p) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<wchar_t>::_Alloc_hider", ptr %_M_dataplus, i32 0, i32 0
  store ptr %0, ptr %_M_p, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_capacityEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__capacity) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__capacity.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__capacity, ptr %__capacity.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__capacity.addr, align 8
  %1 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  store i64 %0, ptr %1, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_S_allocateERS3_y(ptr nonnull align 1 dereferenceable(1) %__a, i64 %__n) #0 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__p = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt16allocator_traitsISaIwEE8allocateERS0_y(ptr nonnull align 1 dereferenceable(1) %0, i64 %1) #17
  store ptr %call, ptr %__p, align 8
  %2 = load ptr, ptr %__p, align 8
  ret ptr %2
}

; Function Attrs: alwaysinline convergent mustprogress
define linkonce_odr dso_local ptr @_ZNSt16allocator_traitsISaIwEE8allocateERS0_y(ptr nonnull align 1 dereferenceable(1) %__a, i64 %__n) #7 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSaIwE8allocateEy(ptr nonnull align 1 dereferenceable(1) %0, i64 %1) #17
  ret ptr %call
}

; Function Attrs: alwaysinline convergent mustprogress
define available_externally dso_local ptr @_ZNSaIwE8allocateEy(ptr nonnull align 1 dereferenceable(1) %this, i64 %__n) #7 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt15__new_allocatorIwE8allocateEyPKv(ptr nonnull align 1 dereferenceable(1) %this1, i64 %0, ptr null) #17
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt15__new_allocatorIwE8allocateEyPKv(ptr nonnull align 1 dereferenceable(1) %this, i64 %__n, ptr %0) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store ptr %0, ptr %.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %1 = load i64, ptr %__n.addr, align 8
  %call = call i64 @_ZNKSt15__new_allocatorIwE11_M_max_sizeEv(ptr nonnull align 1 dereferenceable(1) %this1) #18
  %cmp = icmp ugt i64 %1, %call
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i64, ptr %__n.addr, align 8
  %cmp2 = icmp ugt i64 %2, 9223372036854775807
  br i1 %cmp2, label %if.then3, label %if.end

if.then3:                                         ; preds = %if.then
  call void @_ZSt28__throw_bad_array_new_lengthv() #22
  unreachable

if.end:                                           ; preds = %if.then
  call void @_ZSt17__throw_bad_allocv() #22
  unreachable

if.else:                                          ; preds = %entry
  %3 = load i64, ptr %__n.addr, align 8
  %mul = mul i64 %3, 2
  %call4 = call noalias nonnull ptr @_Znwy(i64 %mul) #26
  ret ptr %call4
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i64 @_ZNKSt15__new_allocatorIwE11_M_max_sizeEv(ptr nonnull align 1 dereferenceable(1) %this) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret i64 4611686018427387903
}

; Function Attrs: convergent noreturn
declare dso_local void @_ZSt28__throw_bad_array_new_lengthv() #13

; Function Attrs: convergent noreturn
declare dso_local void @_ZSt17__throw_bad_allocv() #13

; Function Attrs: convergent nobuiltin allocsize(0)
declare dso_local noalias nonnull ptr @_Znwy(i64) #14

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt11char_traitsIwE4copyEPwPKwy(ptr %__s1, ptr %__s2, i64 %__n) #3 comdat align 2 {
entry:
  %retval = alloca ptr, align 8
  %__s1.addr = alloca ptr, align 8
  %__s2.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__s1, ptr %__s1.addr, align 8
  store ptr %__s2, ptr %__s2.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__s1.addr, align 8
  store ptr %1, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__s1.addr, align 8
  %3 = load ptr, ptr %__s2.addr, align 8
  %4 = load i64, ptr %__n.addr, align 8
  %call = call ptr @wmemcpy(ptr %2, ptr %3, i64 %4) #18
  store ptr %call, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load ptr, ptr %retval, align 8
  ret ptr %5
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @wmemcpy(ptr noalias %_S1, ptr noalias %_S2, i64 %_N) #3 comdat {
entry:
  %_S1.addr = alloca ptr, align 8
  %_S2.addr = alloca ptr, align 8
  %_N.addr = alloca i64, align 8
  store ptr %_S1, ptr %_S1.addr, align 8
  store ptr %_S2, ptr %_S2.addr, align 8
  store i64 %_N, ptr %_N.addr, align 8
  %0 = load ptr, ptr %_S1.addr, align 8
  %1 = load ptr, ptr %_S2.addr, align 8
  %2 = load i64, ptr %_N.addr, align 8
  %mul = mul i64 %2, 2
  call void @llvm.memcpy.p0.p0.i64(ptr align 2 %0, ptr align 2 %1, i64 %mul, i1 false)
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt11char_traitsIwE6assignEPwyw(ptr %__s, i64 %__n, i16 %__a) #0 comdat align 2 {
entry:
  %retval = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__a.addr = alloca i16, align 2
  store ptr %__s, ptr %__s.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store i16 %__a, ptr %__a.addr, align 2
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__s.addr, align 8
  store ptr %1, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__s.addr, align 8
  %3 = load i16, ptr %__a.addr, align 2
  %4 = load i64, ptr %__n.addr, align 8
  %call = call ptr @wmemset(ptr %2, i16 %3, i64 %4) #17
  store ptr %call, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load ptr, ptr %retval, align 8
  ret ptr %5
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @wmemset(ptr %_S, i16 %_C, i64 %_N) #3 comdat {
entry:
  %_S.addr = alloca ptr, align 8
  %_C.addr = alloca i16, align 2
  %_N.addr = alloca i64, align 8
  %_Su = alloca ptr, align 8
  store ptr %_S, ptr %_S.addr, align 8
  store i16 %_C, ptr %_C.addr, align 2
  store i64 %_N, ptr %_N.addr, align 8
  %0 = load ptr, ptr %_S.addr, align 8
  store ptr %0, ptr %_Su, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i64, ptr %_N.addr, align 8
  %cmp = icmp ult i64 0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i16, ptr %_C.addr, align 2
  %3 = load ptr, ptr %_Su, align 8
  store i16 %2, ptr %3, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load ptr, ptr %_Su, align 8
  %incdec.ptr = getelementptr inbounds nuw i16, ptr %4, i32 1
  store ptr %incdec.ptr, ptr %_Su, align 8
  %5 = load i64, ptr %_N.addr, align 8
  %dec = add i64 %5, -1
  store i64 %dec, ptr %_N.addr, align 8
  br label %for.cond, !llvm.loop !11

for.end:                                          ; preds = %for.cond
  %6 = load ptr, ptr %_S.addr, align 8
  ret ptr %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE5emptyEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 1
  %0 = load i64, ptr %_M_string_length, align 8
  %cmp = icmp eq i64 %0, 0
  ret i1 %cmp
}

; Function Attrs: cold convergent noreturn nounwind
declare dso_local void @_ZSt21__glibcxx_assert_failPKciS0_S0_(ptr, i32, ptr, ptr) #15

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 2 dereferenceable(2) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__pos) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__pos.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__pos, ptr %__pos.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  br label %do.body

do.body:                                          ; preds = %entry
  %0 = load i64, ptr %__pos.addr, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE4sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp = icmp ule i64 %0, %call
  %lnot = xor i1 %cmp, true
  br i1 %lnot, label %if.then, label %if.end

if.then:                                          ; preds = %do.body
  call void @_ZSt21__glibcxx_assert_failPKciS0_S0_(ptr @.str.9, i32 1393, ptr @__PRETTY_FUNCTION__._ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEixEy, ptr @.str.11) #24
  unreachable

if.end:                                           ; preds = %do.body
  br label %do.end

do.end:                                           ; preds = %if.end
  %call2 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %1 = load i64, ptr %__pos.addr, align 8
  %arrayidx = getelementptr inbounds nuw i16, ptr %call2, i64 %1
  ret ptr %arrayidx
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEC2EOS4_(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(32) %__str) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__str.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__str, ptr %__str.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 0
  %call = call ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call2 = call nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %0) #17
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE12_Alloc_hiderC1EPwOS3_(ptr nonnull align 8 dereferenceable(8) %_M_dataplus, ptr %call, ptr nonnull align 1 dereferenceable(1) %call2) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %1 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call4 = invoke zeroext i1 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %1) #17
          to label %invoke.cont3 unwind label %terminate.lpad

invoke.cont3:                                     ; preds = %invoke.cont
  br i1 %call4, label %if.then, label %if.else

if.then:                                          ; preds = %invoke.cont3
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %2 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %this1, i32 0, i32 2
  %arraydecay = getelementptr inbounds [8 x i16], ptr %2, i64 0, i64 0
  %3 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %4 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %3, i32 0, i32 2
  %arraydecay5 = getelementptr inbounds [8 x i16], ptr %4, i64 0, i64 0
  %5 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call6 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv(ptr nonnull align 8 dereferenceable(32) %5) #18
  %add = add i64 %call6, 1
  %call7 = call ptr @_ZNSt11char_traitsIwE4copyEPwPKwy(ptr %arraydecay, ptr %arraydecay5, i64 %add) #17
  br label %if.end

if.else:                                          ; preds = %invoke.cont3
  %6 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call8 = call ptr @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %6) #17
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEPw(ptr nonnull align 8 dereferenceable(32) %this1, ptr %call8) #17
  %7 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %8 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string", ptr %7, i32 0, i32 2
  %9 = load i64, ptr %8, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE11_M_capacityEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %9) #17
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %10 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call9 = call i64 @_ZNKSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE6lengthEv(ptr nonnull align 8 dereferenceable(32) %10) #18
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE9_M_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %call9) #17
  %11 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %12 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  %call10 = call ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_use_local_dataEv(ptr nonnull align 8 dereferenceable(32) %12) #18
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE7_M_dataEPw(ptr nonnull align 8 dereferenceable(32) %11, ptr %call10) #17
  %13 = load ptr, ptr %__str.addr, align 8, !nonnull !5, !align !6
  invoke void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %13, i64 0) #17
          to label %invoke.cont11 unwind label %terminate.lpad

invoke.cont11:                                    ; preds = %if.end
  ret void

terminate.lpad:                                   ; preds = %if.end, %invoke.cont, %entry
  %14 = landingpad { ptr, i32 }
          catch ptr null
  %15 = extractvalue { ptr, i32 } %14, 0
  call void @__clang_call_terminate(ptr %15) #19
  unreachable
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_use_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %call = call ptr @_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10filesystem7__cxx114path8_CodecvtIwED2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

declare dso_local ptr @__cxa_allocate_exception(i64)

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIcEC1Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIcEC2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_(ptr nonnull align 8 dereferenceable(32) %this, ptr %__s, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__s.addr, align 8
  %1 = load ptr, ptr %__a.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_(ptr nonnull align 8 dereferenceable(32) %this1, ptr %0, ptr nonnull align 1 dereferenceable(1) %1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZSt15make_error_codeSt4errc(ptr dead_on_unwind noalias writable sret(%"class.std::error_code") align 8 %agg.result, i32 %__e) #3 comdat {
entry:
  %result.ptr = alloca ptr, align 8
  %__e.addr = alloca i32, align 4
  store ptr %agg.result, ptr %result.ptr, align 8
  store i32 %__e, ptr %__e.addr, align 4
  %0 = load i32, ptr %__e.addr, align 4
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZNSt3_V216generic_categoryEv() #27
  call void @_ZNSt10error_codeC1EiRKNSt3_V214error_categoryE(ptr nonnull align 8 dereferenceable(16) %agg.result, i32 %0, ptr nonnull align 8 dereferenceable(8) %call) #18
  ret void
}

; Function Attrs: convergent
declare dso_local void @_ZNSt10filesystem7__cxx1116filesystem_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt10error_code(ptr nonnull align 8 dereferenceable(48), ptr nonnull align 8 dereferenceable(32), ptr align 8 dead_on_return) unnamed_addr #1

; Function Attrs: convergent nounwind
declare dso_local void @_ZNSt10filesystem7__cxx1116filesystem_errorD1Ev(ptr nonnull align 8 dereferenceable(48)) unnamed_addr #6

declare dso_local void @__cxa_throw(ptr, ptr, ptr)

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev(ptr nonnull align 8 dereferenceable(32) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIcED1Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIcED2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

declare dso_local void @__cxa_free_exception(ptr)

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIcEC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt15__new_allocatorIcEC2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIcEC2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_(ptr nonnull align 8 dereferenceable(32) %this, ptr %__s, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #0 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %__end = alloca ptr, align 8
  %agg.tmp = alloca %"struct.std::forward_iterator_tag", align 1
  store ptr %this, ptr %this.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  %call = call ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_(ptr nonnull align 8 dereferenceable(8) %_M_dataplus, ptr %call, ptr nonnull align 1 dereferenceable(1) %0) #17
  %1 = load ptr, ptr %__s.addr, align 8
  %cmp = icmp eq ptr %1, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  invoke void @_ZSt19__throw_logic_errorPKc(ptr @.str.13) #25
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.then
  unreachable

lpad:                                             ; preds = %if.end, %if.then
  %2 = landingpad { ptr, i32 }
          cleanup
  %3 = extractvalue { ptr, i32 } %2, 0
  store ptr %3, ptr %exn.slot, align 8
  %4 = extractvalue { ptr, i32 } %2, 1
  store i32 %4, ptr %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev(ptr nonnull align 8 dereferenceable(8) %_M_dataplus) #18
  br label %eh.resume

if.end:                                           ; preds = %entry
  %5 = load ptr, ptr %__s.addr, align 8
  %6 = load ptr, ptr %__s.addr, align 8
  %call2 = call i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr %6) #17
  %add.ptr = getelementptr inbounds nuw i8, ptr %5, i64 %call2
  store ptr %add.ptr, ptr %__end, align 8
  %7 = load ptr, ptr %__s.addr, align 8
  %8 = load ptr, ptr %__end, align 8
  %coerce.dive = getelementptr inbounds nuw %"struct.std::forward_iterator_tag", ptr %agg.tmp, i32 0, i32 0
  %9 = load i8, ptr %coerce.dive, align 1
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag(ptr nonnull align 8 dereferenceable(32) %this1, ptr %7, ptr %8, i8 %9) #17
          to label %invoke.cont3 unwind label %lpad

invoke.cont3:                                     ; preds = %if.end
  ret void

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val4 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val4
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 2
  %arraydecay = getelementptr inbounds [16 x i8], ptr %0, i64 0, i64 0
  %call = call ptr @_ZNSt19__ptr_traits_ptr_toIPccLb0EE10pointer_toERc(ptr nonnull align 1 dereferenceable(1) %arraydecay) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__dat, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__dat.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__dat, ptr %__dat.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__dat.addr, align 8
  %1 = load ptr, ptr %__a.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_(ptr nonnull align 8 dereferenceable(8) %this1, ptr %0, ptr nonnull align 1 dereferenceable(1) %1) #17
  ret void
}

; Function Attrs: cold convergent noreturn
declare dso_local void @_ZSt19__throw_logic_errorPKc(ptr) #12

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag(ptr nonnull align 8 dereferenceable(32) %this, ptr %__beg, ptr %__end, i8 %.coerce) #0 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %0 = alloca %"struct.std::forward_iterator_tag", align 1
  %this.addr = alloca ptr, align 8
  %__beg.addr = alloca ptr, align 8
  %__end.addr = alloca ptr, align 8
  %__dnew = alloca i64, align 8
  %__guard = alloca %struct._Guard, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %coerce.dive = getelementptr inbounds nuw %"struct.std::forward_iterator_tag", ptr %0, i32 0, i32 0
  store i8 %.coerce, ptr %coerce.dive, align 1
  store ptr %this, ptr %this.addr, align 8
  store ptr %__beg, ptr %__beg.addr, align 8
  store ptr %__end, ptr %__end.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %1 = load ptr, ptr %__beg.addr, align 8
  %2 = load ptr, ptr %__end.addr, align 8
  %call = call i64 @_ZSt8distanceIPKcENSt15iterator_traitsIT_E15difference_typeES3_S3_(ptr %1, ptr %2) #17
  store i64 %call, ptr %__dnew, align 8
  %3 = load i64, ptr %__dnew, align 8
  %cmp = icmp ugt i64 %3, 15
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call2 = call ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERyy(ptr nonnull align 8 dereferenceable(32) %this1, ptr nonnull align 8 dereferenceable(8) %__dnew, i64 0) #17
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc(ptr nonnull align 8 dereferenceable(32) %this1, ptr %call2) #17
  %4 = load i64, ptr %__dnew, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %4) #17
  br label %if.end

if.else:                                          ; preds = %entry
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_(ptr nonnull align 8 dereferenceable(8) %__guard, ptr %this1) #17
  %call3 = invoke ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.end
  %5 = load ptr, ptr %__beg.addr, align 8
  %6 = load ptr, ptr %__end.addr, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsIPKcEEvPcT_S9_(ptr %call3, ptr %5, ptr %6) #17
          to label %invoke.cont4 unwind label %lpad

invoke.cont4:                                     ; preds = %invoke.cont
  %_M_guarded = getelementptr inbounds nuw %struct._Guard, ptr %__guard, i32 0, i32 0
  store ptr null, ptr %_M_guarded, align 8
  %7 = load i64, ptr %__dnew, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %7) #17
          to label %invoke.cont5 unwind label %lpad

invoke.cont5:                                     ; preds = %invoke.cont4
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev(ptr nonnull align 8 dereferenceable(8) %__guard) #18
  ret void

lpad:                                             ; preds = %invoke.cont4, %invoke.cont, %if.end
  %8 = landingpad { ptr, i32 }
          cleanup
  %9 = extractvalue { ptr, i32 } %8, 0
  store ptr %9, ptr %exn.slot, align 8
  %10 = extractvalue { ptr, i32 } %8, 1
  store i32 %10, ptr %ehselector.slot, align 4
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev(ptr nonnull align 8 dereferenceable(8) %__guard) #18
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val6 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt19__ptr_traits_ptr_toIPccLb0EE10pointer_toERc(ptr nonnull align 1 dereferenceable(1) %__r) #3 comdat align 2 {
entry:
  %__r.addr = alloca ptr, align 8
  store ptr %__r, ptr %__r.addr, align 8
  %0 = load ptr, ptr %__r.addr, align 8, !nonnull !5
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__dat, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__dat.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__dat, ptr %__dat.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  call void @_ZNSaIcEC2ERKS_(ptr nonnull align 1 dereferenceable(1) %this1, ptr nonnull align 1 dereferenceable(1) %0) #18
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %__dat.addr, align 8
  store ptr %1, ptr %_M_p, align 8
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIcEC2ERKS_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %__a) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__a.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  call void @_ZNSt15__new_allocatorIcEC2ERKS0_(ptr nonnull align 1 dereferenceable(1) %this1, ptr nonnull align 1 dereferenceable(1) %0) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIcEC2ERKS0_(ptr nonnull align 1 dereferenceable(1) %this, ptr nonnull align 1 dereferenceable(1) %0) unnamed_addr #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %0, ptr %.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i64 @_ZSt8distanceIPKcENSt15iterator_traitsIT_E15difference_typeES3_S3_(ptr %__first, ptr %__last) #9 comdat {
entry:
  %__first.addr = alloca ptr, align 8
  %__last.addr = alloca ptr, align 8
  store ptr %__first, ptr %__first.addr, align 8
  store ptr %__last, ptr %__last.addr, align 8
  %0 = load ptr, ptr %__last.addr, align 8
  %1 = load ptr, ptr %__first.addr, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %0 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %1 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  ret i64 %sub.ptr.sub
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc(ptr nonnull align 8 dereferenceable(32) %this, ptr %__p) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", ptr %_M_dataplus, i32 0, i32 0
  store ptr %0, ptr %_M_p, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERyy(ptr nonnull align 8 dereferenceable(32) %this, ptr nonnull align 8 dereferenceable(8) %__capacity, i64 %__old_capacity) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__capacity.addr = alloca ptr, align 8
  %__old_capacity.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__capacity, ptr %__capacity.addr, align 8
  store i64 %__old_capacity, ptr %__old_capacity.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %1 = load i64, ptr %0, align 8
  %call = call i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp = icmp ugt i64 %1, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @_ZSt20__throw_length_errorPKc(ptr @.str.8) #25
  unreachable

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %3 = load i64, ptr %2, align 8
  %4 = load i64, ptr %__old_capacity.addr, align 8
  %cmp2 = icmp ugt i64 %3, %4
  br i1 %cmp2, label %land.lhs.true, label %if.end11

land.lhs.true:                                    ; preds = %if.end
  %5 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %6 = load i64, ptr %5, align 8
  %7 = load i64, ptr %__old_capacity.addr, align 8
  %mul = mul i64 2, %7
  %cmp3 = icmp ult i64 %6, %mul
  br i1 %cmp3, label %if.then4, label %if.end11

if.then4:                                         ; preds = %land.lhs.true
  %8 = load i64, ptr %__old_capacity.addr, align 8
  %mul5 = mul i64 2, %8
  %9 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  store i64 %mul5, ptr %9, align 8
  %10 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %11 = load i64, ptr %10, align 8
  %call6 = call i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %cmp7 = icmp ugt i64 %11, %call6
  br i1 %cmp7, label %if.then8, label %if.end10

if.then8:                                         ; preds = %if.then4
  %call9 = call i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this1) #18
  %12 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  store i64 %call9, ptr %12, align 8
  br label %if.end10

if.end10:                                         ; preds = %if.then8, %if.then4
  br label %if.end11

if.end11:                                         ; preds = %if.end10, %land.lhs.true, %if.end
  %call12 = call nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %13 = load ptr, ptr %__capacity.addr, align 8, !nonnull !5, !align !6
  %14 = load i64, ptr %13, align 8
  %add = add i64 %14, 1
  %call13 = call ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_S_allocateERS3_y(ptr nonnull align 1 dereferenceable(1) %call12, i64 %add) #17
  ret ptr %call13
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__capacity) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__capacity.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__capacity, ptr %__capacity.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__capacity.addr, align 8
  %1 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 2
  store i64 %0, ptr %1, align 8
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE17_M_init_local_bufEv(ptr nonnull align 8 dereferenceable(32) %this) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__s) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__s.addr, align 8
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_(ptr nonnull align 8 dereferenceable(8) %this1, ptr %0) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsIPKcEEvPcT_S9_(ptr %__p, ptr %__k1, ptr %__k2) #0 comdat align 2 {
entry:
  %__p.addr = alloca ptr, align 8
  %__k1.addr = alloca ptr, align 8
  %__k2.addr = alloca ptr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store ptr %__k1, ptr %__k1.addr, align 8
  store ptr %__k2, ptr %__k2.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  %1 = load ptr, ptr %__k1.addr, align 8
  %call = call ptr @_ZSt12__niter_baseIPKcET_S2_(ptr %1) #18
  %2 = load ptr, ptr %__k2.addr, align 8
  %3 = load ptr, ptr %__k1.addr, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %2 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %3 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_S_copyEPcPKcy(ptr %0, ptr %call, i64 %sub.ptr.sub) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  %_M_p = getelementptr inbounds nuw %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", ptr %_M_dataplus, i32 0, i32 0
  %0 = load ptr, ptr %_M_p, align 8
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__n) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %ref.tmp = alloca i8, align 1
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load i64, ptr %__n.addr, align 8
  %arrayidx = getelementptr inbounds nuw i8, ptr %call, i64 %0
  store i8 0, ptr %ref.tmp, align 1
  call void @_ZNSt11char_traitsIcE6assignERcRKc(ptr nonnull align 1 dereferenceable(1) %arrayidx, ptr nonnull align 1 dereferenceable(1) %ref.tmp) #18
  %1 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_lengthEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev(ptr nonnull align 8 dereferenceable(8) %this1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE8max_sizeEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__diffmax = alloca i64, align 8
  %__allocmax = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  store i64 9223372036854775807, ptr %__diffmax, align 8
  %call = invoke nonnull align 1 dereferenceable(1) ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %call2 = call i64 @_ZNSt16allocator_traitsISaIcEE8max_sizeERKS0_(ptr nonnull align 1 dereferenceable(1) %call) #18
  store i64 %call2, ptr %__allocmax, align 8
  %call3 = call nonnull align 8 dereferenceable(8) ptr @_ZSt3minIyERKT_S2_S2_(ptr nonnull align 8 dereferenceable(8) %__diffmax, ptr nonnull align 8 dereferenceable(8) %__allocmax) #17
  %0 = load i64, ptr %call3, align 8
  %sub = sub i64 %0, 1
  ret i64 %sub

terminate.lpad:                                   ; preds = %entry
  %1 = landingpad { ptr, i32 }
          catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  call void @__clang_call_terminate(ptr %2) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_S_allocateERS3_y(ptr nonnull align 1 dereferenceable(1) %__a, i64 %__n) #0 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %__p = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt16allocator_traitsISaIcEE8allocateERS0_y(ptr nonnull align 1 dereferenceable(1) %0, i64 %1) #17
  store ptr %call, ptr %__p, align 8
  %2 = load ptr, ptr %__p, align 8
  ret ptr %2
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  ret ptr %_M_dataplus
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i64 @_ZNSt16allocator_traitsISaIcEE8max_sizeERKS0_(ptr nonnull align 1 dereferenceable(1) %__a) #9 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  store ptr %__a, ptr %__a.addr, align 8
  ret i64 -1
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  ret ptr %_M_dataplus
}

; Function Attrs: alwaysinline convergent mustprogress
define linkonce_odr dso_local ptr @_ZNSt16allocator_traitsISaIcEE8allocateERS0_y(ptr nonnull align 1 dereferenceable(1) %__a, i64 %__n) #7 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSaIcE8allocateEy(ptr nonnull align 1 dereferenceable(1) %0, i64 %1) #17
  ret ptr %call
}

; Function Attrs: alwaysinline convergent mustprogress
define available_externally dso_local ptr @_ZNSaIcE8allocateEy(ptr nonnull align 1 dereferenceable(1) %this, i64 %__n) #7 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt15__new_allocatorIcE8allocateEyPKv(ptr nonnull align 1 dereferenceable(1) %this1, i64 %0, ptr null) #17
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local ptr @_ZNSt15__new_allocatorIcE8allocateEyPKv(ptr nonnull align 1 dereferenceable(1) %this, i64 %__n, ptr %0) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  %.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  store ptr %0, ptr %.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %1 = load i64, ptr %__n.addr, align 8
  %call = call i64 @_ZNKSt15__new_allocatorIcE11_M_max_sizeEv(ptr nonnull align 1 dereferenceable(1) %this1) #18
  %cmp = icmp ugt i64 %1, %call
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i64, ptr %__n.addr, align 8
  %cmp2 = icmp ugt i64 %2, -1
  br i1 %cmp2, label %if.then3, label %if.end

if.then3:                                         ; preds = %if.then
  call void @_ZSt28__throw_bad_array_new_lengthv() #22
  unreachable

if.end:                                           ; preds = %if.then
  call void @_ZSt17__throw_bad_allocv() #22
  unreachable

if.else:                                          ; preds = %entry
  %3 = load i64, ptr %__n.addr, align 8
  %mul = mul i64 %3, 1
  %call4 = call noalias nonnull ptr @_Znwy(i64 %mul) #26
  ret ptr %call4
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local i64 @_ZNKSt15__new_allocatorIcE11_M_max_sizeEv(ptr nonnull align 1 dereferenceable(1) %this) #9 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret i64 9223372036854775807
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_(ptr nonnull align 8 dereferenceable(8) %this, ptr %__s) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_guarded = getelementptr inbounds nuw %struct._Guard, ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %__s.addr, align 8
  store ptr %0, ptr %_M_guarded, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_S_copyEPcPKcy(ptr %__d, ptr %__s, i64 %__n) #0 comdat align 2 {
entry:
  %__d.addr = alloca ptr, align 8
  %__s.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__d, ptr %__d.addr, align 8
  store ptr %__s, ptr %__s.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__d.addr, align 8
  %2 = load ptr, ptr %__s.addr, align 8
  call void @_ZNSt11char_traitsIcE6assignERcRKc(ptr nonnull align 1 dereferenceable(1) %1, ptr nonnull align 1 dereferenceable(1) %2) #18
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load ptr, ptr %__d.addr, align 8
  %4 = load ptr, ptr %__s.addr, align 8
  %5 = load i64, ptr %__n.addr, align 8
  %call = call ptr @_ZNSt11char_traitsIcE4copyEPcPKcy(ptr %3, ptr %4, i64 %5) #17
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define linkonce_odr dso_local ptr @_ZSt12__niter_baseIPKcET_S2_(ptr %__it) #9 comdat {
entry:
  %__it.addr = alloca ptr, align 8
  store ptr %__it, ptr %__it.addr, align 8
  %0 = load ptr, ptr %__it.addr, align 8
  ret ptr %0
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt11char_traitsIcE6assignERcRKc(ptr nonnull align 1 dereferenceable(1) %__c1, ptr nonnull align 1 dereferenceable(1) %__c2) #3 comdat align 2 {
entry:
  %__c1.addr = alloca ptr, align 8
  %__c2.addr = alloca ptr, align 8
  store ptr %__c1, ptr %__c1.addr, align 8
  store ptr %__c2, ptr %__c2.addr, align 8
  %0 = load ptr, ptr %__c2.addr, align 8, !nonnull !5
  %1 = load i8, ptr %0, align 1
  %2 = load ptr, ptr %__c1.addr, align 8, !nonnull !5
  store i8 %1, ptr %2, align 1
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt11char_traitsIcE4copyEPcPKcy(ptr %__s1, ptr %__s2, i64 %__n) #3 comdat align 2 {
entry:
  %retval = alloca ptr, align 8
  %__s1.addr = alloca ptr, align 8
  %__s2.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__s1, ptr %__s1.addr, align 8
  store ptr %__s2, ptr %__s2.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load i64, ptr %__n.addr, align 8
  %cmp = icmp eq i64 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %__s1.addr, align 8
  store ptr %1, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %2 = load ptr, ptr %__s1.addr, align 8
  %3 = load ptr, ptr %__s2.addr, align 8
  %4 = load i64, ptr %__n.addr, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %2, ptr align 1 %3, i64 %4, i1 false)
  store ptr %2, ptr %retval, align 8
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load ptr, ptr %retval, align 8
  ret ptr %5
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_lengthEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__length) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__length.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__length, ptr %__length.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i64, ptr %__length.addr, align 8
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 1
  store i64 %0, ptr %_M_string_length, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_guarded = getelementptr inbounds nuw %struct._Guard, ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %_M_guarded, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %_M_guarded2 = getelementptr inbounds nuw %struct._Guard, ptr %this1, i32 0, i32 0
  %1 = load ptr, ptr %_M_guarded2, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %if.then
  br label %if.end

if.end:                                           ; preds = %invoke.cont, %entry
  ret void

terminate.lpad:                                   ; preds = %if.then
  %2 = landingpad { ptr, i32 }
          catch ptr null
  %3 = extractvalue { ptr, i32 } %2, 0
  call void @__clang_call_terminate(ptr %3) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %this) #0 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call zeroext i1 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  br i1 %call, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 2
  %1 = load i64, ptr %0, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_destroyEy(ptr nonnull align 8 dereferenceable(32) %this1, i64 %1) #18
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent mustprogress noinline optnone
define linkonce_odr dso_local zeroext i1 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_is_localEv(ptr nonnull align 8 dereferenceable(32) %this) #0 comdat align 2 {
entry:
  %retval = alloca i1, align 1
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %call2 = call ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %cmp = icmp eq ptr %call, %call2
  br i1 %cmp, label %if.then, label %if.end5

if.then:                                          ; preds = %entry
  %_M_string_length = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 1
  %0 = load i64, ptr %_M_string_length, align 8
  %cmp3 = icmp ugt i64 %0, 15
  br i1 %cmp3, label %if.then4, label %if.end

if.then4:                                         ; preds = %if.then
  unreachable

if.end:                                           ; preds = %if.then
  store i1 true, ptr %retval, align 1
  br label %return

if.end5:                                          ; preds = %entry
  store i1 false, ptr %retval, align 1
  br label %return

return:                                           ; preds = %if.end5, %if.end
  %1 = load i1, ptr %retval, align 1
  ret i1 %1
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_destroyEy(ptr nonnull align 8 dereferenceable(32) %this, i64 %__size) #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  %__size.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store i64 %__size, ptr %__size.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %call = call nonnull align 1 dereferenceable(1) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE16_M_get_allocatorEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %call2 = call ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
  %0 = load i64, ptr %__size.addr, align 8
  %add = add i64 %0, 1
  invoke void @_ZNSt16allocator_traitsISaIcEE10deallocateERS0_Pcy(ptr nonnull align 1 dereferenceable(1) %call, ptr %call2, i64 %add) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %1 = landingpad { ptr, i32 }
          catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  call void @__clang_call_terminate(ptr %2) #19
  unreachable
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr nonnull align 8 dereferenceable(32) %this) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 2
  %arraydecay = getelementptr inbounds [16 x i8], ptr %0, i64 0, i64 0
  %call = call ptr @_ZNSt19__ptr_traits_ptr_toIPKcS0_Lb0EE10pointer_toERS0_(ptr nonnull align 1 dereferenceable(1) %arraydecay) #18
  ret ptr %call
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local ptr @_ZNSt19__ptr_traits_ptr_toIPKcS0_Lb0EE10pointer_toERS0_(ptr nonnull align 1 dereferenceable(1) %__r) #3 comdat align 2 {
entry:
  %__r.addr = alloca ptr, align 8
  store ptr %__r, ptr %__r.addr, align 8
  %0 = load ptr, ptr %__r.addr, align 8, !nonnull !5
  ret ptr %0
}

; Function Attrs: alwaysinline convergent mustprogress
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaIcEE10deallocateERS0_Pcy(ptr nonnull align 1 dereferenceable(1) %__a, ptr %__p, i64 %__n) #7 comdat align 2 {
entry:
  %__a.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %__a, ptr %__a.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %0 = load ptr, ptr %__a.addr, align 8, !nonnull !5
  %1 = load ptr, ptr %__p.addr, align 8
  %2 = load i64, ptr %__n.addr, align 8
  call void @_ZNSaIcE10deallocateEPcy(ptr nonnull align 1 dereferenceable(1) %0, ptr %1, i64 %2) #17
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress
define available_externally dso_local void @_ZNSaIcE10deallocateEPcy(ptr nonnull align 1 dereferenceable(1) %this, ptr %__p, i64 %__n) #7 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  %1 = load i64, ptr %__n.addr, align 8
  call void @_ZNSt15__new_allocatorIcE10deallocateEPcy(ptr nonnull align 1 dereferenceable(1) %this1, ptr %0, i64 %1) #17
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt15__new_allocatorIcE10deallocateEPcy(ptr nonnull align 1 dereferenceable(1) %this, ptr %__p, i64 %__n) #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__p.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %__p, ptr %__p.addr, align 8
  store i64 %__n, ptr %__n.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load ptr, ptr %__p.addr, align 8
  call void @_ZdlPv(ptr %0) #21
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev(ptr nonnull align 8 dereferenceable(8) %this) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  call void @_ZNSaIcED2Ev(ptr nonnull align 1 dereferenceable(1) %this1) #18
  ret void
}

; Function Attrs: alwaysinline convergent mustprogress nounwind
define available_externally dso_local void @_ZNSaIcED2Ev(ptr nonnull align 1 dereferenceable(1) %this) unnamed_addr #9 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  ret void
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSt3_V216generic_categoryEv() #16

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10error_codeC1EiRKNSt3_V214error_categoryE(ptr nonnull align 8 dereferenceable(16) %this, i32 %__v, ptr nonnull align 8 dereferenceable(8) %__cat) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__v.addr = alloca i32, align 4
  %__cat.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i32 %__v, ptr %__v.addr, align 4
  store ptr %__cat, ptr %__cat.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %0 = load i32, ptr %__v.addr, align 4
  %1 = load ptr, ptr %__cat.addr, align 8
  call void @_ZNSt10error_codeC2EiRKNSt3_V214error_categoryE(ptr nonnull align 8 dereferenceable(16) %this1, i32 %0, ptr nonnull align 8 dereferenceable(8) %1) #18
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt10error_codeC2EiRKNSt3_V214error_categoryE(ptr nonnull align 8 dereferenceable(16) %this, i32 %__v, ptr nonnull align 8 dereferenceable(8) %__cat) unnamed_addr #3 comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__v.addr = alloca i32, align 4
  %__cat.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  store i32 %__v, ptr %__v.addr, align 4
  store ptr %__cat, ptr %__cat.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_value = getelementptr inbounds nuw %"class.std::error_code", ptr %this1, i32 0, i32 0
  %0 = load i32, ptr %__v.addr, align 4
  store i32 %0, ptr %_M_value, align 8
  %_M_cat = getelementptr inbounds nuw %"class.std::error_code", ptr %this1, i32 0, i32 1
  %1 = load ptr, ptr %__cat.addr, align 8, !nonnull !5, !align !6
  store ptr %1, ptr %_M_cat, align 8
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev(ptr nonnull align 8 dereferenceable(32) %this) unnamed_addr #3 comdat align 2 personality ptr @__gxx_personality_seh0 {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv(ptr nonnull align 8 dereferenceable(32) %this1) #17
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %_M_dataplus = getelementptr inbounds nuw %"class.std::__cxx11::basic_string.3", ptr %this1, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev(ptr nonnull align 8 dereferenceable(8) %_M_dataplus) #18
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #19
  unreachable
}

attributes #0 = { convergent mustprogress noinline optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #1 = { convergent "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #2 = { convergent mustprogress noinline norecurse optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #3 = { convergent mustprogress noinline nounwind optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent noinline noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #6 = { convergent nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #7 = { alwaysinline convergent mustprogress "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #8 = { convergent nobuiltin nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #9 = { alwaysinline convergent mustprogress nounwind "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #10 = { convergent mustprogress noinline noreturn optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #11 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #12 = { cold convergent noreturn "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #13 = { convergent noreturn "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #14 = { convergent nobuiltin allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #15 = { cold convergent noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #16 = { convergent nounwind willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #17 = { convergent }
attributes #18 = { convergent nounwind }
attributes #19 = { noreturn nounwind }
attributes #20 = { nounwind }
attributes #21 = { builtin convergent nounwind }
attributes #22 = { convergent noreturn }
attributes #23 = { noreturn }
attributes #24 = { cold convergent noreturn nounwind }
attributes #25 = { cold convergent noreturn }
attributes #26 = { builtin convergent allocsize(0) }
attributes #27 = { convergent nounwind willreturn memory(none) }

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
!7 = !{i64 2}
!8 = !{i64 4}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10}
