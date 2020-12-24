; ModuleID = 'dekker.c'
source_filename = "dekker.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"dekker.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4
@turn = common dso_local global i32 0, align 4
@x = common dso_local global i32 0, align 4

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
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %5 = load i32, i32* @flag2, align 4
  store i32 %5, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %6

6:                                                ; preds = %21, %1
  %7 = load i32, i32* %3, align 4
  %8 = icmp sge i32 %7, 1
  br i1 %8, label %9, label %23

9:                                                ; preds = %6
  call void @__VERIFIER_atomic_begin()
  %10 = load i32, i32* @turn, align 4
  store i32 %10, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  %11 = load i32, i32* %4, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %21

13:                                               ; preds = %9
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %14 = load i32, i32* @turn, align 4
  store i32 %14, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %15

15:                                               ; preds = %18, %13
  %16 = load i32, i32* %4, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %15
  call void @__VERIFIER_atomic_begin()
  %19 = load i32, i32* @turn, align 4
  store i32 %19, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %15

20:                                               ; preds = %15
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  br label %21

21:                                               ; preds = %20, %9
  call void @__VERIFIER_atomic_begin()
  %22 = load i32, i32* @flag2, align 4
  store i32 %22, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %6

23:                                               ; preds = %6
  store i32 0, i32* @x, align 4
  %24 = load i32, i32* @x, align 4
  %25 = icmp sle i32 %24, 0
  br i1 %25, label %28, label %26

26:                                               ; preds = %23
  br label %27

27:                                               ; preds = %26
  call void @reach_error()
  br label %28

28:                                               ; preds = %27, %23
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @turn, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @flag1, align 4
  call void @__VERIFIER_atomic_end()
  ret i8* null
}

declare dso_local void @__VERIFIER_atomic_begin() #3

declare dso_local void @__VERIFIER_atomic_end() #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %5 = load i32, i32* @flag1, align 4
  store i32 %5, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %6

6:                                                ; preds = %21, %1
  %7 = load i32, i32* %3, align 4
  %8 = icmp sge i32 %7, 1
  br i1 %8, label %9, label %23

9:                                                ; preds = %6
  call void @__VERIFIER_atomic_begin()
  %10 = load i32, i32* @turn, align 4
  store i32 %10, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  %11 = load i32, i32* %4, align 4
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %21

13:                                               ; preds = %9
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %14 = load i32, i32* @turn, align 4
  store i32 %14, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %15

15:                                               ; preds = %18, %13
  %16 = load i32, i32* %4, align 4
  %17 = icmp ne i32 %16, 1
  br i1 %17, label %18, label %20

18:                                               ; preds = %15
  call void @__VERIFIER_atomic_begin()
  %19 = load i32, i32* @turn, align 4
  store i32 %19, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %15

20:                                               ; preds = %15
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  br label %21

21:                                               ; preds = %20, %9
  call void @__VERIFIER_atomic_begin()
  %22 = load i32, i32* @flag1, align 4
  store i32 %22, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  br label %6

23:                                               ; preds = %6
  store i32 1, i32* @x, align 4
  %24 = load i32, i32* @x, align 4
  %25 = icmp sge i32 %24, 1
  br i1 %25, label %28, label %26

26:                                               ; preds = %23
  br label %27

27:                                               ; preds = %26
  call void @reach_error()
  br label %28

28:                                               ; preds = %27, %23
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @turn, align 4
  call void @__VERIFIER_atomic_end()
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
  %4 = load i32, i32* @turn, align 4
  %5 = icmp sle i32 0, %4
  br i1 %5, label %6, label %9

6:                                                ; preds = %0
  %7 = load i32, i32* @turn, align 4
  %8 = icmp sle i32 %7, 1
  br label %9

9:                                                ; preds = %6, %0
  %10 = phi i1 [ false, %0 ], [ %8, %6 ]
  %11 = zext i1 %10 to i32
  call void @assume_abort_if_not(i32 %11)
  %12 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @thr1, i8* null) #7
  %13 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @thr2, i8* null) #7
  %14 = load i64, i64* %2, align 8
  %15 = call i32 @pthread_join(i64 %14, i8** null)
  %16 = load i64, i64* %3, align 8
  %17 = call i32 @pthread_join(i64 %16, i8** null)
  ret i32 0
}

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #4

declare dso_local i32 @pthread_join(i64, i8**) #3

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
