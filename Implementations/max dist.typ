```cpp
struct Mat {  // assumes square matrices only
  vector<vector<ll>> a;
  Mat() {}
  Mat(const vector<vector<ll>>& _a): a(_a) {}  // assumes all coeffs have been reduced mod P

  static Mat ident(int n) {
    vector<vector<ll>> a(n, vector<ll>(n));
    for (int i = 0; i < n; i++) a[i][i] = 1;
    return {a};
  }

  Mat operator*(const Mat& o) const {
    int n = a.size();
    vector<vector<ll>> c(n, vector<ll>(n));
    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        for (int j = 0; j < n; j++) {
          (c[i][j] += a[i][k] * o.a[k][j]) %= P;
        }
      }
    }
    return {c};
  }

  Mat square() const { return *this * *this; }

  Mat to(ll e) const {
    assert(e >= 0);
    if (e == 0) return ident(a.size());
    if (e == 1) return *this;  // microoptimization
    if (e & 1) return *this * to(e - 1);
    return to(e >> 1).square();
  }
};
```