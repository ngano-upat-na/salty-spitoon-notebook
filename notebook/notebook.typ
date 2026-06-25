//#import "presets.typ": *
//#import "physics.typ": *
#import "@preview/diverential:0.2.0": *
#set page(paper:"a4", margin:0.4in, )
#set text(font:"Cantarell")
#set par(justify: true)
#let muc = $" ["mu"C]"$

/*
TODO:
- primitive root mod p
- lehman O(n^1/3) factorization
- some standard results about Ordinary GF, Exponential GF and Dirichlet GF
  - exponential formula
    - connection with Dirichlet convolution, and Mobius inversion
- Fenwick tree
*/

#set page(
  columns: 3,
  header: context {
    [
      #v(0.5cm)
      #set text(8pt)
      *Salty Spitoon - University of the Philippines Diliman*
      #h(1fr)
      #counter(page).get().first()
      #line(length:100%)

    ]
  },
  margin: 5.5em,
  paper: "a4",
  flipped: true,
)
#set text(size: 6pt)
#show heading: set block(above: 0.75em, below: 0.75em)

#[
  //#v(0.3cm)
  #set align(center)

  #set text(13pt)
  *Salty Spitoon Team Reference Notebook*
  #set text(10pt)
  
  *University of the Philippines Diliman*
]
#[
  #set text(9pt)
  #set quote(block: true)
  #quote(
    attribution: [Lucas],
    "可能なことをやってみる！"
  )
]
#[
  #set text(9pt)
  #set quote(block: true)
  #quote(
    attribution: [Alvann],
    "There is light at the end of the tunnel, but it is moving at speed c.",
  )
]
#[
  #set text(9pt)
  #set quote(block: true)
  #quote(
    attribution: [Paolo],
    "Думаю, это хорошее место, чтобы начать.",
  )
]

#set text(9pt)
#set align(center)
```
author: Salty Spitoon
Notes to selves (IN EXACT ORDER):
  - always pass by reference
  - is this brute force?
  - is this binary search?
  - is this (insert some algorithm or just dp)
```
#set align(left)
#set text(8.3pt)

#outline()
#v(0.3cm)



#set align(left)

== *0* Template
#include "Implementations/template.typ"



== *1* Math // section
=== _Segmented Sieve_
#include "Implementations/segmented sieve.typ"
=== _Miller Rabin Test_
#include "Implementations/miller rabin.typ"
=== _Pollard Rho_
#include "Implementations/pollard rho.typ"
=== _Extended Euclidean_
#include "Implementations/extended euclidean.typ"
=== _Linear Diophantine Equations_
#include "Implementations/linear diophantine.typ"
=== _Modular Inverse_
#include "Implementations/modular inverse.typ"
=== _Simpson's Rule_
#include "Implementations/simpsons.typ"
=== _FFT in $FF_p$_
#include "Implementations/fft in F_p.typ"
=== _FFT in $CC$_
#include "Implementations/fft in C.typ"
=== _Matrix Exponentiation_
#include "Implementations/mat expo.typ"
=== _Determinant of Matrix_
#include "Implementations/determinant.typ"
=== _Gauss-Jordan_
#include "Implementations/gauss jordan.typ"
=== _Rank of a Matrix_
#include "Implementations/rank.typ"

== *2* Data Structures // section
=== _Disjoint Sets Union_
#include "Implementations/dsu.typ" 
=== _Segment Tree (Lazy)_
#include "Implementations/segtree.typ"
=== _Ordered Set_
#include "Implementations/ordered set.typ"
=== _Treaps_
#include "Implementations/treap.typ"
=== _AVL Tree_
#include "Implementations/AVL tree.typ"

== *3* Graphs // section
/*=== _Grid Traversal_
#include "Implementations/bfs grid.typ"*/
=== _Dijkstra's Shortest Path_
#include "Implementations/dijkstra.typ"
=== _Kruskal's MST_
#include "Implementations/kruskal's.typ"
=== _Kosaraju SCC_
#include "Implementations/kosaraju.typ"
=== _Max Flow (Edmonds-Karp)_
#include "Implementations/max flow.typ"
=== _2-SAT_
#include "Implementations/two sat.typ"
=== _Centroid Decomposition_
#include "Implementations/centroid decomposition.typ"

== *4* Dynamic Programming // section
=== _Longest Increasing Subsequence_
#include "Implementations/lis.typ"

=== _Tree Paths of Length k_
#include "Implementations/tree paths length k.typ"

=== _Kadane's Algorithm_
#include "Implementations/kadane.typ"

=== _LCA_
#include "Implementations/lca.typ"

=== _D&C DP_
#include "Implementations/dnc dp.typ"

== *5* Geometry // section

=== _Convex Hull_
#include "Implementations/convex hull.typ"
=== _Polygon_
#include "Implementations/polygon.typ"
=== _Maximum Distance_
#include "Implementations/max dist.typ"
=== _Farthest Manhattan Distance_
#include "Implementations/farthest manhattan.typ"
=== _Search for Pair of Intersecting Segments (Sweep Line)_
#include "Implementations/sweep line.typ"

== *6* Strings
=== _Rabin-Karp Pattern Matching_
#include "Implementations/rabin karp.typ"
=== _Suffix Array_
#include "Implementations/suffix array.typ"
=== _KMP_
#include "Implementations/kmp.typ"


== *7* Formulas
=== _Principle of Inclusion-Exclusion_
#include "Implementations/pie.typ"
=== _Catalan Numbers_
#include "Implementations/catalan.typ"
=== _Pick's Theorem_
#include "Implementations/pick.typ"

=== _Erdos-Gallai Theorem_
#include "Implementations/erdos gallai.typ"

=== _Fibonacci Matrix_
#include "Implementations/fibonacci formula.typ"

== *8* Bitwise Operators
#include "Implementations/bitwise.typ"
