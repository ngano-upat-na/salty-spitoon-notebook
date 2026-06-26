```py
# integral of f(x)dx from a to b
def simpsons(a, b, *args): 
  N = 100000
  h = (b - a) / N
  ans = f(a,*args) + f(b,*args) # f is some function
  for i in range(1,N):
      x = a + h * i
      if i % 2 == 1:
          ans += (f(x,*args) * 4)
      else:
          s += (f(x,*args) * 2)
  ans *= (h/3)
  return ans
```