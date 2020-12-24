; ModuleID = 'lamport.c'
source_filename = "lamport.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"lamport.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@b1 = common dso_local global i32 0, align 4
@x = common dso_local global i32 0, align 4
@y = common dso_local global i32 0, align 4
@b2 = common dso_local global i32 0, align 4
@X = common dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  br label %6

6:                                                ; preds = %1, %17, %40
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @b1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @x, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %7 = load i32, i32* @y, align 4
  store i32 %7, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %8 = load i32, i32* %3, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %18

10:                                               ; preds = %6
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %11 = load i32, i32* @y, align 4
  store i32 %11, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %12

12:                                               ; preds = %15, %10
  %13 = load i32, i32* %3, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %12
  call void @__VERIFIER_atomic_begin()
  %16 = load i32, i32* @y, align 4
  store i32 %16, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %12

17:                                               ; preds = %12
  br label %6

18:                                               ; preds = %6
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @y, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %19 = load i32, i32* @x, align 4
  store i32 %19, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  %20 = load i32, i32* %4, align 4
  %21 = icmp ne i32 %20, 1
  br i1 %21, label %22, label %42

22:                                               ; preds = %18
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %23 = load i32, i32* @b2, align 4
  store i32 %23, i32* %5, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

24:                                               ; preds = %27, %22
  %25 = load i32, i32* %5, align 4
  %26 = icmp sge i32 %25, 1
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %28 = load i32, i32* @b2, align 4
  store i32 %28, i32* %5, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

29:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %30 = load i32, i32* @y, align 4
  store i32 %30, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %31 = load i32, i32* %3, align 4
  %32 = icmp ne i32 %31, 1
  br i1 %32, label %33, label %41

33:                                               ; preds = %29
  call void @__VERIFIER_atomic_begin()
  %34 = load i32, i32* @y, align 4
  store i32 %34, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %35

35:                                               ; preds = %38, %33
  %36 = load i32, i32* %3, align 4
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %38, label %40

38:                                               ; preds = %35
  call void @__VERIFIER_atomic_begin()
  %39 = load i32, i32* @y, align 4
  store i32 %39, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %35

40:                                               ; preds = %35
  br label %6

41:                                               ; preds = %29
  br label %42

42:                                               ; preds = %41, %18
  br label %43

43:                                               ; preds = %42
  store i32 0, i32* @X, align 4
  %44 = load i32, i32* @X, align 4
  %45 = icmp sle i32 %44, 0
  br i1 %45, label %48, label %46

46:                                               ; preds = %43
  br label %47

47:                                               ; preds = %46
  call void @reach_error()
  br label %48

48:                                               ; preds = %47, %43
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @y, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b1, align 4
  call void @__VERIFIER_atomic_end()
  ret i8* null
}

declare dso_local void @__VERIFIER_atomic_begin() #2

declare dso_local void @__VERIFIER_atomic_end() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  br label %6

6:                                                ; preds = %1, %17, %40
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @b2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 2, i32* @x, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %7 = load i32, i32* @y, align 4
  store i32 %7, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %8 = load i32, i32* %3, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %18

10:                                               ; preds = %6
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %11 = load i32, i32* @y, align 4
  store i32 %11, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %12

12:                                               ; preds = %15, %10
  %13 = load i32, i32* %3, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %12
  call void @__VERIFIER_atomic_begin()
  %16 = load i32, i32* @y, align 4
  store i32 %16, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %12

17:                                               ; preds = %12
  br label %6

18:                                               ; preds = %6
  call void @__VERIFIER_atomic_begin()
  store i32 2, i32* @y, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %19 = load i32, i32* @x, align 4
  store i32 %19, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  %20 = load i32, i32* %4, align 4
  %21 = icmp ne i32 %20, 2
  br i1 %21, label %22, label %42

22:                                               ; preds = %18
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %23 = load i32, i32* @b1, align 4
  store i32 %23, i32* %5, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

24:                                               ; preds = %27, %22
  %25 = load i32, i32* %5, align 4
  %26 = icmp sge i32 %25, 1
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %28 = load i32, i32* @b1, align 4
  store i32 %28, i32* %5, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

29:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %30 = load i32, i32* @y, align 4
  store i32 %30, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %31 = load i32, i32* %3, align 4
  %32 = icmp ne i32 %31, 2
  br i1 %32, label %33, label %41

33:                                               ; preds = %29
  call void @__VERIFIER_atomic_begin()
  %34 = load i32, i32* @y, align 4
  store i32 %34, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %35

35:                                               ; preds = %38, %33
  %36 = load i32, i32* %3, align 4
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %38, label %40

38:                                               ; preds = %35
  call void @__VERIFIER_atomic_begin()
  %39 = load i32, i32* @y, align 4
  store i32 %39, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %35

40:                                               ; preds = %35
  br label %6

41:                                               ; preds = %29
  br label %42

42:                                               ; preds = %41, %18
  br label %43

43:                                               ; preds = %42
  store i32 1, i32* @X, align 4
  %44 = load i32, i32* @X, align 4
  %45 = icmp sge i32 %44, 1
  br i1 %45, label %48, label %46

46:                                               ; preds = %43
  br label %47

47:                                               ; preds = %46
  call void @reach_error()
  br label %48

48:                                               ; preds = %47, %43
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @y, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @b2, align 4
  call void @__VERIFIER_atomic_end()
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  %4 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @thr1, i8* null) #5
  %5 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @thr2, i8* null) #5
  %6 = load i64, i64* %2, align 8
  %7 = call i32 @pthread_join(i64 %6, i8** null)
  %8 = load i64, i64* %3, align 8
  %9 = call i32 @pthread_join(i64 %8, i8** null)
  ret i32 0
}

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

declare dso_local i32 @pthread_join(i64, i8**) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}
