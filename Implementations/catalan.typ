Given a (nonnegative) integer $n$,
#set align(center)
#table(
  columns: 4,
  [*Operation / Syntax*],  [*Use*], 
  [*Operation / Syntax*],  [*Use*], 
  [`n | (1 << x)`], [sets $x$-th bit in $n$],
  [`n | (n + 1)`], [sets the last cleared bit],
  [`n ^ (1 << x)`], [flips $x$-th bit in $n$],
  [`n & ~(1 << x)`], [clears $x$-th bit in $n$],
  [`n & (n - 1)`], [clears right-most bit],
  [`n & (n + 1)`], [clears all trailing bits],
  [`(n >> x) & 1`], [check if $x$-th bit is set],
  [`n & ((1 << k) - 1) == 0`], [check if $2^k$ divides $n$],
  [`n && !(n & (n - 1))`], [check if $n$ is a power of $2$],
  [`n & -n`], [extracts the last set bit],
  [`__builtin_clz(n)`], [extracts the power of the lowest set bit],
  [`__builtin_popcount(n)`], [returns number of bits (ones) of $n$],
  [`__builtin_parity(n)`], [checks if $n$ is odd],
  [`__builtin_ctz(n)`], [counts the leading zeros of $n$]
)
#set align(left)
