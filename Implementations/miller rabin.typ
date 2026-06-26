```cpp
struct Edge {
  int i, j;
  ll cap;
  ll flow = 0;
  Edge *rev = nullptr;

  Edge(int i, int j, ll cap): i(i), j(j), cap(cap) {}

  ll res() const { return cap - flow; }

  void add_flow(ll fl) {
    flow += fl;
    rev->flow -= fl;
  }
};

struct FlowNetwork {
  int n, s, t;
  vector<vector<Edge*>> adj;
  vector<int> vis;
  vector<Edge*> par;
  vector<ll> aug;
  int time = 0;
  ll finf = 11;

  FlowNetwork(int n, int s, int t): n(n), s(s), t(t), adj(n), vis(n), par(n), aug(n) {
    assert(0 <= s and s < n);
    assert(0 <= t and t < n);
    assert(s != t);
  }

  void add_edge(int i, int j, ll c) {
    assert(0 <= i and i < n);
    assert(0 <= j and j < n);
    assert(c >= 0);
    if (c == 0) return;
    finf = max(finf, c + 11);
    Edge *ij = new Edge(i, j, c);
    Edge *ji = new Edge(j, i, 0);
    ij->rev = ji;
    ji->rev = ij;
    adj[i].push_back(ij);
    adj[j].push_back(ji);
  }

  tuple<ll,vector<Edge*>> augment() {  // BFS dapat
    vis[s] = ++time; // advance time
    aug[s] = finf;

    auto reconstruct_path = [&]() {
      vector<Edge*> path;
      for (int curr = t; curr != s;) {
        path.push_back(par[curr]);
        curr = par[curr]->i;
      }
      return path;  // reverse if you want
    };

    vector<int> que = {s};
    for (int f = 0; f < que.size(); f++) {
      int i = que[f], j;
      for (auto edge : adj[i]) {
        if (ll r = edge->res(); r > 0 and vis[j = edge->j] != time) {
          vis[j] = time;
          par[j] = edge;
          aug[j] = min(aug[i], r);
          if (j == t) return {aug[j], reconstruct_path()};
          que.push_back(j);
        }
      }
    }
    return {0, {}};
  }


  ll max_flow() {
    ll total = 0;
    while (true) {
      auto [c, path] = augment();
      if (c == 0) break;
      assert(c > 0);
      total += c;
      for (auto edge : path) edge->add_flow(c);
    }

    return total;
  }
};
```