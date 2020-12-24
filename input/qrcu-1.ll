; ModuleID = 'qrcu-1.c'
source_filename = "qrcu-1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_mutexattr_t = type { i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"qrcu-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@idx = dso_local global i32 0, align 4
@ctr1 = dso_local global i32 1, align 4
@ctr2 = dso_local global i32 0, align 4
@readerprogress1 = dso_local global i32 0, align 4
@readerprogress2 = dso_local global i32 0, align 4
@mutex = common dso_local global %union.pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @assume_abort_if_not(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void @abort() #5
  unreachable

6:                                                ; preds = %1
  ret void
}

; Function Attrs: noreturn
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i32 7, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_use1(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp sle i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, i32* @ctr1, align 4
  %7 = icmp sgt i32 %6, 0
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ false, %1 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32
  call void @assume_abort_if_not(i32 %10)
  %11 = load i32, i32* @ctr1, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* @ctr1, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_use2(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp sge i32 %3, 1
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, i32* @ctr2, align 4
  %7 = icmp sgt i32 %6, 0
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ false, %1 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32
  call void @assume_abort_if_not(i32 %10)
  %11 = load i32, i32* @ctr2, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* @ctr2, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_use_done(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp sle i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, i32* @ctr1, align 4
  %7 = add nsw i32 %6, -1
  store i32 %7, i32* @ctr1, align 4
  br label %11

8:                                                ; preds = %1
  %9 = load i32, i32* @ctr2, align 4
  %10 = add nsw i32 %9, -1
  store i32 %10, i32* @ctr2, align 4
  br label %11

11:                                               ; preds = %8, %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_take_snapshot(i32* %0, i32* %1) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load i32, i32* @readerprogress1, align 4
  %6 = load i32*, i32** %3, align 8
  store i32 %5, i32* %6, align 4
  %7 = load i32, i32* @readerprogress2, align 4
  %8 = load i32*, i32** %4, align 8
  store i32 %7, i32* %8, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_check_progress1(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = call i32 (...) @__VERIFIER_nondet_int()
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %15

5:                                                ; preds = %1
  %6 = load i32, i32* %2, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %11

8:                                                ; preds = %5
  %9 = load i32, i32* @readerprogress1, align 4
  %10 = icmp eq i32 %9, 1
  br label %11

11:                                               ; preds = %8, %5
  %12 = phi i1 [ false, %5 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  call void @assume_abort_if_not(i32 %13)
  br label %14

14:                                               ; preds = %11
  call void @reach_error()
  br label %15

15:                                               ; preds = %14, %1
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int(...) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_check_progress2(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = call i32 (...) @__VERIFIER_nondet_int()
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %15

5:                                                ; preds = %1
  %6 = load i32, i32* %2, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %11

8:                                                ; preds = %5
  %9 = load i32, i32* @readerprogress2, align 4
  %10 = icmp eq i32 %9, 1
  br label %11

11:                                               ; preds = %8, %5
  %12 = phi i1 [ false, %5 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  call void @assume_abort_if_not(i32 %13)
  br label %14

14:                                               ; preds = %11
  call void @reach_error()
  br label %15

15:                                               ; preds = %14, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @qrcu_reader1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  br label %4

4:                                                ; preds = %1, %17
  %5 = load i32, i32* @idx, align 4
  store i32 %5, i32* %3, align 4
  %6 = call i32 (...) @__VERIFIER_nondet_int()
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %4
  %9 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use1(i32 %9)
  br label %18

10:                                               ; preds = %4
  %11 = call i32 (...) @__VERIFIER_nondet_int()
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use2(i32 %14)
  br label %18

15:                                               ; preds = %10
  br label %16

16:                                               ; preds = %15
  br label %17

17:                                               ; preds = %16
  br label %4

18:                                               ; preds = %13, %8
  store i32 1, i32* @readerprogress1, align 4
  store i32 2, i32* @readerprogress1, align 4
  %19 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use_done(i32 %19)
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @qrcu_reader2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  br label %4

4:                                                ; preds = %1, %17
  %5 = load i32, i32* @idx, align 4
  store i32 %5, i32* %3, align 4
  %6 = call i32 (...) @__VERIFIER_nondet_int()
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %4
  %9 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use1(i32 %9)
  br label %18

10:                                               ; preds = %4
  %11 = call i32 (...) @__VERIFIER_nondet_int()
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use2(i32 %14)
  br label %18

15:                                               ; preds = %10
  br label %16

16:                                               ; preds = %15
  br label %17

17:                                               ; preds = %16
  br label %4

18:                                               ; preds = %13, %8
  store i32 1, i32* @readerprogress2, align 4
  store i32 2, i32* @readerprogress2, align 4
  %19 = load i32, i32* %3, align 4
  call void @__VERIFIER_atomic_use_done(i32 %19)
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @qrcu_updater(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_take_snapshot(i32* %4, i32* %5)
  %7 = call i32 (...) @__VERIFIER_nondet_int()
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %14

9:                                                ; preds = %1
  %10 = load i32, i32* @ctr1, align 4
  store i32 %10, i32* %6, align 4
  %11 = load i32, i32* %6, align 4
  %12 = load i32, i32* @ctr2, align 4
  %13 = add nsw i32 %11, %12
  store i32 %13, i32* %6, align 4
  br label %19

14:                                               ; preds = %1
  %15 = load i32, i32* @ctr2, align 4
  store i32 %15, i32* %6, align 4
  %16 = load i32, i32* %6, align 4
  %17 = load i32, i32* @ctr1, align 4
  %18 = add nsw i32 %16, %17
  store i32 %18, i32* %6, align 4
  br label %19

19:                                               ; preds = %14, %9
  %20 = load i32, i32* %6, align 4
  %21 = icmp sle i32 %20, 1
  br i1 %21, label %22, label %36

22:                                               ; preds = %19
  %23 = call i32 (...) @__VERIFIER_nondet_int()
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %30

25:                                               ; preds = %22
  %26 = load i32, i32* @ctr1, align 4
  store i32 %26, i32* %6, align 4
  %27 = load i32, i32* %6, align 4
  %28 = load i32, i32* @ctr2, align 4
  %29 = add nsw i32 %27, %28
  store i32 %29, i32* %6, align 4
  br label %35

30:                                               ; preds = %22
  %31 = load i32, i32* @ctr2, align 4
  store i32 %31, i32* %6, align 4
  %32 = load i32, i32* %6, align 4
  %33 = load i32, i32* @ctr1, align 4
  %34 = add nsw i32 %32, %33
  store i32 %34, i32* %6, align 4
  br label %35

35:                                               ; preds = %30, %25
  br label %37

36:                                               ; preds = %19
  br label %37

37:                                               ; preds = %36, %35
  %38 = load i32, i32* %6, align 4
  %39 = icmp sgt i32 %38, 1
  br i1 %39, label %40, label %71

40:                                               ; preds = %37
  %41 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* @mutex) #7
  %42 = load i32, i32* @idx, align 4
  %43 = icmp sle i32 %42, 0
  br i1 %43, label %44, label %49

44:                                               ; preds = %40
  %45 = load i32, i32* @ctr2, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* @ctr2, align 4
  store i32 1, i32* @idx, align 4
  %47 = load i32, i32* @ctr1, align 4
  %48 = add nsw i32 %47, -1
  store i32 %48, i32* @ctr1, align 4
  br label %54

49:                                               ; preds = %40
  %50 = load i32, i32* @ctr1, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* @ctr1, align 4
  store i32 0, i32* @idx, align 4
  %52 = load i32, i32* @ctr2, align 4
  %53 = add nsw i32 %52, -1
  store i32 %53, i32* @ctr2, align 4
  br label %54

54:                                               ; preds = %49, %44
  %55 = load i32, i32* @idx, align 4
  %56 = icmp sle i32 %55, 0
  br i1 %56, label %57, label %63

57:                                               ; preds = %54
  br label %58

58:                                               ; preds = %61, %57
  %59 = load i32, i32* @ctr1, align 4
  %60 = icmp sgt i32 %59, 0
  br i1 %60, label %61, label %62

61:                                               ; preds = %58
  br label %58

62:                                               ; preds = %58
  br label %69

63:                                               ; preds = %54
  br label %64

64:                                               ; preds = %67, %63
  %65 = load i32, i32* @ctr2, align 4
  %66 = icmp sgt i32 %65, 0
  br i1 %66, label %67, label %68

67:                                               ; preds = %64
  br label %64

68:                                               ; preds = %64
  br label %69

69:                                               ; preds = %68, %62
  %70 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* @mutex) #7
  br label %72

71:                                               ; preds = %37
  br label %72

72:                                               ; preds = %71, %69
  %73 = load i32, i32* %4, align 4
  call void @__VERIFIER_atomic_check_progress1(i32 %73)
  %74 = load i32, i32* %5, align 4
  call void @__VERIFIER_atomic_check_progress2(i32 %74)
  ret i8* null
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_lock(%union.pthread_mutex_t*) #4

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_unlock(%union.pthread_mutex_t*) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  %5 = call i32 @pthread_mutex_init(%union.pthread_mutex_t* @mutex, %union.pthread_mutexattr_t* null) #7
  %6 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @qrcu_reader1, i8* null) #7
  %7 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @qrcu_reader2, i8* null) #7
  %8 = call i32 @pthread_create(i64* %4, %union.pthread_attr_t* null, i8* (i8*)* @qrcu_updater, i8* null) #7
  %9 = load i64, i64* %2, align 8
  %10 = call i32 @pthread_join(i64 %9, i8** null)
  %11 = load i64, i64* %3, align 8
  %12 = call i32 @pthread_join(i64 %11, i8** null)
  %13 = load i64, i64* %4, align 8
  %14 = call i32 @pthread_join(i64 %13, i8** null)
  %15 = call i32 @pthread_mutex_destroy(%union.pthread_mutex_t* @mutex) #7
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_init(%union.pthread_mutex_t*, %union.pthread_mutexattr_t*) #4

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #4

declare dso_local i32 @pthread_join(i64, i8**) #3

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_destroy(%union.pthread_mutex_t*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}
