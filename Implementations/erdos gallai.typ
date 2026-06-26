```cpp
// DSU by size
struct DSU {
  int n;
  vector<int> p, s; // parent, sizes

  DSU(int n) : n(n) {
    p.resize(n);
    iota(p.begin(), p.end(), 0);
    s.resize(n, 1);
  }

  int rep(int i) {
    return i == p[i] ? i : p[i] = rep(p[i]);
  }

  bool same(int i, int j) {
    return rep(i) == rep(j);
  }

  void unite(int i, int j) {
    if (!same(i, j)) {
      i = rep(i);
      j = rep(j);

      if (s[i] < s[j]) {
        swap(i, j);
      }

      p[j] = i;
      s[i] += s[j];
    }
  }
};
```