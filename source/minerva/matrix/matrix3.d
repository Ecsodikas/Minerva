module minerva.matrix.matrix3;
import minerva.vector.vector3;

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
