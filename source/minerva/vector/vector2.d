module minerva.vector.vector2;
import minerva.vector.vector3;
import minerva.matrix.matrix2;

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

/// Vector addition
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

/// Vector scaling
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

/// Get the magnitude of a vector
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

/// Normalise a vector
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

/// Calculate the cross product between two 2 dimensional vectors
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

/// Calculate the dot product between two 2 dimensional vectors
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

/// Calculate the angle between two 2 dimensional vectors
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

/// Swap the components of a 2 dimensional vector
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

/// Add a third dimension to a 2 dimensional vector
unittest
{
    auto a = Vector2(5.0, 0.0);
    assert(a.upgrade() == Vector3(5.0, 0.0, 0.0));
}
