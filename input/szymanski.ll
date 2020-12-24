; ModuleID = 'szymanski.c'
source_filename = "szymanski.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"szymanski.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4
@x = common dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %4 = load i32, i32* @flag2, align 4
  store i32 %4, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %5

5:                                                ; preds = %8, %1
  %6 = load i32, i32* %3, align 4
  %7 = icmp sge i32 %6, 3
  br i1 %7, label %8, label %10

8:                                                ; preds = %5
  call void @__VERIFIER_atomic_begin()
  %9 = load i32, i32* @flag2, align 4
  store i32 %9, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %5

10:                                               ; preds = %5
  call void @__VERIFIER_atomic_begin()
  store i32 3, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %11 = load i32, i32* @flag2, align 4
  store i32 %11, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %12 = load i32, i32* %3, align 4
  %13 = icmp eq i32 %12, 1
  br i1 %13, label %14, label %22

14:                                               ; preds = %10
  call void @__VERIFIER_atomic_begin()
  store i32 2, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %15 = load i32, i32* @flag2, align 4
  store i32 %15, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %16

16:                                               ; preds = %19, %14
  %17 = load i32, i32* %3, align 4
  %18 = icmp ne i32 %17, 4
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  call void @__VERIFIER_atomic_begin()
  %20 = load i32, i32* @flag2, align 4
  store i32 %20, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %16

21:                                               ; preds = %16
  br label %22

22:                                               ; preds = %21, %10
  call void @__VERIFIER_atomic_begin()
  store i32 4, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %23 = load i32, i32* @flag2, align 4
  store i32 %23, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

24:                                               ; preds = %27, %22
  %25 = load i32, i32* %3, align 4
  %26 = icmp sge i32 %25, 2
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %28 = load i32, i32* @flag2, align 4
  store i32 %28, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

29:                                               ; preds = %24
  store i32 0, i32* @x, align 4
  %30 = load i32, i32* @x, align 4
  %31 = icmp sle i32 %30, 0
  br i1 %31, label %34, label %32

32:                                               ; preds = %29
  br label %33

33:                                               ; preds = %32
  call void @reach_error()
  br label %34

34:                                               ; preds = %33, %29
  call void @__VERIFIER_atomic_begin()
  %35 = load i32, i32* @flag2, align 4
  store i32 %35, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %36

36:                                               ; preds = %44, %34
  %37 = load i32, i32* %3, align 4
  %38 = icmp sle i32 2, %37
  br i1 %38, label %39, label %42

39:                                               ; preds = %36
  %40 = load i32, i32* %3, align 4
  %41 = icmp sle i32 %40, 3
  br label %42

42:                                               ; preds = %39, %36
  %43 = phi i1 [ false, %36 ], [ %41, %39 ]
  br i1 %43, label %44, label %46

44:                                               ; preds = %42
  call void @__VERIFIER_atomic_begin()
  %45 = load i32, i32* @flag2, align 4
  store i32 %45, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %36

46:                                               ; preds = %42
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  ret i8* null
}

declare dso_local void @__VERIFIER_atomic_begin() #2

declare dso_local void @__VERIFIER_atomic_end() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %4 = load i32, i32* @flag1, align 4
  store i32 %4, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %5

5:                                                ; preds = %8, %1
  %6 = load i32, i32* %3, align 4
  %7 = icmp sge i32 %6, 3
  br i1 %7, label %8, label %10

8:                                                ; preds = %5
  call void @__VERIFIER_atomic_begin()
  %9 = load i32, i32* @flag1, align 4
  store i32 %9, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %5

10:                                               ; preds = %5
  call void @__VERIFIER_atomic_begin()
  store i32 3, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %11 = load i32, i32* @flag1, align 4
  store i32 %11, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  %12 = load i32, i32* %3, align 4
  %13 = icmp eq i32 %12, 1
  br i1 %13, label %14, label %22

14:                                               ; preds = %10
  call void @__VERIFIER_atomic_begin()
  store i32 2, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %15 = load i32, i32* @flag1, align 4
  store i32 %15, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %16

16:                                               ; preds = %19, %14
  %17 = load i32, i32* %3, align 4
  %18 = icmp ne i32 %17, 4
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  call void @__VERIFIER_atomic_begin()
  %20 = load i32, i32* @flag1, align 4
  store i32 %20, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %16

21:                                               ; preds = %16
  br label %22

22:                                               ; preds = %21, %10
  call void @__VERIFIER_atomic_begin()
  store i32 4, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %23 = load i32, i32* @flag1, align 4
  store i32 %23, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

24:                                               ; preds = %27, %22
  %25 = load i32, i32* %3, align 4
  %26 = icmp sge i32 %25, 2
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  call void @__VERIFIER_atomic_begin()
  %28 = load i32, i32* @flag1, align 4
  store i32 %28, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %24

29:                                               ; preds = %24
  store i32 1, i32* @x, align 4
  %30 = load i32, i32* @x, align 4
  %31 = icmp sge i32 %30, 1
  br i1 %31, label %34, label %32

32:                                               ; preds = %29
  br label %33

33:                                               ; preds = %32
  call void @reach_error()
  br label %34

34:                                               ; preds = %33, %29
  call void @__VERIFIER_atomic_begin()
  %35 = load i32, i32* @flag1, align 4
  store i32 %35, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %36

36:                                               ; preds = %44, %34
  %37 = load i32, i32* %3, align 4
  %38 = icmp sle i32 2, %37
  br i1 %38, label %39, label %42

39:                                               ; preds = %36
  %40 = load i32, i32* %3, align 4
  %41 = icmp sle i32 %40, 3
  br label %42

42:                                               ; preds = %39, %36
  %43 = phi i1 [ false, %36 ], [ %41, %39 ]
  br i1 %43, label %44, label %46

44:                                               ; preds = %42
  call void @__VERIFIER_atomic_begin()
  %45 = load i32, i32* @flag1, align 4
  store i32 %45, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %36

46:                                               ; preds = %42
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @flag2, align 4
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
