```cpp
constexpr ll INF = (1LL << 61) + 111;

struct Node {
  int i, j;
  ll m;
  ll a = 0;
  Node *l, *r;

  Node(const vector<ll>& seq, int i, int j): i(i),j(j){
    if (is_leaf()) {
      m = seq[i];
      l = r = nullptr;
    } 
    else {
      int k = i + j >> 1;
      l = new Node(seq, i, k);
      r = new Node(seq, k, j);
      combine();
    }
  }

  // destructor to avoid memory leaks!
  ~Node() {
    if (l != nullptr) delete l;
    if (r != nullptr) delete r;
  }

  bool is_leaf() {
    return j - i == 1;
  }

  void combine() {
    m = min(l->m, r->m);
  }

  void visit() {
    if (a) {
      m += a;
      if (l != nullptr) {
        l->a += a;
        r->a += a;
      }
      a = 0;
    }
  }

  ll range_min(int I, int J) {
    visit();
    if (I <= i and j <= J) {
      return m;
    } 
    else if (J <= i or j <= I) {
      return INF;
    } 
    else {
      return min(l->range_min(I, J), r->range_min(I, J));
    }
  }

  void range_inc(int I, int J, ll V) {
    if (I <= i and j <= J) {
      a += V;
      visit();
    } 
    else {
      visit();
      if (not (J <= i or j <= I)) {
        l->range_inc(I, J, V);
        r->range_inc(I, J, V);
        combine();
      }
    }
  }
};

struct RangeMin {
  Node root;
  RangeMin(const vector<ll>& seq): root(seq, 0, seq.size()) {}

  ll range_min(int i, int j) {
    return root.range_min(i, j);
  }
  void range_inc(int i, int j, ll v) {
    root.range_inc(i, j, v);
  }
};
```