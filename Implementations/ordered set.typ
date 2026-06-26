```py
# given a, solve a' s.t. a*a' mod n = 1
def mod_inv(a, n):
  g, x, y = extended(a, n)
  assert a*x + n*y == 1
  return x
```