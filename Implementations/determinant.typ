```cpp
using point = pair<ll, ll>;

// square of distance between two points
ll dist_squared(point p1, point p2) {
  return (p1.first - p2.first) * (p1.first - p2.first) +(p1.second - p2.second) * (p1.second - p2.second);
}

// 0 line, 1 cw, 2 ccw
int direction(point p, point q, point r) {
  ll val = (q.second - p.second) * (r.first - q.first) -(q.first - p.first) * (r.second - q.second);

  if (val > 0)
    return 1;
  else if (val < 0)
    return 2;
  else
    return 0;
}

// iterates ccw, comparator returns true if sorted correctly
point global_p0;
bool convex_hull_comp(point p1, point p2) {
  switch (direction(global_p0, p1, p2)) {
  case 0:
    return (dist_squared(global_p0, p2) >= dist_squared(global_p0, p1));
  case 1:
    return false;
  case 2:
    return true;
  default:
    exit(-1);
  }
}

// put bottom left first
bool bottom_left_comp(point p1, point p2) {
  if (p1.second != p2.second)
    return p1.second < p2.second;
  else
    return p1.first < p2.first;
}

vector<point> convex_hull(vector<point> &points) {
  // find "minimum" point in array
  int n = points.size();
  if (n == 0)
    return vector<point>();
  int p0i = 0;
  for (int i = 1; i < n; i++)
    if (bottom_left_comp(points[i], points[p0i]))
      p0i = i;
  swap(points[p0i], points[0]);

  // store minimum point globally, and sort all points wrt minimum point
  global_p0 = points[0];
  sort(points.begin() + 1, points.end(), convex_hull_comp);

  // remove collinear points from convex hull iteration
  int m = 1;
  for (int i = 1; i < n; i++) {
    while (i < n-1 && direction(global_p0, points[i], points[i+1]) == 0)
      i++;
    points[m] = points[i];
    m++;
  }

  // if p1-p2-p3 is clockwise, then remove p2 (before pushing p3 to ans)
  vector<point> ret;
  for (int i = 0; i < min(m, 3); i++)
    ret.push_back(points[i]);
  for (int i = 3; i < m; i++) {
    while (direction(ret[ret.size() - 2], ret[ret.size() - 1], points[i]) != 2)
      ret.pop_back();
    ret.push_back(points[i]);
  }
  return ret;
}
```