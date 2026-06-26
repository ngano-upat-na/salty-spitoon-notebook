```cpp
constexpr ll P = 998244353;
constexpr int K = 23;
constexpr ll R = 300602147;
constexpr ll POWS[K + 1] = {1, 998244352, 86583718, 509520358, 337190230, 910687289, 288514398, 842144782, 24306784, 159709048, 661253627, 138134861, 714257361, 329633281, 392133877, 45739610, 863021119, 692683514, 238840006, 493217841, 628975233, 966651360, 951679693, 300602147};
ll A[1 << K], B[1 << K], C[1 << K], T[1 << K];

void _fft(int k, ll *a, ll *t) {
  if (k == 0) return;

  int j = 0;
  for (int x : {0, 1}) {
    for (int i = x; i < 1 << k; i += 2) {
      t[j++] = a[i];
    }
  }

  ll *T = t + (1 << k - 1);
  ll *A = a + (1 << k - 1);
  _fft(k - 1, t, a);
  _fft(k - 1, T, a);

  ll w = POWS[k];
  ll pw = 1;
  for (int i = 0; i < 1 << k - 1; i++) {
    a[i] = (t[i] + pw * T[i]) % P;
    A[i] = (t[i] - pw * T[i]) % P;
    pw = pw * w % P;
  }
}
void fft(int k, ll *a) {
  _fft(k, a, T);
}

vector<ll> polymul(const vector<ll>& a, const vector<ll>& b) {
  int n = a.size() + b.size() + 1;
  int k = 0;
  while (1 << k <= n) k++;
  for (int i = 0; i < 1 << k; i++) {
    A[i] = B[i] = C[i] = 0;
  }
  for (int i = 0; i < a.size(); i++) {
    A[i] = a[i];
  }
  for (int i = 0; i < b.size(); i++) {
    B[i] = b[i];
  }

  fft(k, A);
  fft(k, B);

  // // pointwise product to C
  // for (int i = 0; i < 1 << k; i++) {
  //     C[i] = A[i] * B[i] % P;
  // }
  // fft(k, C);
  // reverse(C + 1, C + (1 << k));
  // for (int i = 0; i < 1 << k; i++) {
  //     C[i] = C[i] * (1 - P >> k) % P;
  // }

  // pointwise product to B
  for (int i = 0; i < 1 << k; i++) {
    B[i] = A[i] * B[i] % P;
  }
  fft(k, B);
  for (int i = 0; i < 1 << k; i++) {
    C[i] = B[-i & (1 << k) - 1] * (1 - P >> k) % P;
  }

  vector<ll> c(n);
  for (int i = 0; i < n; i++) {
    c[i] = C[i];
  }
  for (int i = n; i < 1 << k; i++) {
    assert(C[i] == 0);
  }
  while (not c.empty() and c.back() == 0) c.pop_back();

  return c;
}
ll fix(ll v) { // consider negative coeffs
  v = (v % P + P) % P;
  return abs(v - P) < abs(v) ? v - P : v;
}
```