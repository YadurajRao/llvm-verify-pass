; ModuleID = 'gcd-2.c'
source_filename = "gcd-2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"gcd-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@a = common dso_local global i32 0, align 4
@b = common dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @assume_abort_if_not(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void @abort() #6
  unreachable

6:                                                ; preds = %1
  ret void
}

; Function Attrs: noreturn
declare dso_local void @abort() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_assert(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  br label %6

6:                                                ; preds = %5
  call void @reach_error()
  call void @abort() #6
  unreachable

7:                                                ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_dec_a() #0 {
  %1 = load i32, i32* @a, align 4
  %2 = load i32, i32* @b, align 4
  %3 = icmp ugt i32 %1, %2
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i32, i32* @a, align 4
  %6 = load i32, i32* @b, align 4
  %7 = sub i32 %5, %6
  store i32 %7, i32* @a, align 4
  br label %8

8:                                                ; preds = %4, %0
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__VERIFIER_atomic_dec_b() #0 {
  %1 = load i32, i32* @b, align 4
  %2 = load i32, i32* @a, align 4
  %3 = icmp ugt i32 %1, %2
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i32, i32* @b, align 4
  %6 = load i32, i32* @a, align 4
  %7 = sub i32 %5, %6
  store i32 %7, i32* @b, align 4
  br label %8

8:                                                ; preds = %4, %0
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @dec_a(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  br label %4

4:                                                ; preds = %8, %1
  %5 = load i32, i32* @a, align 4
  %6 = load i32, i32* @b, align 4
  %7 = icmp ne i32 %5, %6
  br i1 %7, label %8, label %9

8:                                                ; preds = %4
  call void @__VERIFIER_atomic_dec_a()
  br label %4

9:                                                ; preds = %4
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @dec_b(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  br label %4

4:                                                ; preds = %8, %1
  %5 = load i32, i32* @a, align 4
  %6 = load i32, i32* @b, align 4
  %7 = icmp ne i32 %5, %6
  br i1 %7, label %8, label %9

8:                                                ; preds = %4
  call void @__VERIFIER_atomic_dec_b()
  br label %4

9:                                                ; preds = %4
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @start(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %7 = load i32, i32* %3, align 4
  store i32 %7, i32* @a, align 4
  %8 = load i32, i32* %4, align 4
  store i32 %8, i32* @b, align 4
  %9 = call i32 @pthread_create(i64* %5, %union.pthread_attr_t* null, i8* (i8*)* @dec_a, i8* null) #7
  %10 = call i32 @pthread_create(i64* %6, %union.pthread_attr_t* null, i8* (i8*)* @dec_b, i8* null) #7
  %11 = load i64, i64* %5, align 8
  %12 = call i32 @pthread_join(i64 %11, i8** null)
  %13 = load i64, i64* %6, align 8
  %14 = call i32 @pthread_join(i64 %13, i8** null)
  %15 = load i32, i32* @a, align 4
  ret i32 %15
}

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

declare dso_local i32 @pthread_join(i64, i8**) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @check_gcd(i32 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = call i32 (...) @__VERIFIER_nondet_uint()
  store i32 %8, i32* %7, align 4
  %9 = load i32, i32* %7, align 4
  %10 = icmp ugt i32 %9, 1
  %11 = zext i1 %10 to i32
  call void @assume_abort_if_not(i32 %11)
  %12 = load i32, i32* %4, align 4
  %13 = load i32, i32* %7, align 4
  %14 = urem i32 %12, %13
  %15 = icmp eq i32 %14, 0
  %16 = zext i1 %15 to i32
  call void @assume_abort_if_not(i32 %16)
  %17 = load i32, i32* %5, align 4
  %18 = load i32, i32* %7, align 4
  %19 = urem i32 %17, %18
  %20 = icmp eq i32 %19, 0
  %21 = zext i1 %20 to i32
  call void @assume_abort_if_not(i32 %21)
  %22 = load i32, i32* %4, align 4
  %23 = load i32, i32* %6, align 4
  %24 = urem i32 %22, %23
  %25 = icmp eq i32 %24, 0
  %26 = zext i1 %25 to i32
  call void @__VERIFIER_assert(i32 %26)
  %27 = load i32, i32* %5, align 4
  %28 = load i32, i32* %6, align 4
  %29 = urem i32 %27, %28
  %30 = icmp eq i32 %29, 0
  %31 = zext i1 %30 to i32
  call void @__VERIFIER_assert(i32 %31)
  %32 = load i32, i32* %6, align 4
  %33 = load i32, i32* %7, align 4
  %34 = icmp uge i32 %32, %33
  %35 = zext i1 %34 to i32
  call void @__VERIFIER_assert(i32 %35)
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_uint(...) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = call i32 (...) @__VERIFIER_nondet_uint()
  store i32 %4, i32* %2, align 4
  %5 = call i32 (...) @__VERIFIER_nondet_uint()
  store i32 %5, i32* %3, align 4
  %6 = load i32, i32* %2, align 4
  %7 = icmp ugt i32 %6, 0
  %8 = zext i1 %7 to i32
  call void @assume_abort_if_not(i32 %8)
  %9 = load i32, i32* %3, align 4
  %10 = icmp ugt i32 %9, 0
  %11 = zext i1 %10 to i32
  call void @assume_abort_if_not(i32 %11)
  %12 = load i32, i32* %2, align 4
  %13 = load i32, i32* %3, align 4
  %14 = load i32, i32* %2, align 4
  %15 = load i32, i32* %3, align 4
  %16 = call i32 @start(i32 %14, i32 %15)
  call void @check_gcd(i32 %12, i32 %13, i32 %16)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { noreturn }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}
