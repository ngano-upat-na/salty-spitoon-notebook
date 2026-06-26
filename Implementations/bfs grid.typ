```cpp
template <class K, class V>
struct Node {
  K key;
  V val;
  int h;
  Node<K,V> *l = nullptr, *r = nullptr;

  Node(const K& key, const V& val): key(key), val(val) { join0(); }

  Node<K,V> *join0() {
    h = max(height(l), height(r)) + 1;
    return this;
  }

  static int height(Node<K,V> *x) {
    return x == nullptr ? -1 : x->h;
  }

  Node<K,V> *join() {
    if (height(l) >= height(r) + 2) {
      if (height(l->l) < height(l->r)) l = l->rotate_left();
      return rotate_right();

    }
    if (height(r) >= height(l) + 2) {
      if (height(r->r) < height(r->l)) r = r->rotate_right();
      return rotate_left();
    }
    return join0();
  }

  Node<K,V> *rotate_left() {
    auto a = l, b = this, c = r->l, d = r, e = r->r;
    return join3(join3(a, b, c), d, e);
  }

  Node<K,V> *rotate_right() {
    auto a = l->l, b = l, c = l->r, d = this, e = r;
    return join3(a, b, join3(c, d, e));
  }

  static Node<K,V> *join3(Node<K,V> *l, Node<K,V> *x, Node<K,V> *r) {
    assert(x != nullptr);
    x->l = l;
    x->r = r;
    return x->join0();
  }

  static bool contains(Node<K,V> *x, const K& key) {
    if (x == nullptr) return false;
    if (key == x->key) return true;
    if (key < x->key) return contains(x->l, key);
    assert(key > x->key);
    return contains(x->r, key);
  }

  static V& get(Node<K,V> *x, const K& key) {
    assert(x != nullptr);
    if (key == x->key) return x->val;
    if (key < x->key) return get(x->l, key);
    assert(key > x->key);
    return get(x->r, key);
  }

  static Node<K,V> *set(Node<K,V> *x, const K& key, const V& val) {
    if (x == nullptr) return new Node(key, val);
    if (key == x->key) {
      x->val = val;
      return x;
    }
    if (key < x->key) {
      x->l = set(x->l, key, val);
    } 
    else {
      assert(key > x->key);
      x->r = set(x->r, key, val);
    }
    return x->join();
  }

  static tuple<K,V,Node<K,V>*> del_first(Node<K,V> *x) {
    assert(x != nullptr);
    if (x->l == nullptr) {
      return {x->key, x->val, x->r};
    } 
    else {
      auto [key, val, l] = del_first(x->l);
      x->l = l;
      return {key, val, x->join()};
    }
  }

  static Node<K,V> *del(Node<K,V> *x, const K& key) {
    if (x == nullptr) return nullptr;
    if (key == x->key) {
      if (x->r == nullptr) {
        return x->l;
      } 
      else {
        tie(x->key, x->val, x->r) = del_first(x->r);
        return x->join();
      }
    }
    if (key < x->key) {
      x->l = del(x->l, key);
    } 
    else {
      assert(key > x->key);
      x->r = del(x->r, key);
    }
    return x->join();
  }

  static Node<K,V> *first_after(Node<K,V> *x, const K& key) {
    if (x == nullptr) return nullptr;
    if (key < x->key) {
      auto res = first_after(x->l, key);
      return res == nullptr ? x : res;
    }
    return first_after(x->r, key);
  }
};

template <class K, class V>
struct OrderedDict {
  Node<K,V> *root = nullptr;
  OrderedDict() {}

  bool contains_key(const K& key) const {
    return Node<K,V>::contains(root, key);
  }

  V operator[](const K& key) const {  // assumes key is in the tree
    return Node<K,V>::get(root, key);
  }

  void set(const K& key, const K& val) {
    root = Node<K,V>::set(root, key, val);
  }

  void delete_key(const K& key) {
    root = Node<K,V>::del(root, key);
  }

  K first_after(const K& key) const { // returns key itself if not found
    auto got = Node<K,V>::first_after(root, key);
    return got != nullptr ? got->key : key;
  }
};

// very slow! only for debugging
template <class K, class V>
int ht(Node<K,V> *x) {
  return x == nullptr ? -1 : x->h;
}

template <class K, class V>
void check_avl_invariants(Node<K,V> *x) {
  if (x == nullptr) return;

  assert(ht(x) == max(ht(x->l), ht(x->r)) + 1);
  assert(abs(ht(x->l) - ht(x->r)) <= 1);  // AVL balancing rule
  if (x->l != nullptr) assert(x->l->key < x->key);
  if (x->r != nullptr) assert(x->key < x->r->key);

  check_avl_invariants(x->l);
  check_avl_invariants(x->r);
}

template <class K, class V>
void check_invariants(OrderedDict<K,V>& d) {
  check_avl_invariants(d.root);
}
```