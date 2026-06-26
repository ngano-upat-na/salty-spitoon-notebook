```cpp
// given n, is n prime?
u64 bpow(u64 a, u64 b, u64 mod) {
  u64 ans = 1;
  a %= mod;
  while (b) {
    if (b & 1) {
      ans = (u128)ans * a % mod;
    }
    a = (u128)a * a % mod;
    b >>= 1;
  }
  return ans;
}

bool check_composite(u64 n, u64 a, u64 d, int s) {
  u64 x = bpow(a, d, n);
  if (x == 1 || x == n-1) {
    return false;
  }
  for (int r=1; r<s; r++) {
    x = (u128)x * x % n;
    if (x == n-1) {
      return false;
    }
  }
  return true;
}

bool MillerRabin(u64 n) { // deterministic
  if (n < 2) {
    return false;
  }
  int r = 0;
  u64 d = n - 1;
  while ((d & 1) == 0) {
    d >>= 1;
    r++;
  }

  for (int a : {2, 325, 9375, 28178, 450775, 9780504, 1795265022}) {
    if (n == a) {
      return true;
    }
    if (check_composite(n, a, d, r)) {
      return false;
    }
  }
  return true;
}
```