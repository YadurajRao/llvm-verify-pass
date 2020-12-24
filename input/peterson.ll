; ModuleID = 'peterson.c'
source_filename = "peterson.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"peterson.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4
@turn = common dso_local global i32 0, align 4
@x = common dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

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
  store i32 1, i32* @turn, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %5 = load i32, i32* @flag2, align 4
  store i32 %5, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %6 = load i32, i32* @turn, align 4
  store i32 %6, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %7

7:                                                ; preds = %15, %1
  %8 = load i32, i32* %3, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %13

10:                                               ; preds = %7
  %11 = load i32, i32* %4, align 4
  %12 = icmp eq i32 %11, 1
  br label %13

13:                                               ; preds = %10, %7
  %14 = phi i1 [ false, %7 ], [ %12, %10 ]
  br i1 %14, label %15, label %18

15:                                               ; preds = %13
  call void @__VERIFIER_atomic_begin()
  %16 = load i32, i32* @flag2, align 4
  store i32 %16, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %17 = load i32, i32* @turn, align 4
  store i32 %17, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %7

18:                                               ; preds = %13
  store i32 0, i32* @x, align 4
  %19 = load i32, i32* @x, align 4
  %20 = icmp sle i32 %19, 0
  br i1 %20, label %23, label %21

21:                                               ; preds = %18
  br label %22

22:                                               ; preds = %21
  call void @reach_error()
  br label %23

23:                                               ; preds = %22, %18
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
  %4 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @__VERIFIER_atomic_begin()
  store i32 1, i32* @flag2, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  store i32 0, i32* @turn, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %5 = load i32, i32* @flag1, align 4
  store i32 %5, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %6 = load i32, i32* @turn, align 4
  store i32 %6, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %7

7:                                                ; preds = %15, %1
  %8 = load i32, i32* %3, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %13

10:                                               ; preds = %7
  %11 = load i32, i32* %4, align 4
  %12 = icmp eq i32 %11, 0
  br label %13

13:                                               ; preds = %10, %7
  %14 = phi i1 [ false, %7 ], [ %12, %10 ]
  br i1 %14, label %15, label %18

15:                                               ; preds = %13
  call void @__VERIFIER_atomic_begin()
  %16 = load i32, i32* @flag1, align 4
  store i32 %16, i32* %3, align 4
  call void @__VERIFIER_atomic_end()
  call void @__VERIFIER_atomic_begin()
  %17 = load i32, i32* @turn, align 4
  store i32 %17, i32* %4, align 4
  call void @__VERIFIER_atomic_end()
  br label %7

18:                                               ; preds = %13
  store i32 1, i32* @x, align 4
  %19 = load i32, i32* @x, align 4
  %20 = icmp sge i32 %19, 1
  br i1 %20, label %23, label %21

21:                                               ; preds = %18
  br label %22

22:                                               ; preds = %21
  call void @reach_error()
  br label %23

23:                                               ; preds = %22, %18
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
