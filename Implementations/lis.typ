```py
# find smallest soln to ax + by = c
def diophantine(a, b, c):
  g, x, y = extended(a, b)
  if c % g == 0:
    k = c // g
    return x * k, y * k
  else:
    return None, None
```