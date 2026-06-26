```cpp
// given L, R (large), find all primes in [L, R] provided R - L + 1 <= 10**7
vector<char> segemented_sieve(long long L, long long R) {
  vector<char> is_prime(R - L + 1, '1');
  ll lim = sqrt(R);
  for (ll i = 2; i <= lim; i++) {
    for (ll j = max(i * i, (L + i - 1) / i * i); j <= R; j += i) {
      is_prime[j - L] = '0';
    }
  }
  if (L == 1) {
    is_prime[0] = '0';
  }
  return is_prime;
}
```
