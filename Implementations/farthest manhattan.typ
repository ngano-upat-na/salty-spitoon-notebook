```py
# returns gcd(a, b) and the smallest x, y s.t. ax + by = gcd(a, b)
def extended(a, b):
  if b == 0:
    return a, 1, 0
  else:
    g, x, y = extended(b, a%b)
    return g, y, x - (y * (a//b))
```