; ModuleID = '7.cpp'
source_filename = "7.cpp"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-w64-windows-gnu"

%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type <{ ptr, i32, [4 x i8] }>
%"class.std::locale" = type { ptr }

$_ZTIA16_Kc = comdat any

$_ZTSA16_Kc = comdat any

@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [19 x i8] c"this message does \00", align 1
@.str.1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.2 = private unnamed_addr constant [17 x i8] c"eat potato salad\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"Member1\00\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"Member2\00\00", align 1
@.str.5 = private unnamed_addr constant [9 x i8] c"Member3\00\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"Member4\00\00", align 1
@.str.7 = private unnamed_addr constant [9 x i8] c"Member5\00\00", align 1
@.str.8 = private unnamed_addr constant [9 x i8] c"Member6\00\00", align 1
@.str.9 = private unnamed_addr constant [9 x i8] c"Member7\00\00", align 1
@.str.10 = private unnamed_addr constant [16 x i8] c"bad enumerator\00\00", align 1
@_ZTIA16_Kc = linkonce_odr dso_local constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__array_type_infoE, i64 2), ptr @_ZTSA16_Kc }, comdat, align 8
@_ZTVN10__cxxabiv117__array_type_infoE = external global [0 x ptr]
@_ZTSA16_Kc = linkonce_odr dso_local constant [7 x i8] c"A16_Kc\00", comdat, align 1
@.str.11 = private unnamed_addr constant [39 x i8] c"this message does not eat potato salad\00", align 1

; Function Attrs: convergent mustprogress noinline optnone
define dso_local void @_Z4testv() #0 {
entry:
  %call = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr @.str) #3
  %call1 = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) %call, ptr @.str.1) #3
  %call2 = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) %call1, ptr @.str.2) #3
  %call3 = call nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8) %call2, ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_) #3
  ret void
}

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8), ptr) #1

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8), ptr) #1

; Function Attrs: convergent
declare dso_local nonnull align 8 dereferenceable(8) ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(ptr nonnull align 8 dereferenceable(8)) #1

; Function Attrs: convergent mustprogress noinline optnone
define dso_local ptr @_Z18EnumeratorToString14ReflectedEnum1(i32 %value) #0 {
entry:
  %retval = alloca ptr, align 8
  %value.addr = alloca i32, align 4
  store i32 %value, ptr %value.addr, align 4
  %0 = load i32, ptr %value.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store ptr @.str.3, ptr %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %1 = load i32, ptr %value.addr, align 4
  %cmp1 = icmp eq i32 %1, 1
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  store ptr @.str.4, ptr %retval, align 8
  br label %return

if.end3:                                          ; preds = %if.end
  %2 = load i32, ptr %value.addr, align 4
  %cmp4 = icmp eq i32 %2, 2
  br i1 %cmp4, label %if.then5, label %if.end6

if.then5:                                         ; preds = %if.end3
  store ptr @.str.5, ptr %retval, align 8
  br label %return

if.end6:                                          ; preds = %if.end3
  %3 = load i32, ptr %value.addr, align 4
  %cmp7 = icmp eq i32 %3, 8
  br i1 %cmp7, label %if.then8, label %if.end9

if.then8:                                         ; preds = %if.end6
  store ptr @.str.6, ptr %retval, align 8
  br label %return

if.end9:                                          ; preds = %if.end6
  %4 = load i32, ptr %value.addr, align 4
  %cmp10 = icmp eq i32 %4, 9
  br i1 %cmp10, label %if.then11, label %if.end12

if.then11:                                        ; preds = %if.end9
  store ptr @.str.7, ptr %retval, align 8
  br label %return

if.end12:                                         ; preds = %if.end9
  %5 = load i32, ptr %value.addr, align 4
  %cmp13 = icmp eq i32 %5, 10
  br i1 %cmp13, label %if.then14, label %if.end15

if.then14:                                        ; preds = %if.end12
  store ptr @.str.8, ptr %retval, align 8
  br label %return

if.end15:                                         ; preds = %if.end12
  %6 = load i32, ptr %value.addr, align 4
  %cmp16 = icmp eq i32 %6, 11
  br i1 %cmp16, label %if.then17, label %if.end18

if.then17:                                        ; preds = %if.end15
  store ptr @.str.9, ptr %retval, align 8
  br label %return

if.end18:                                         ; preds = %if.end15
  %exception = call ptr @__cxa_allocate_exception(i64 16) #4
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %exception, ptr align 1 @.str.10, i64 16, i1 false)
  call void @__cxa_throw(ptr %exception, ptr @_ZTIA16_Kc, ptr null) #5
  unreachable

return:                                           ; preds = %if.then17, %if.then14, %if.then11, %if.then8, %if.then5, %if.then2, %if.then
  %7 = load ptr, ptr %retval, align 8
  ret ptr %7
}

declare dso_local ptr @__cxa_allocate_exception(i64)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

declare dso_local void @__cxa_throw(ptr, ptr, ptr)

; Function Attrs: convergent mustprogress noinline optnone
define dso_local void @_Z10dmcre_mainRSt6vectorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE(ptr nonnull align 1 %argv) #0 {
entry:
  %argv.addr = alloca ptr, align 8
  store ptr %argv, ptr %argv.addr, align 8
  %call = call ptr @_Z18EnumeratorToString14ReflectedEnum1(i32 8) #3
  %call1 = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr %call) #3
  %call2 = call nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8) %call1, ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_) #3
  %call3 = call nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr @.str.11) #3
  %call4 = call nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSoS_E(ptr nonnull align 8 dereferenceable(8) %call3, ptr @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_) #3
  call void @_Z4testv() #3
  ret void
}

attributes #0 = { convergent mustprogress noinline optnone "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #1 = { convergent "no-trapping-math"="true" "stack-protector-buffer-size"="0" "target-cpu"="znver1" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sha,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { convergent }
attributes #4 = { nounwind }
attributes #5 = { noreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}
!llvm.ident = !{!4}
!dmcre.mtime = !{!5}
!dmcre.cache.include = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 23.1.3", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug)
!1 = !DIFile(filename: "<stdin>", directory: "")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"clang version 23.1.3"}
!5 = !{!"-4645358438304430300"}
!6 = !{!"<dmcre/foundation>", !"<dmcre/integer>", !"<dmcre/type>", !"C:/Users/lilit/Documents/dmcre/test/8.hpp", !"C:/Users/lilit/dmcre_2026101800/Headers/C++/dmcre/EnumStringConverter"}
