; ModuleID = 'szymanski-b.c'
source_filename = "szymanski-b.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"szymanski-b.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4
@x = common dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  store i32 1, i32* @flag1, align 4
  br label %3

3:                                                ; preds = %6, %1
  %4 = load i32, i32* @flag2, align 4
  %5 = icmp sge i32 %4, 3
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  br label %3

7:                                                ; preds = %3
  store i32 3, i32* @flag1, align 4
  %8 = load i32, i32* @flag2, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  store i32 2, i32* @flag1, align 4
  br label %11

11:                                               ; preds = %14, %10
  %12 = load i32, i32* @flag2, align 4
  %13 = icmp ne i32 %12, 4
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  br label %11

15:                                               ; preds = %11
  br label %16

16:                                               ; preds = %15, %7
  store i32 4, i32* @flag1, align 4
  br label %17

17:                                               ; preds = %20, %16
  %18 = load i32, i32* @flag2, align 4
  %19 = icmp sge i32 %18, 2
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  br label %17

21:                                               ; preds = %17
  store i32 0, i32* @x, align 4
  %22 = load i32, i32* @x, align 4
  %23 = icmp sle i32 %22, 0
  br i1 %23, label %26, label %24

24:                                               ; preds = %21
  br label %25

25:                                               ; preds = %24
  call void @reach_error()
  br label %26

26:                                               ; preds = %25, %21
  br label %27

27:                                               ; preds = %35, %26
  %28 = load i32, i32* @flag2, align 4
  %29 = icmp sle i32 2, %28
  br i1 %29, label %30, label %33

30:                                               ; preds = %27
  %31 = load i32, i32* @flag2, align 4
  %32 = icmp sle i32 %31, 3
  br label %33

33:                                               ; preds = %30, %27
  %34 = phi i1 [ false, %27 ], [ %32, %30 ]
  br i1 %34, label %35, label %36

35:                                               ; preds = %33
  br label %27

36:                                               ; preds = %33
  store i32 0, i32* @flag1, align 4
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  store i32 1, i32* @flag2, align 4
  br label %3

3:                                                ; preds = %6, %1
  %4 = load i32, i32* @flag1, align 4
  %5 = icmp sge i32 %4, 3
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  br label %3

7:                                                ; preds = %3
  store i32 3, i32* @flag2, align 4
  %8 = load i32, i32* @flag1, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  store i32 2, i32* @flag2, align 4
  br label %11

11:                                               ; preds = %14, %10
  %12 = load i32, i32* @flag1, align 4
  %13 = icmp ne i32 %12, 4
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  br label %11

15:                                               ; preds = %11
  br label %16

16:                                               ; preds = %15, %7
  store i32 4, i32* @flag2, align 4
  br label %17

17:                                               ; preds = %20, %16
  %18 = load i32, i32* @flag1, align 4
  %19 = icmp sge i32 %18, 2
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  br label %17

21:                                               ; preds = %17
  store i32 1, i32* @x, align 4
  %22 = load i32, i32* @x, align 4
  %23 = icmp sge i32 %22, 1
  br i1 %23, label %26, label %24

24:                                               ; preds = %21
  br label %25

25:                                               ; preds = %24
  call void @reach_error()
  br label %26

26:                                               ; preds = %25, %21
  br label %27

27:                                               ; preds = %35, %26
  %28 = load i32, i32* @flag1, align 4
  %29 = icmp sle i32 2, %28
  br i1 %29, label %30, label %33

30:                                               ; preds = %27
  %31 = load i32, i32* @flag1, align 4
  %32 = icmp sle i32 %31, 3
  br label %33

33:                                               ; preds = %30, %27
  %34 = phi i1 [ false, %27 ], [ %32, %30 ]
  br i1 %34, label %35, label %36

35:                                               ; preds = %33
  br label %27

36:                                               ; preds = %33
  store i32 0, i32* @flag2, align 4
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
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #2

declare dso_local i32 @pthread_join(i64, i8**) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}