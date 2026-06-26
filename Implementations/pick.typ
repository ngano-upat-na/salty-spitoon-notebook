```cpp
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace __gnu_pbds;
using ordered_set = tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update>;

/* test
ordered_set s;
for INSERTION: s.insert(5); s.insert(67);
for INDEXING: *s.find_by_order(1);
for LEQ (<=): s.order_of_key(60);
*/
```