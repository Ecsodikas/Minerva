//////////////////////////////////////////////////////////////////////
//                       Vector Data Structures                     //
//////////////////////////////////////////////////////////////////////

/**
 * Enum representing the single components of a `Vector3`.
 * (Only used for the `downgrade` function.)
 * Authors: eXodiquas
 * Date: September 24, 2021
 */
enum Vector3Pos
{
  X,
  Y,
  Z
}

/**
 * Struct representing a 2-dimensional vector.
 * Authors: eXodiquas
 * Date: September 24, 2021
 */
immutable struct Vector2
{
  double x;
  double y;
}

/**
 * Struct representing a 3-dimensional vector.
 * Authors: eXodiquas
 * Date: September 24, 2021
 */
immutable struct Vector3
{
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
Vector2 zero2() pure nothrow @nogc @safe
{
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
Vector2 add(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe
{
  return Vector2(v1.x + v2.x, v1.y + v2.y);
}

unittest
{
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
Vector2 scale(Vector2 v, double scalar) pure nothrow @nogc @safe
{
  return Vector2(v.x * scalar, v.y * scalar);
}

unittest
{
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
double mag(Vector2 v) pure nothrow @nogc @safe
{
  import std.math : sqrt;

  return (v.x * v.x + v.y * v.y).sqrt();
}

unittest
{
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
Vector2 norm(Vector2 v) pure nothrow @nogc @safe
{
  if (v == zero2())
  {
    return zero2();
  }
  return v.scale(1.0 / v.mag());
}

unittest
{
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
double cross(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe
{
  return v1.x * v2.y - v2.x * v1.y;
}

unittest
{
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
double dot(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe
{
  return v1.x * v2.x + v1.y * v2.y;
}

unittest
{
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
double angle(Vector2 v1, Vector2 v2) pure nothrow @nogc @safe
{
  import std.math : acos;

  auto v1N = v1.norm();
  auto v2N = v2.norm();
  return acos(v1N.dot(v2N));
}

unittest
{
  auto a = Vector2(5.0, 0.0);
  auto b = Vector2(0.0, 5.0);
  import std.math : round;

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
Vector2 swap(Vector2 v) pure nothrow @nogc @safe
{
  auto xN = v.y;
  auto yN = v.x;
  return Vector2(xN, yN);
}

unittest
{
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
Vector3 upgrade(Vector2 v) pure nothrow @nogc @safe
{
  return Vector3(v.x, v.y, 0.0);
}

unittest
{
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
Vector3 zero3() pure nothrow @nogc @safe
{
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
Vector3 add(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe
{
  return Vector3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

unittest
{
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
Vector3 scale(Vector3 v, double scalar) pure nothrow @nogc @safe
{
  return Vector3(v.x * scalar, v.y * scalar, v.z * scalar);
}

unittest
{
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
double mag(Vector3 v) pure nothrow @nogc @safe
{
  import std.math : sqrt;

  return (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
}

unittest
{
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
Vector3 norm(Vector3 v) pure nothrow @nogc @safe
{
  if (v == zero3())
  {
    return zero3();
  }
  return v.scale(1.0 / v.mag());
}

unittest
{
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
Vector3 cross(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe
{
  return Vector3(v1.y * v2.z - v1.z * v2.y,
    v1.z * v2.x - v1.x * v2.z,
    v1.x * v2.y - v1.y * v2.x);
}

unittest
{
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
double dot(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe
{
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

unittest
{
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
double angle(Vector3 v1, Vector3 v2) pure nothrow @nogc @safe
{
  import std.math : acos;

  auto v1M = v1.mag();
  auto v2M = v2.mag();
  return acos(v1.dot(v2) / (v1M * v2M));
}

unittest
{
  auto a = Vector3(5.0, 0.0, 0.0);
  auto b = Vector3(0.0, 5.0, 0.0);
  import std.math : round;

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
Vector3 swapLeft(Vector3 v) pure nothrow @nogc @safe
{
  auto xN = v.y;
  auto yN = v.z;
  auto zN = v.x;
  return Vector3(xN, yN, zN);
}

unittest
{
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
Vector3 swapRight(Vector3 v) pure nothrow @nogc @safe
{
  auto xN = v.z;
  auto yN = v.x;
  auto zN = v.y;
  return Vector3(xN, yN, zN);
}

unittest
{
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
Vector2 downgrade(Vector3 v, Vector3Pos vp) pure nothrow @nogc @safe
{
  switch (vp)
  {
  case Vector3Pos.X:
    return Vector2(v.y, v.z);
  case Vector3Pos.Y:
    return Vector2(v.x, v.z);
  default:
    return Vector2(v.x, v.y);
  }
}

unittest
{
  auto a = Vector3(5.0, 0.0, 1.0);
  assert(a.downgrade(Vector3Pos.X) == Vector2(0.0, 1.0));
  assert(a.downgrade(Vector3Pos.Y) == Vector2(5.0, 1.0));
  assert(a.downgrade(Vector3Pos.Z) == Vector2(5.0, 0.0));
}

//////////////////////////////////////////////////////////////////////
//                       Matrix Data Structures                     //
//////////////////////////////////////////////////////////////////////

/**
 * Struct representing a 2x2 matrix in the form:
 * a b
 * c d
 */
immutable struct Matrix2x2
{
  double a;
  double b;
  double c;
  double d;
}

/**
 * Struct representing a 3x3 matrix in the form:
 * a b c
 * d e f
 * g h i
 */
immutable struct Matrix3x3
{
  double a;
  double b;
  double c;
  double d;
  double e;
  double f;
  double g;
  double h;
  double i;
}

//////////////////////////////////////////////////////////////////////
//                         Matrix2x2 Functions                      //
//////////////////////////////////////////////////////////////////////

/**
 * Creates a 2x2 unit matrix in the form:
 * 1.0 0.0
 * 0.0 1.0
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Returns: The unit matrix of type `Matrix2x2`.
 */
Matrix2x2 unit2x2() pure nothrow @nogc @safe
{
  return Matrix2x2(1.0, 0.0, 0.0, 1.0);
}

unittest
{
  assert(unit2x2() == Matrix2x2(1.0, 0.0, 0.0, 1.0));
}

/**
 * Extract the row vectors of a given matrix. The vectors are read 
 * like this:
 * a b
 * c d => (a, b), (c, d)
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix from which the row vectors should be
 *              be extracted.
 * Returns: A `Vector2[]` containg all the row vectors.
 */
Vector2[] rowVectors(Matrix2x2 m) pure nothrow @safe
{
  return [Vector2(m.a, m.b), Vector2(m.c, m.d)];
}

unittest
{
  auto a = Matrix2x2(1.0, 3.0, -4.0, 2.0);
  assert(a.rowVectors() == [Vector2(1.0, 3.0), Vector2(-4.0, 2.0)]);
}

/**
 * Extract the column vectors of a given matrix. The vectors are read 
 * like this:
 * a b
 * c d => (a, c), (b, d)
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix from which the column vectors should be
 *              be extracted.
 * Returns: A `Vector2[]` containg all the column vectors.
 */
Vector2[] colVectors(Matrix2x2 m) pure nothrow @safe
{
  return [Vector2(m.a, m.c), Vector2(m.b, m.d)];
}

unittest
{
  auto a = Matrix2x2(1.0, 3.0, -4.0, 2.0);
  assert(a.colVectors() == [Vector2(1.0, -4.0), Vector2(3.0, 2.0)]);
}

/**
 * Scale a given `Matrix2x2` `m` by a given `scalar`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix we want to scale.
 *     scalar = is the amount we want to scale.
 * Returns: A scaled version of our input `Matrix2x2` `m`.
 */
Matrix2x2 scale(Matrix2x2 m, double scalar) pure nothrow @nogc @safe
{
  return Matrix2x2(m.a * scalar, m.b * scalar,
    m.c * scalar, m.d * scalar);
}

unittest
{
  auto a = Matrix2x2(1.0, 3.0, -4.0, 2.0);
  assert(a.scale(5.0) == Matrix2x2(5.0, 15.0, -20.0, 10.0));
}

/**
 * Mutliplies two `Matrix2x2` with eachother.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m1      = is the left hand side matrix.
 *     m2      = is the right hand side matrix.
 * Returns: The resulting `Matrix2x2` from the multiplication.
 */
Matrix2x2 mult(Matrix2x2 m1, Matrix2x2 m2) pure nothrow @nogc @safe
{
  return Matrix2x2(m1.a * m2.a + m1.b * m2.c,
    m1.a * m2.b + m1.b * m2.d,
    m1.c * m2.a + m1.d * m2.c,
    m1.c * m2.b + m1.d * m2.d);
}

unittest
{
  auto a = Matrix2x2(1.0, 3.0, -4.0, 2.0);
  auto b = Matrix2x2(7.0, -3.0, -1.0, 5.0);
  assert(a.mult(b) == Matrix2x2(4.0, 12.0, -30.0, 22.0));

  auto c = Matrix2x2(1.0, 2.0, 3.0, 4.0);
  auto d = Matrix2x2(5.0, 6.0, 7.0, 8.0);
  assert(c.mult(d) == Matrix2x2(19.0, 22.0, 43.0, 50.0));
}

/**
 * Mutliplies a `Matrix2x2` and a `Vector2` with eachother.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix.
 *     v      = is the vector.
 * Returns: The resulting `Vector2` from the multiplication.
 */
Vector2 mult(Matrix2x2 m, Vector2 v) pure nothrow @nogc @safe
{
  return Vector2(m.a * v.x + m.b * v.y, m.c * v.x + m.d * v.y);
}

unittest
{
  auto a = Matrix2x2(1.0, 3.0, -4.0, 2.0);
  auto b = Vector2(3.0, 2.0);
  assert(a.mult(b) == Vector2(9.0, -8.0));
}

/**
 * Rotates a given `Vector2` by an `angle` in radians in clockwise
 * direction.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector.
 *     angle  = is the angle in radians.
 * Returns: The resulting `Vector2` from the rotation.
 */
Vector2 rotateClockwise(Vector2 v, double angle)
pure nothrow @nogc @safe
{
  import std.math;

  Matrix2x2 rotationMatrix = Matrix2x2(cos(-angle), sin(-angle),
    -sin(-angle), cos(-angle));

  return rotationMatrix.mult(v);
}

/**
 * Rotates a given `Vector2` by an `angle` in radians in counter 
 * clockwise direction.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector.
 *     angle  = is the angle in radians.
 * Returns: The resulting `Vector2` from the rotation.
 */
Vector2 rotateCounterClockwise(Vector2 v, double angle)
pure nothrow @nogc @safe
{
  import std.math;

  Matrix2x2 rotationMatrix = Matrix2x2(cos(angle), sin(angle),
    -sin(angle), cos(angle));

  return rotationMatrix.mult(v);
}

//////////////////////////////////////////////////////////////////////
//                         Matrix3x3 Functions                      //
//////////////////////////////////////////////////////////////////////

/**
 * Creates a 3x3 unit matrix in the form:
 * 1.0 0.0 0.0
 * 0.0 1.0 0.0
 * 0.0 0.0 1.0
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Returns: The unit matrix of type `Matrix3x3`.
 */
Matrix3x3 unit3x3() pure nothrow @nogc @safe
{
  return Matrix3x3(1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0);
}

unittest
{
  assert(unit3x3() == Matrix3x3(1.0, 0.0, 0.0,
      0.0, 1.0, 0.0,
      0.0, 0.0, 1.0));
}

/**
 * Extract the row vectors of a given matrix. The vectors are read 
 * like this:
 * a b c
 * d e f
 * g h i => (a, b, c), (d, e, f), (g, h, i)
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix from which the row vectors should be
 *              be extracted.
 * Returns: A `Vector3[]` containg all the row vectors.
 */
Vector3[] rowVectors(Matrix3x3 m) pure nothrow @safe
{
  return [
    Vector3(m.a, m.b, m.c),
    Vector3(m.d, m.e, m.f),
    Vector3(m.g, m.h, m.i)
  ];
}

unittest
{
  auto a = Matrix3x3(1.0, 3.0, -4.0,
    2.0, 5.1, 2.9,
    1.0, -4.9, -1.2);
  assert(a.rowVectors() == [
    Vector3(1.0, 3.0, -4.0),
    Vector3(2.0, 5.1, 2.9),
    Vector3(1.0, -4.9, -1.2)
  ]);
}

/**
 * Extract the column vectors of a given matrix. The vectors are read 
 * like this:
 * a b c
 * d e f
 * g h i => (a, d, g), (b, e, h), (c, f, i)
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix from which the column vectors should be
 *              be extracted.
 * Returns: A `Vector3[]` containg all the column vectors.
 */
Vector3[] colVectors(Matrix3x3 m) pure nothrow @safe
{
  return [
    Vector3(m.a, m.d, m.g),
    Vector3(m.b, m.e, m.h),
    Vector3(m.c, m.f, m.i)
  ];
}

unittest
{
  auto a = Matrix3x3(1.0, 3.0, -4.0,
    2.0, 5.1, 2.9,
    1.0, -4.9, -1.2);
  assert(a.colVectors() == [
    Vector3(1.0, 2.0, 1.0),
    Vector3(3.0, 5.1, -4.9),
    Vector3(-4.0, 2.9, -1.2)
  ]);
}

/**
 * Scale a given `Matrix3x3` `m` by a given `scalar`.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix we want to scale.
 *     scalar = is the amount we want to scale.
 * Returns: A scaled version of our input `Matrix3x3` `m`.
 */
Matrix3x3 scale(Matrix3x3 m, double scalar) pure nothrow @nogc @safe
{
  return Matrix3x3(m.a * scalar, m.b * scalar, m.c * scalar,
    m.d * scalar, m.e * scalar, m.f * scalar,
    m.g * scalar, m.h * scalar, m.i * scalar);
}

unittest
{
  auto a = Matrix3x3(1.0, 3.0, -4.0,
    2.0, 5.1, 3.0,
    1.0, -5.0, -1.2);
  assert(a.scale(5.0) == Matrix3x3(5.0, 15.0, -20.0,
      10.0, 25.5, 15.0,
      5.0, -25.0, -6.0));
}

/**
 * Mutliplies two `Matrix3x3` with eachother.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m1      = is the left hand side matrix.
 *     m2      = is the right hand side matrix.
 * Returns: The resulting `Matrix3x3` from the multiplication.
 */
Matrix3x3 mult(Matrix3x3 m1, Matrix3x3 m2) pure nothrow @nogc @safe
{
  double aN = m1.a * m2.a + m1.b * m2.d + m1.c * m2.g;
  double bN = m1.a * m2.b + m1.b * m2.e + m1.c * m2.h;
  double cN = m1.a * m2.c + m1.b * m2.f + m1.c * m2.i;
  double dN = m1.d * m2.a + m1.e * m2.d + m1.f * m2.g;
  double eN = m1.d * m2.b + m1.e * m2.e + m1.f * m2.h;
  double fN = m1.d * m2.c + m1.e * m2.f + m1.f * m2.i;
  double gN = m1.g * m2.a + m1.h * m2.d + m1.i * m2.g;
  double hN = m1.g * m2.b + m1.h * m2.e + m1.i * m2.h;
  double iN = m1.g * m2.c + m1.h * m2.f + m1.i * m2.i;

  return Matrix3x3(aN, bN, cN,
    dN, eN, fN,
    gN, hN, iN);
}

unittest
{
  auto a = Matrix3x3(1.0, 2.0, 3.0,
    4.0, 5.0, 6.0,
    7.0, 8.0, 9.0);
  auto b = Matrix3x3(9.0, 8.0, 7.0,
    6.0, 5.0, 4.0,
    3.0, 2.0, 1.0);

  assert(a.mult(b) == Matrix3x3(30.0, 24.0, 18.0,
      84.0, 69.0, 54.0,
      138.0, 114.0, 90.0));
}

/**
 * Mutliplies a `Matrix3x3` and a `Vector3` with eachother.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     m      = is the matrix.
 *     v      = is the vector.
 * Returns: The resulting `Vector3` from the multiplication.
 */
Vector3 mult(Matrix3x3 m, Vector3 v) pure nothrow @nogc @safe
{
  return Vector3(m.a * v.x + m.b * v.y + m.c * v.z,
    m.d * v.x + m.e * v.y + m.f * v.z,
    m.g * v.x + m.h * v.y + m.i * v.z);
}

unittest
{
  auto a = Matrix3x3(1.0, 3.0, -4.0,
    2.0, 5.0, 2.0,
    1.0, 3.0, 7.0);
  auto b = Vector3(3.0, 2.0, 4.0);
  assert(a.mult(b) == Vector3(-7.0, 24, 37));
}

/**
 * Rotates a given `Vector3` by an `angle` in radians in counter 
 * clockwise direction around the x-axis.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector.
 *     angle  = is the angle in radians.
 * Returns: The resulting `Vector3` from the rotation.
 */
Vector3 rotateX(Vector3 v, double angle) pure nothrow @nogc @safe
{
  import std.math;

  Matrix3x3 rotationMatrix =
    Matrix3x3(1.0, 0.0, 0.0,
      0.0, cos(angle), -sin(angle),
      0.0, sin(angle), cos(angle));

  return rotationMatrix.mult(v);
}

/**
 * Rotates a given `Vector3` by an `angle` in radians in counter 
 * clockwise direction around the y-axis.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector.
 *     angle  = is the angle in radians.
 * Returns: The resulting `Vector3` from the rotation.
 */
Vector3 rotateY(Vector3 v, double angle) pure nothrow @nogc @safe
{
  import std.math;

  Matrix3x3 rotationMatrix =
    Matrix3x3(cos(angle), 0.0, sin(angle),
      0.0, 1.0, 0.0,
      -sin(angle), 0.0, cos(angle));

  return rotationMatrix.mult(v);
}

/**
 * Rotates a given `Vector3` by an `angle` in radians in counter 
 * clockwise direction around the z-axis.
 * Authors: eXodiquas
 * Date: September 24, 2021
 * Params:
 *     v      = is the vector.
 *     angle  = is the angle in radians.
 * Returns: The resulting `Vector3` from the rotation.
 */
Vector3 rotateZ(Vector3 v, double angle) pure nothrow @nogc @safe
{
  import std.math;

  Matrix3x3 rotationMatrix =
    Matrix3x3(cos(angle), -sin(angle), 0.0,
      sin(angle), cos(angle), 0.0,
      0.0, 0.0, 1.0);

  return rotationMatrix.mult(v);
}

//////////////////////////////////////////////////////////////////////
//                N-Dimensional Vector Data Structures              //
//////////////////////////////////////////////////////////////////////

/**
 * Struct representing a N-dimensional vector.
 * This struct only works for vectors with more than 3 dimensions.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Examples:
 * -------------------------------------------------------------------
 * Vector!5 v = Vector!5([1,2,3,4,5]);
 * v.x0.writeln; // 1
 * v.x1.writeln; // 2
 * -------------------------------------------------------------------
 * Throws: Exception whenever the supplied list of values has not
 * the same length as the supplied dimension of the vector or when the
 * supplied dimension is less than 4.
 */
struct Vector(size_t dimension)
{
  double[dimension] components;

  this(double[] init)
  {
    if (init.length == components.length)
    {
      foreach (i, d; init)
      {
        components[i] = d;
      }
    }
    else
    {
      throw new Exception("Dimensions of init array and components, do not match.");
    }
  }

  static foreach (d; 0 .. dimension)
  {
    import std.format : format;

    mixin(format!"double x%s() {return this.components[%s];}"(d, d));
  }
}

/**
 * Creates a `Vector!dim` filled with `dim` `0.0`s.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     dim = is the number of dimensions.
 * Returns: A `Vector!dim` filled with `dim` `0.0`s.
 */
Vector!dim zeroN(size_t dim)() pure @safe
{
  double[dim] init;
  init[] = 0.0;
  return Vector!dim(init);
}

unittest
{
  Vector!5 a = Vector!5([0, 0, 0, 0, 0]);
  Vector!5 b = zeroN!5;
  assert(a == b);
}

/**
 * Adds two `Vector!dim` with the same dimensions component wise.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     lhs = is the left hand side of the addition.
 *     rhs = is the right hand side of the addition.
 * Returns: A `Vector!dim` representing the addition of `v1` and `v2`.
 */
Vector!dim add(size_t dim)(Vector!dim v1, Vector!dim v2) pure @safe
{
  double[] result;
  foreach (i, e; v1.components)
  {
    result ~= e + v2.components[i];
  }
  return Vector!dim(result);
}

unittest
{
  Vector!5 a = Vector!5([1, 2, 3, 4, 5]);
  Vector!5 b = Vector!5([1, 2, 3, 4, 5]);
  assert(a.add(b) == Vector!5([2, 4, 6, 8, 10]));
}

/**
 * Scales a vector `v` by a given number `scalar`.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v      = is the vector to scale.
 *     scalar = is the amount the vector gets scaled.
 * Returns: A `Vector!dim` representing the scaled version of `v`.
 */
Vector!dim scale(size_t dim)(Vector!dim v, double scalar) pure @safe
{
  double[] result;
  foreach (e; v.components)
  {
    result ~= e * scalar;
  }
  return Vector!dim(result);
}

unittest
{
  Vector!5 a = Vector!5([1, 2, 3, 4, 5]);
  assert(a.scale(5) == Vector!5([5, 10, 15, 20, 25]));
}

/**
 * Calculates the magnitude (or length) of `v`.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v      = is the vector we want the magnitude of.
 * Returns: A `double` representing the magnitude of `v`.
 */
double mag(size_t dim)(Vector!dim v) pure @safe
{
  double result = 0.0;
  foreach (e; v.components)
  {
    result += e * e;
  }
  import std.math : sqrt;

  return result.sqrt();
}

unittest
{
  import std.math : sqrt;

  Vector!5 a = Vector!5([1, 2, 3, 4, 5]);
  assert(a.mag() == sqrt(55.0));
}

/**
 * Calculates the normalized version of `v`.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v      = is the vector we want to normalize.
 * Returns: A `Vector!dim` representing the normalized version of `v`.
 */
Vector!dim norm(size_t dim)(Vector!dim v) pure @safe
{
  if (v == zeroN!dim)
  {
    return zeroN!dim;
  }
  return v.scale(1.0 / v.mag());
}

unittest
{
  Vector!4 a = Vector!4([2, 2, 2, 2]);
  assert(a.norm() == Vector!4([0.5, 0.5, 0.5, 0.5]));
  assert(Vector!4([0, 0, 0, 0]).norm == zeroN!4);
}

/**
 * Calculates the dot product of `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v1      = is the left hand side of the calculation.
 *     v2      = is the right hand side of the calculation.
 * Returns: A `double` representing the dot product of `v1` and `v2`.
 */
double dot(size_t dim)(Vector!dim v1, Vector!dim v2)
pure @safe
{
  double result = 0.0;
  foreach (i, e; v1.components)
  {
    result += e * v2.components[i];
  }
  return result;
}

unittest
{
  auto a = Vector!5([1, 2, 3, 4, 5]);
  auto b = Vector!5([3, 4, 5, 6, 7]);
  assert(a.dot(b) == 85);
}

/**
 * Calculates the angle between `v1` and `v2`.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v1      = is the first vector.
 *     v2      = is the second vector.
 * Returns: A `double` in radians representing the angle between
 *          `v1` and 'v2'.
 */
double angle(size_t dim)(Vector!dim v1, Vector!dim v2)
pure @safe
{
  import std.math : acos;

  auto v1M = v1.mag();
  auto v2M = v2.mag();
  import std;

  return acos(v1.dot(v2) / (v1M * v2M));
}

unittest
{
  auto a = Vector!4([1, 2, 3, 5]);
  auto b = Vector!4([3, 4, 5, 7]);
  assert(a.angle(b) < 0.2 && a.angle(b) > 0.19);
}

/**
 * Adds a dimension to `v`, making it a `Vector!(dim + 1)`.
 * The new dimension has default value 0.0.
 * Authors: eXodiquas
 * Date: September 28, 2021
 * Params:
 *     v      = is the vector we want to add a new dimension.
 * Returns: A `Vector!(dim + 1)` with an additional `0.0` as 
 * a component.
 */
Vector!(dim + 1) upgrade(size_t dim)(Vector!dim v) pure @safe
{
  double[] upgraded = v.components ~ 0.0;
  return Vector!(dim + 1)(upgraded);
}

unittest
{
  Vector!4 a = Vector!4([2, 2, 2, 2]);
  Vector!5 b = a.upgrade();
  assert(b == Vector!5([2, 2, 2, 2, 0]));
}

//////////////////////////////////////////////////////////////////////
//                MxN-Dimensional Matrix Data Structures            //
//////////////////////////////////////////////////////////////////////

/**
 * Struct representing a MxN-dimensional matrix.
 * Authors: eXodiquas
 * Date: September 4, 2023
 * Examples:
 * -------------------------------------------------------------------
 * Matrix!(5, 5) v = Matrix!(5,5)([[1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5]]);
 * assert(v.ex0y0 == 1)
 * -------------------------------------------------------------------
 * Throws: Exception whenever the supplied nested lists of values have not
 * the same dimensions as the supplied dimensions of the matrix.
 * 
 * Special Behaviours: Jagged arrays as initialisers could lead to unexpected behaviour.
 */

struct Matrix(size_t M, size_t N)
{
  double[N][M] components;

  this(double[][] init)
  {
    foreach (i, y; components)
    {
      foreach (j, x; components)
      {
        components[i][j] = init[i][j];
      }
    }
  }

  import std.format : format;

  static foreach (y; 0 .. N)
  {
    static foreach (x; 0 .. M)
    {
      mixin(format!"double ex%sy%s() {return this.components[%s][%s];}"(x, y, y, x));
    }
  }
}

unittest
{
  Matrix!(5, 5) m = Matrix!(5, 5)([
    [1.0, 2.0, 3.0, 4.0, 5.0],
    [6.0, 7.0, 8.0, 9.0, 10.0],
    [1.0, 2.0, 3.0, 4.0, 5.0],
    [6.0, 7.0, 8.0, 9.0, 10.0],
    [1.0, 2.0, 3.0, 4.0, 5.0]
  ]);
  assert(m.ex0y1 == 6.0);
  assert(m.ex1y3 == 7.0);
  assert(m.ex4y1 == 10.0);
  assert(m.ex0y0 == 1.0);
}
