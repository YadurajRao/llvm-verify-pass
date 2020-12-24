; ModuleID = 'qrcu-2.c'
source_filename = "qrcu-2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_mutexattr_t = type { i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"qrcu-2.c\00", align 1
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
define dso_local void @__VERIFIER_atomic_take_snapshot(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* @readerprogress1, align 4
  store i32 %5, i32* %3, align 4
  %6 = load i32, i32* @readerprogress2, align 4
  store i32 %6, i32* %4, align 4
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
  %7 = call i32 (...) @__VERIFIER_nondet_int()
  store i32 %7, i32* %4, align 4
  %8 = call i32 (...) @__VERIFIER_nondet_int()
  store i32 %8, i32* %5, align 4
  %9 = load i32, i32* %4, align 4
  %10 = load i32, i32* %5, align 4
  call void @__VERIFIER_atomic_take_snapshot(i32 %9, i32 %10)
  %11 = call i32 (...) @__VERIFIER_nondet_int()
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %18

13:                                               ; preds = %1
  %14 = load i32, i32* @ctr1, align 4
  store i32 %14, i32* %6, align 4
  %15 = load i32, i32* %6, align 4
  %16 = load i32, i32* @ctr2, align 4
  %17 = add nsw i32 %15, %16
  store i32 %17, i32* %6, align 4
  br label %23

18:                                               ; preds = %1
  %19 = load i32, i32* @ctr2, align 4
  store i32 %19, i32* %6, align 4
  %20 = load i32, i32* %6, align 4
  %21 = load i32, i32* @ctr1, align 4
  %22 = add nsw i32 %20, %21
  store i32 %22, i32* %6, align 4
  br label %23

23:                                               ; preds = %18, %13
  %24 = load i32, i32* %6, align 4
  %25 = icmp sle i32 %24, 1
  br i1 %25, label %26, label %40

26:                                               ; preds = %23
  %27 = call i32 (...) @__VERIFIER_nondet_int()
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %34

29:                                               ; preds = %26
  %30 = load i32, i32* @ctr1, align 4
  store i32 %30, i32* %6, align 4
  %31 = load i32, i32* %6, align 4
  %32 = load i32, i32* @ctr2, align 4
  %33 = add nsw i32 %31, %32
  store i32 %33, i32* %6, align 4
  br label %39

34:                                               ; preds = %26
  %35 = load i32, i32* @ctr2, align 4
  store i32 %35, i32* %6, align 4
  %36 = load i32, i32* %6, align 4
  %37 = load i32, i32* @ctr1, align 4
  %38 = add nsw i32 %36, %37
  store i32 %38, i32* %6, align 4
  br label %39

39:                                               ; preds = %34, %29
  br label %41

40:                                               ; preds = %23
  br label %41

41:                                               ; preds = %40, %39
  %42 = load i32, i32* %6, align 4
  %43 = icmp sgt i32 %42, 1
  br i1 %43, label %44, label %75

44:                                               ; preds = %41
  %45 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* @mutex) #7
  %46 = load i32, i32* @idx, align 4
  %47 = icmp sle i32 %46, 0
  br i1 %47, label %48, label %53

48:                                               ; preds = %44
  %49 = load i32, i32* @ctr2, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* @ctr2, align 4
  store i32 1, i32* @idx, align 4
  %51 = load i32, i32* @ctr1, align 4
  %52 = add nsw i32 %51, -1
  store i32 %52, i32* @ctr1, align 4
  br label %58

53:                                               ; preds = %44
  %54 = load i32, i32* @ctr1, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* @ctr1, align 4
  store i32 0, i32* @idx, align 4
  %56 = load i32, i32* @ctr2, align 4
  %57 = add nsw i32 %56, -1
  store i32 %57, i32* @ctr2, align 4
  br label %58

58:                                               ; preds = %53, %48
  %59 = load i32, i32* @idx, align 4
  %60 = icmp sle i32 %59, 0
  br i1 %60, label %61, label %67

61:                                               ; preds = %58
  br label %62

62:                                               ; preds = %65, %61
  %63 = load i32, i32* @ctr1, align 4
  %64 = icmp sgt i32 %63, 0
  br i1 %64, label %65, label %66

65:                                               ; preds = %62
  br label %62

66:                                               ; preds = %62
  br label %73

67:                                               ; preds = %58
  br label %68

68:                                               ; preds = %71, %67
  %69 = load i32, i32* @ctr2, align 4
  %70 = icmp sgt i32 %69, 0
  br i1 %70, label %71, label %72

71:                                               ; preds = %68
  br label %68

72:                                               ; preds = %68
  br label %73

73:                                               ; preds = %72, %66
  %74 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* @mutex) #7
  br label %76

75:                                               ; preds = %41
  br label %76

76:                                               ; preds = %75, %73
  %77 = load i32, i32* %4, align 4
  call void @__VERIFIER_atomic_check_progress1(i32 %77)
  %78 = load i32, i32* %5, align 4
  call void @__VERIFIER_atomic_check_progress2(i32 %78)
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
