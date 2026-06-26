```cpp
char a[MAXN][MAXN];
bool vis[MAXN][MAXN];
int r, c;

void bfs(int i, int j) {
    if ((i < 0 || i >= r || j < 0 || j >= c) || vis[i][j]) return;
    vis[i][j] = true;
    vi dx = {0, 0, 1, -1}, dy = {1, -1, 0, 0};
    for (int k=0; k<4; k++) {
        bfs(i + dx[k], j + dy[k]);
    }
}
```