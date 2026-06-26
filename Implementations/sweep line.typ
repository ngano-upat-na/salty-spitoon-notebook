```cpp
// string thing? not sure what this does, somewhat with strings could do something with this.
tcT > struct RMQ { // floor(log_2(x))
  int level(int x) {
    return 31 - __builtin_clz(x);
  }

  V<T> v;
  V<vi> jmp;

  int cmb(int a, int b) {
    return v[a] == v[b] ? min(a, b) : (v[a] < v[b] ? a : b);
  }

  void init(const V<T> &_v) {
    v = _v;
    jmp = {vi(sz(v))};
    iota(all(jmp[0]), 0);
    for (int j = 1; 1 << j <= sz(v); ++j) {
      jmp.pb(vi(sz(v) - (1 << j) + 1));
      F0R(i, sz(jmp[j]))
        jmp[j][i] =
          cmb(jmp[j - 1][i], jmp[j - 1][i + (1 << (j - 1))]);
    }
  }

  int index(int l, int r) {
    assert(l <= r);
    int d = level(r - l + 1);
    return cmb(jmp[d][l], jmp[d][r - (1 << d) + 1]);
  }

  T query(int l, int r) {
    return v[index(l, r)];
  }
};

struct SuffixArray {
  str S;
  int N;
  vi sa, isa, lcp;

  void init(str _S) {
    N = sz(S = _S) + 1;
    genSa();
    genLcp();
  }

  void genSa() { // sa has size sz(S)+1, starts with sz(S)
    sa = isa = vi(N);
    sa[0] = N - 1;
    iota(1 + all(sa), 0);
    sort(1 + all(sa), [&](int a, int b) {
      return S[a] < S[b];
    });
    FOR(i, 1, N) {
      int a = sa[i - 1], b = sa[i];
      isa[b] = i > 1 && S[a] == S[b] ? isa[a] : i;
    }
    for (int len = 1; len < N; len *= 2) { // currently sorted
      // by first len chars
      vi s(sa), is(isa), pos(N);
      iota(all(pos), 0);
      each(t, s) {
        int T = t - len;
        if (T >= 0)
          sa[pos[isa[T]]++] = T;
      }
      FOR(i, 1, N) {
        int a = sa[i - 1],
            b = sa[i]; /// verify that nothing goes out of bounds
        isa[b] =
          is[a] == is[b] && is[a + len] == is[b + len]
            ? isa[a]
            : i;
      }
    }
  }

  void genLcp() { // Kasai's Algo
    lcp = vi(N - 1);
    int h = 0;
    F0R(b, N - 1) {
      int a = sa[isa[b] - 1];
      while (a + h < sz(S) && S[a + h] == S[b + h])
        ++h;
      lcp[isa[b] - 1] = h;
      if (h)
        h--;
    }
    R.init(lcp); /// if we cut off first chars of two strings
                 /// with lcp h then remaining portions still have lcp h-1
  }

  RMQ<int> R;

  int getLCP(int a, int b) { // lcp of suffixes starting at a,b
    if (a == b)
      return sz(S) - a;
    int l = isa[a], r = isa[b];
    if (l > r)
      swap(l, r);
    return R.query(l, r - 1);
  }
};
```