module minerva.vector.vectorn;

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
