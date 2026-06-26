```cpp
// given strings s, t find t.count(s) in O(|s|+|t|)
vector<int> rabin_karp(string const& s, string const& t) { // pattern, string
  const ll p = 31; 
  const ll m = 998244353; // warning: could give WA
  int S = s.size(), T = t.size();
 
  vector<ll> p_pow(max(S, T)); 
  p_pow[0] = 1; 
  for (int i = 1; i < (int)p_pow.size(); i++) {
    p_pow[i] = (p_pow[i-1] * p) % m;
  }
 
  vector<ll> h(T + 1, 0); 
  for (int i = 0; i < T; i++) {
    h[i+1] = (h[i] + (t[i] - 'a' + 1) * p_pow[i]) % m; 
  }
  ll h_s = 0; 
  for (int i = 0; i < S; i++) {
      h_s = (h_s + (s[i] - 'a' + 1) * p_pow[i]) % m; 
  }
 
  vector<int> ans;
  for (int i = 0; i + S - 1 < T; i++) {
    ll cur_h = (h[i+S] + m - h[i]) % m;
    ll ch = h_s * p_pow[i] % m;
    if (cur_h == ch) {
      ans.pb(i);
    }
  }
  return ans;
}

```