```cpp
// given n points, find maximum distance between two points

const double EPS = 1e-9;

struct Point {
  double x, y;
  Point(double x = 0, double y = 0) : x(x), y(y) {}
};

// calculate the squared distance between two points
double dist(Point p, Point q) {
  return (p.x - q.x) * (p.x - q.x) +
         (p.y - q.y) * (p.y - q.y);
}

// calculate the absolute area of a triangle
double absArea(Point p, Point q, Point r) {
  return abs(
    (p.x * q.y + q.x * r.y + r.x * p.y) -
    (p.y * q.x + q.y * r.x + r.y * p.x)
  );
}

// A function to calculate the convex hull of a set of points
vector<Point> convexHull(vector<Point>& points) {
  int n = points.size();

  // Sort the points by x-coordinate (in case of a tie, by y-coordinate)
  sort(points.begin(), points.end(), [](Point a, Point b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
  });

  // Create an empty vector to store the points on the convex hull
  vector<Point> hull;

  // Add points to the convex hull one by one
  for (int i = 0; i < n; i++) {
    // Check if the last two points and the new point make a left turn
    while (hull.size() >= 2 &&
           absArea(hull[hull.size() - 2],
                   hull.back(),
                   points[i]) <= EPS) {
      // If not, remove the last point from the convex hull
      hull.pop_back();
    }

    // Add the new point to the convex hull
    hull.push_back(points[i]);
  }

  // Repeat the same process for the lower part of the convex hull
  for (int i = n - 2, t = hull.size() + 1; i >= 0; i--) {
    while (hull.size() >= t &&
           absArea(hull[hull.size() - 2],
                   hull.back(),
                   points[i]) <= EPS) {
      hull.pop_back();
    }
    hull.push_back(points[i]);
  }

  // Return the convex hull
  return hull;
}

// A function to calculate the width of the smallest bounding rectangle
double rotatingCaliper(vector<Point>& points) {
  // Calculate the convex hull of the set
  vector<Point> hull = convexHull(points);
  int n = hull.size();

  // If the convex hull has only one point, the width is 0
  if (n == 1) return 0;

  // If the convex hull has two points, the width
  // is the distance between the two points
  if (n == 2) return sqrt(dist(hull[0], hull[1]));

  int k = 1;
  while (absArea(hull[n - 1], hull[0], hull[(k + 1) % n]) >
         absArea(hull[n - 1], hull[0], hull[k])) {
    k++;
  }

  double res = 0;

  for (int i = 0, j = k; i <= k; i++) {
    while (absArea(hull[i], hull[(i + 1) % n],
                   hull[(j + 1) % n]) >
           absArea(hull[i], hull[(i + 1) % n],
                   hull[j])) {
      res = max(res, sqrt(dist(hull[i], hull[(j + 1) % n])));
      j = (j + 1) % n;
    }
    res = max(res, sqrt(dist(hull[i], hull[j])));
  }

  return res; // ans
}
```