//////////////////////////////////////////////////////////////////////
//                       Vector Data Structures                     //
//////////////////////////////////////////////////////////////////////

/**
 * Enum representing the single components of a `Vector3`.
 * (Only used for the `downgrade` function.)
 */
enum Vector3Pos {X, Y, Z}

/**
 * Struct representing a 2 dimensional vector.
 */
struct Vector2 {
  double x;
  double y;
} 

/**
 * Struct representing a 3 dimensional vector.
 */
struct Vector3 {
  double x;
  double y;
  double z;
} 

//////////////////////////////////////////////////////////////////////
//                          Vector2 Functions                       //
//////////////////////////////////////////////////////////////////////

/**
 * Creates the 2 dimensional origin (0,0).
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Returns: Vector2(0.0, 0.0)
 */
Vector2 zero2() pure nothrow @nogc @safe {
  return Vector2(0.0, 0.0);
}

/**
 * Adds two vectors `v1` and `v2` components wise.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1 = is the left hand side of the addition.
 *     v2 = is the right hand side of the addition.
 * Returns: A `Vector2` representing the addition of `v1` and `v2`.
 */
Vector2 add(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe {
  return Vector2(v1.x + v2.x, v1.y + v2.y);
}

unittest {
  auto a = Vector2(5.0, 3.0);
  auto b = Vector2(2.0, 1.0);
  auto c = a.add(b);
  assert(Vector2(7.0, 4.0) == c);
}

/**
 * Scales a vector `v` by a given number `scalar`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector to scale.
 *     scalar = is the amount the vector gets scaled.
 * Returns: A `Vector2` representing the scaled version of `v`.
 */
Vector2 scale(Vector2 v, double scalar) pure nothrow @nogc @safe {
  return Vector2(v.x * scalar, v.y * scalar);
}

unittest {
  auto a = Vector2(5.0, 3.0);
  auto c = a.scale(2.0);
  assert(Vector2(10.0, 6.0) == c);
  assert(c.scale(0) == zero2());
}

/**
 * Calculates the magnitude (or length) of `v`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want the magnitude of.
 * Returns: A `double` representing the magnitude of `v`.
 */
double mag(Vector2 v) pure nothrow @nogc @safe {
  import std.math.algebraic : sqrt;
  return (v.x * v.x + v.y * v.y).sqrt();
}

unittest {
  auto a = Vector2(5.0, 0.0);
  auto b = Vector2(3.0, 4.0);
  assert(a.mag() == 5.0);
  assert(b.mag() == 5.0);
  assert(zero2().mag() == 0.0);
}

/**
 * Calculates the normalized version of `v`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to normalize.
 * Returns: A `Vector2` representing the normalized version of `v`.
 */
Vector2 norm(Vector2 v) pure nothrow @nogc @safe {
  if (v == zero2()) { return zero2(); }
  return v.scale(1.0 / v.mag());
}

unittest {
  auto a = Vector2(5.0, 0.0);
  assert(a.norm() == Vector2(1.0, 0.0));
  assert(zero2().norm() == zero2());
}

/**
 * Calculates the cross product of `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the left hand side of the cross product.
 *     v2      = is the right hand side of the cross product.
 * Returns: A `double` representing the cross product 
 *          of `v1` and 'v2'.
 */
double cross(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe {
  return v1.x * v2.y - v2.x * v1.y;
}

unittest {
  auto a = Vector2(5.0, 1.0);
  auto b = Vector2(2.0, 3.0);
  assert(a.cross(b) == 13.0);
}

/**
 * Calculates the dot product (or scalar product) of `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the left hand side of the dot product.
 *     v2      = is the right hand side of the dot product.
 * Returns: A `double` representing the dot product 
 *          of `v1` and 'v2'.
 */
double dot(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe {
  return v1.x * v2.x + v1.y * v2.y;
}

unittest {
  auto a = Vector2(5.0, 2.0);
  auto b = Vector2(4.0, 5.0);
  assert(a.dot(b) == 30.0);
}

/**
 * Calculates the angle between `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the first vector.
 *     v2      = is the second vector.
 * Returns: A `double` in radians representing the angle between
 *          `v1` and 'v2'.
 */
double angle(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe {
  import std.math.trigonometry : acos;
  auto v1N = v1.norm();
  auto v2N = v2.norm();
  return acos(v1N.dot(v2N));
}

unittest {
  auto a = Vector2(5.0, 0.0);
  auto b = Vector2(0.0, 5.0);
  import std.math.rounding : round;
  assert(a.angle(b).round() == 2);
}

/**
 * Swaps the x and the y value of `v`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to swap.
 * Returns: A `Vector2` with swapped components in comparison to `v`.
 */
Vector2 swap(Vector2 v) pure nothrow @nogc @safe {
  auto xN = v.y;
  auto yN = v.x;
  return Vector2(xN, yN);
}

unittest {
  auto a = Vector2(5.0, 0.0);
  assert(a.swap() == Vector2(0.0, 5.0));
}

/**
 * Adds a new dimension to `v`, making it a `Vector3`. The new
 * dimension has default value 0.0.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to add a new dimension.
 * Returns: A `Vector3` with `v`s x and y value und z equals to 0.0.
 */
Vector3 upgrade(Vector2 v) pure nothrow @nogc @safe {
  return Vector3(v.x, v.y, 0.0);
}

unittest {
  auto a = Vector2(5.0, 0.0);
  assert(a.upgrade() == Vector3(5.0, 0.0, 0.0));
}

//////////////////////////////////////////////////////////////////////
//                          Vector3 Functions                       //
//////////////////////////////////////////////////////////////////////

/**
 * Creates the 3 dimensional origin (0,0,0).
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Returns: Vector3(0.0, 0.0, 0.0)
 */
Vector3 zero3() pure nothrow @nogc @safe {
  return Vector3(0.0, 0.0, 0.0);
}

/**
 * Adds two vectors `v1` and `v2` components wise.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1 = is the left hand side of the addition.
 *     v2 = is the right hand side of the addition.
 * Returns: A `Vector3` representing the addition of `v1` and `v2`.
 */
Vector3 add(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe {
  return Vector3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

unittest {
  auto a = Vector3(5.0, 3.0, -4.0);
  auto b = Vector3(2.0, 1.0, 2.0);
  auto c = a.add(b);
  assert(Vector3(7.0, 4.0, -2.0) == c);
}

/**
 * Scales a vector `v` by a given number `scalar`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector to scale.
 *     scalar = is the amount the vector gets scaled.
 * Returns: A `Vector3` representing the scaled version of `v`.
 */
Vector3 scale(Vector3 v, double scalar) pure nothrow @nogc @safe {
  return Vector3(v.x * scalar, v.y * scalar, v.z * scalar);
}

unittest {
  auto a = Vector3(5.0, 3.0, 2.0);
  auto c = a.scale(2.0);
  assert(Vector3(10.0, 6.0, 4.0) == c);
  assert(c.scale(0) == zero3());
}

/**
 * Calculates the magnitude (or length) of `v`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want the magnitude of.
 * Returns: A `double` representing the magnitude of `v`.
 */
double mag(Vector3 v) pure nothrow @nogc @safe {
  import std.math.algebraic : sqrt;
  return (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
}

unittest {
  auto a = Vector3(5.0, 0.0, 0.0);
  auto b = Vector3(3.0, 4.0, 5.0);
  assert(a.mag() == 5.0);
  import std.math : round;
  assert(b.mag().round() == 7);
  assert(zero3().mag() == 0.0);
}

/**
 * Calculates the normalized version of `v`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to normalize.
 * Returns: A `Vector3` representing the normalized version of `v`.
 */
Vector3 norm(Vector3 v) pure nothrow @nogc @safe {
  if (v == zero3()) { return zero3(); }
  return v.scale(1.0 / v.mag());
}

unittest {
  auto a = Vector2(5.0, 0.0);
  assert(a.norm() == Vector2(1.0, 0.0));
  assert(zero3().norm() == zero3());
}

/**
 * Calculates the cross product of `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the left hand side of the cross product.
 *     v2      = is the right hand side of the cross product.
 * Returns: A `Vector3` representing the cross product 
 *          of `v1` and 'v2'.
 */
Vector3 cross(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe {
  return Vector3(v1.y * v2.z - v1.z * v2.y,
		 v1.z * v2.x - v1.x * v2.z,
		 v1.x * v2.y - v1.y * v2.x);
}

unittest {
  auto a = Vector3(1.0, 2.0, 3.0);
  auto b = Vector3(3.0, 4.0, 5.0);
  assert(a.cross(b) == Vector3(-2.0, 4.0, -2.0));
}

/**
 * Calculates the dot product (or scalar product) of `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the left hand side of the dot product.
 *     v2      = is the right hand side of the dot product.
 * Returns: A `double` representing the dot product 
 *          of `v1` and 'v2'.
 */
double dot(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe {
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

unittest {
  auto a = Vector3(5.0, 2.0, 3.0);
  auto b = Vector3(4.0, 5.0, 8.0);
  assert(a.dot(b) == 54.0);
}

/**
 * Calculates the angle between `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v1      = is the first vector.
 *     v2      = is the second vector.
 * Returns: A `double` in radians representing the angle between
 *          `v1` and 'v2'.
 */
double angle(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe {
  import std.math.trigonometry : acos;
  auto v1M = v1.mag();
  auto v2M = v2.mag();
  return acos(v1.dot(v2) / v1M * v2M);
}

unittest {
  auto a = Vector3(5.0, 0.0, 0.0);
  auto b = Vector3(0.0, 5.0, 0.0);
  import std.math.rounding : round;
  assert(a.angle(b).round() == 2);
}

/**
 * Swaps the x, y and z values of `v` to the left, so x becomes y,
 * y becomes z and z becomes x.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to swap to the left.
 * Returns: A `Vector3` with swapped components in comparison to `v`.
 */
Vector3 swapLeft(Vector3 v) pure nothrow @nogc @safe {
  auto xN = v.y;
  auto yN = v.z;
  auto zN = v.x;
  return Vector3(xN, yN, zN);
}

unittest {
  auto a = Vector3(5.0, 0.0, 3.0);
  assert(a.swapLeft() == Vector3(0.0, 3.0, 5.0));
}

/**
 * Swaps the x, y and z values of `v` to the right, so x becomes z,
 * y becomes a and z becomes y.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to swap to the left.
 * Returns: A `Vector3` with swapped components in comparison to `v`.
 */
Vector3 swapRight(Vector3 v) pure nothrow @nogc @safe {
  auto xN = v.z;
  auto yN = v.x;
  auto zN = v.y;
  return Vector3(xN, yN, zN);
}

unittest {
  auto a = Vector3(5.0, 0.0, 3.0);
  assert(a.swapRight() == Vector3(3.0, 5.0, 0.0));
  assert(a.swapLeft().swapRight() == a);
}

/**
 * Downgrades the given `Vector3` to a `Vector2` removing the one 
 * component denoted by `vp`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector we want to downgrade.
 *     vp     = the component we want to remove.
 * Returns: A `Vector2` with the same components as `v` except the
 *          removed one.
 * Examples:
 * -------------------------------------------------------------------
 * Vector3(1.0, 2.0, 3.0).downgrade(Vector3Pos.X); //Vector2(2.0, 3.0)
 * -------------------------------------------------------------------
 */
Vector2 downgrade(Vector3 v, Vector3Pos vp) pure nothrow @nogc @safe {
  switch (vp) {
  case Vector3Pos.X:
    return Vector2(v.y, v.z);
  case Vector3Pos.Y:
    return Vector2(v.x, v.z);
  default:
    return Vector2(v.x, v.y);
  }
}

unittest {
  auto a = Vector3(5.0, 0.0, 1.0);
  assert(a.downgrade(Vector3Pos.X) == Vector2(0.0, 1.0));
  assert(a.downgrade(Vector3Pos.Y) == Vector2(5.0, 1.0));
  assert(a.downgrade(Vector3Pos.Z) == Vector2(5.0, 0.0));
}
