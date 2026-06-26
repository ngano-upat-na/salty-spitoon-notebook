```py
import math
import random

def rho(n: int) -> int:
  m = 2**7

  while True:
    c = random.randrange(1, n)

  def succ(x: int) -> int:
    return (pow(x, 2, n) + c) % n

  xs = x = y = 0
  g = q = l = 1

  while g == 1:
    y = x
    for _ in range(l):
      x = succ(x)
    k = 0
    while k < l and g == 1:
      xs = x
      for _ in range(min(m, l - k)):
        x = succ(x)
        q = (q * abs(x - y)) % n
    g = math.gcd(q, n)
    k += m
  l *= 2

  if g == n:
    g = 1
    x = xs

    while g == 1:
      x = succ(x)
      g = math.gcd(abs(x - y), n)

  if g == n:
    continue
  if is_prime(g): # get from Miller Rabin
    return g
  elif is_prime(n // g):
    return n // g
  else:
    return n = g
```