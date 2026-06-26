```cpp
vector<char> vis;
 
void dfs(int v, vector<vector<int>> const &adj, vector<int> &output) {
  vis[v] = '1';
  for (auto &u:adj[v]) {
    if (vis[u]=='0') {
      dfs(u, adj, output);
    }
  }
  output.pb(v);
}
 
void SCC(vector<vector<int>> const &adj, vector<vector<int>> &ccs, vector<vector<int>> adj_cond) {
  int n = adj.size();
  ccs.clear(); adj_cond.clear();
 
  // dfs1
  vector<int> order;
  vis.assign(n,'0');
  for (int i = 0; i < n; i++) {
    if (vis[i]=='0') {
      dfs(i, adj, order);
    }
  }
  vector<vector<int>> adj_rev(n);
  for (int v=0; v<n; v++) {
    for (auto &u:adj[v]) {
      adj_rev[u].pb(v);
    }
  }
 
  // dfs2
  vis.assign(n,'0');
  reverse(order.begin(),order.end());
  vector<int> roots(n,0);
  for (auto &v:order) {
    if (vis[v]=='0') {
      vector<int> cc;
      dfs(v, adj_rev, cc);
      ccs.pb(cc);
      int root = *min_element(cc.begin(),cc.end());
      for (auto &u:cc) {
        roots[u] = root;
      }
    }
  }
 
  // condensation graph
  adj_cond.assign(n, {});
  for (int v=0; v<n; v++) {
    for (auto &u:adj[v]) {
      if (roots[v] != roots[u]) {
        adj_cond[roots[v]].pb(roots[u]);
      }
    }
  }
}
```