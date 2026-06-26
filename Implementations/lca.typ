```cpp
// Given a graph, return its MST
// DSU by rank
vector<int> parent;
vector<int> rnk;
void make_set(int &v) {
  parent[v] = v;
  rnk[v] = 0;
}
int find_set(int &v) {
  if (v == parent[v]) {
    return v;
  }
  return parent[v] = find_set(parent[v]);
}
void unite(int &a, int &b) {
  a = find_set(a);
  b = find_set(b);
  if (a != b) {
    if (rnk[a] < rnk[b]) {
      swap(a, b);
    }
    parent[b] = a;
    if (rnk[a] == rnk[b]) {
      rnk[a]++;
    }
  }
}

struct Edge {
  int u, v;
  ll weight;
  bool operator<(Edge const& other) {
    return weight < other.weight;
  }
};
vector<Edge> Kruskal(int n, vector<Edge> edges) {
  parent.resize(n);
  rnk.resize(n);
  vector<Edge> result;
  for (int i = 0; i < n; i++) {
    make_set(i);
  }
  sort(edges.begin(), edges.end());
  for (Edge e : edges) {
    if (find_set(e.u) != find_set(e.v)) {
      //cost += e.weight;
      result.push_back(e);
      unite(e.u, e.v);
    }
  }
  return result; // can return smth that is not a tree!
}

```