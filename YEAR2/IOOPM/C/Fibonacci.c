int fib(int n) {
  int a = 0;
  int b = 1;
  for (int i=1; i<=n; ++i) {
    int fib_i = a + b;
    a= b;
    b = fib_i;
  }
  return a;
}

