void thr1() {
  int a[5] = {1, 2, 3, 4, 5};
  a[4] = a[0] + a[1];
}