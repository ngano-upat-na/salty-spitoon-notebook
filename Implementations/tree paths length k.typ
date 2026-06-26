```cpp
unsigned seed = chrono::system_clock::now().time_since_epoch().count();
mt19937 rnd(seed);

ll randint(ll a, ll b) {
  return uniform_int_distribution<ll>(a, b)(rnd);
}
ll randrange(ll a, ll b) {
  return randint(a, b - 1);
}

constexpr ll VINF = 1LL << 60;
constexpr int PINF = 1 << 30;

int randprio() {
  return randrange(0, 1 << 30);
}

// this is a "segment tree on a treap"
// leaves have priority -infinity
struct Node {
  int prio;
  int sz;
  ll mx = -VINF;
  bool rev = false;
  Node *l = nullptr, *r = nullptr;
  Node(int sz, ll mx, ll prio): sz(sz), mx(mx), prio(prio) {}

  static int size(Node *x) { return x == nullptr ? 0 : x->sz; }
  static ll  max_(Node *x) { return x == nullptr ? -VINF : x->mx; }

  static Node *leaf(ll v) { return new Node(1, v, -PINF); }

  Node *join() {
    assert(not rev);
    sz = size(l) + size(r);
    mx = max(max_(l), max_(r));
    return this;
  }

  static void visit(Node *x) {
    if (x != nullptr) {
      if (x->rev) {
        if (x->l != nullptr) x->l->rev ^= true;
        if (x->r != nullptr) x->r->rev ^= true;
        swap(x->l, x->r);
        x->rev = false;
      }
    }
  }

  static tuple<Node*,Node*> split(Node *x, int i) {
    visit(x);
    if (size(x) <= i) return {x, nullptr};
    if (i <= 0) return {nullptr, x};

    assert(0 < i and i < size(x));
    int lsz = size(x->l);
    if (i <= lsz) {
      Node *l;
      tie(l, x->l) = split(x->l, i);
      return {l, x->join()};
    } 
    else {
      Node *r;
      tie(x->r, r) = split(x->r, i - lsz);
      return {x->join(), r};
    }
  }

  static Node *merge(Node *l, Node *r) {
    if (l == nullptr) return r;
    if (r == nullptr) return l;
    if (l->prio > r->prio) {
      visit(l);
      l->r = merge(l->r, r);
      return l->join();
    } 
    else {
      visit(r);
      r->l = merge(l, r->l);
      return r->join();
    }
  }

  static Node *prefix_rev(Node *x, int i) {
    auto [l, r] = split(x, i);
    if (l != nullptr) {
      l->rev ^= true;
      visit(l);
    }
    return merge(l, r);
  }

  static Node *insert(Node *x, int i, ll v) {  // i in [0, n)
    Node *m = leaf(v);
    if (x == nullptr) return m;
    auto [l, r] = split(x, i);
    x = new Node(0, -VINF, randprio());
    (i == 0 ? x->l : x->r) = m;
    x->join();
    return merge(merge(l, x), r);
  }

  static ll range_max(Node *x, int i, int j) {  // [i, j)
    visit(x);
    if (i <= 0 and size(x) <= j) return max_(x);
    if (j <= 0 or size(x) <= i) return -VINF;
    int lsz = size(x->l);
    return max(range_max(x->l, i, j), range_max(x->r, i - lsz, j - lsz));
  }
};


struct ReversibleSeq {
  Node *root = nullptr;
  ReversibleSeq() {}
  void insert(int i, ll v) {  // i in [0, n)
    root = Node::insert(root, i, v);
  }
  ll max(int i, int j) {  // [i, j)
    return Node::range_max(root, i, j);
  }
  void rev(int i) {  // [0, i)
    root = Node::prefix_rev(root, i);
  }
};

// very slow! only for debugging
void check_treap_invariants(Node *x) {
  if (x == nullptr) return;

  assert(Node::size(x) >= 1);

  assert((x->l == nullptr) == (x->r == nullptr)); // "segment tree on a treap" must be a perfect tree

  if (x->l != nullptr) { 
    assert(x->prio > -PINF);

    // heap property on priorities
    assert(x->prio >= x->l->prio);
    assert(x->prio >= x->r->prio);
        
    assert(Node::size(x) == Node::size(x->l) + Node::size(x->r));
    assert(Node::max_(x) == max(Node::max_(x->l), Node::max_(x->r)));
  } 
  else {
    assert(x->prio == -PINF);
    assert(Node::size(x) == 1);
  }

  check_treap_invariants(x->l);
  check_treap_invariants(x->r);
}

void check_invariants(ReversibleSeq& s) {
  check_treap_invariants(s.root);
}
```