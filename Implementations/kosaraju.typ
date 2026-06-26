```py
def kmp(pattern, text):
  m, n = len(pattern), len(text)
  S = pattern + '$' + text # dummy si $
  pf = [-1] * (m + n + 1)

  for i in range(1, len(S)):
    k = pf[i - 1]
    while k >= 0 and S[i] != S[k]:
      # assert S[:k] == S[:i][i - k:]
      k = pf[k]
    pf[i] = k + 1
  return pf
```