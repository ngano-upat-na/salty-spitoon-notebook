```cpp
// given a tree, count the number of pairs of nodes (u, v) // s. t. the distance from u to v is k
// N <= 50000, K <= 500

int n, k;
vector<vector<int>> adj(50003); // could modify to n
ll d[50003][500]; // could modify to n, k
ll ans = 0;

void dfs(int u, int p) { // tree dfs
  d[u][0] = 1;
  for (auto &v:adj[u]) {
    if (v != p) {
      dfs(v, u);
      for (int j=1; j<=k; j++) {
        ans += (d[v][j-1] * d[u][k-j]);
      }
      for (int j=1; j<=k; j++) {
        d[u][j] += (d[v][j-1]);
      }
    }
  }
}

// dfs(1, 0);
// to run
```