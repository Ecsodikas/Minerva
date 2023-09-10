module minerva.matrix.matrix2;
import minerva.vector.vector2;

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
