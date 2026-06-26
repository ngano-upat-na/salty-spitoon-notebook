```cpp
struct Polygon {
  int n;
  vector<Point> P;

  Polygon(vector<Point> P, int n) : n(n), P(P) {
  }

  f64 perimeter() {
    f64 result = 0;
    for (int i = 0; i < n; ++i) {
      result += magnitude(P[(i + 1) % n] - P[i]);
    }
    return result;
  }

  f64 area() {
    f64 result = 0;
    for (int i = 0; i < n; ++i) {
      result += P[(i + 1) % n] * P[i];
    }
    return result / 2;
  }

  bool is_convex() {
    bool has_positive = false, has_negative = false;
    for (int i = 0; i < n; ++i) {
      f64 current_orientation =
        orientation(P[i], P[(i + 1) % n], P[(i + 2) % n]);
      has_positive |= current_orientation >= EPS;
      has_negative |= current_orientation <= -EPS;
    }
    return !(has_positive && has_negative);
  }

  bool contains(Point p) {
    int hits = 0;
    for (int i = 0; i < n; ++i) {
      if (on_segment(P[i], P[(i + 1) % n], p)) {
        return false;
      }
      hits += hits_ray(P[i], P[(i + 1) % n], p);
    }
    return hits % 2 == 1 ? true : false;
  }

  bool on_perimeter(Point p) {
    for (int i = 0; i < n; ++i) {
      if (on_segment(P[i], P[(i + 1) % n], p)) {
        return true;
      }
    }
    return false;
  }

  Point centroid() {
    Point answer = {0, 0};
    for (int i = 0; i < n; ++i) {
      answer += (P[i] + P[(i + 1) % n]) * (P[i] * P[(i + 1) % n]);
    }
    answer /= area() / 3;
    return answer;
  }

  int winding_number(Point p) {
    Angle a = {P.back()};
    for (Point v : P) {
      a.move_to(v);
    }
    return a.revolutions;
  }

  void sort_around(Point p) {
    sort(P.begin(), P.end(), [&](Point a, Point b) {
      return make_tuple(in_upper_half(a - p), 0, magnitude(a - p)) <
             make_tuple(in_upper_half(b - p), orientation(a, b, p),
                        magnitude(b - p));
    });
  }

  // change > 0 to ≥ 0 to include points on the hull that aren't vertices
  void add_point_to_hull(vector<int> &hull, int i, bool turn_left) {
    while (true) {
      int m = (int)hull.size();
      if (!(m >= 2 &&
            orientation(P[hull[m - 2]], P[hull[m - 1]], P[i]) *
              (turn_left ? 1 : -1) >= EPS)) {
        break;
      }
      hull.pop_back();
    }
    hull.push_back(i);
  }

  pair<vector<int>, vector<int>> build_hulls() {
    vector<int> indices(n), upper_hull, lower_hull;
    iota(indices.begin(), indices.end(), 0);
    sort(indices.begin(), indices.end(),
         [&](int i, int j) { return P[i] < P[j]; });
    for (int i : indices) {
      add_point_to_hull(upper_hull, i, true);
      add_point_to_hull(lower_hull, i, false);
    }
    return {upper_hull, lower_hull};
  }

  vector<int> convex_hull_indices() {
    auto [upper_hull, lower_hull] = build_hulls();
    if ((int)lower_hull.size() <= 1) {
      return lower_hull;
    }
    if (lower_hull[0] == lower_hull[1]) {
      return {0};
    }
    lower_hull.insert(lower_hull.end(),
                      upper_hull.rbegin() + 1,
                      upper_hull.rend() - 1);
    return lower_hull;
  }

  Polygon convex_hull() {
    vector<int> indices = convex_hull_indices();
    vector<Point> hull;
    int m = (int)indices.size();
    hull.reserve(m);
    for (int i : indices) {
      hull.push_back(P[i]);
    }
    return {hull, m};
  }
};
```