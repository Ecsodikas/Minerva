module minerva.matrix.matrixmn;

/**
 * Struct representing a MxN-dimensional matrix. 
 * Where M is the number of rows and N the number of columns.
 * Authors: eXodiquas
 * Date: September 4, 2023
 * Examples:
 * -------------------------------------------------------------------
 * Matrix!(5, 5) v = Matrix!(5,5)([[1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5]]);
 * assert(v.x0y0 == 1)
 * -------------------------------------------------------------------
 * Throws: Exception whenever the supplied nested lists of values have not
 * the same dimensions as the supplied dimensions of the matrix.
 */

struct Matrix(size_t M, size_t N)
{
  double[N][M] components;

  this(double[N][M] init)
  {
    foreach (i, x; components)
    {
      foreach (j, y; x)
      {
        this.components[i][j] = init[i][j];
      }
    }
  }

  import std.format : format;

  static foreach (y; 0 .. M)
  {
    static foreach (x; 0 .. N)
    {
      mixin(format!"double x%sy%s() {return this.components[%s][%s];}"(x, y, y, x));
    }
  }
}

unittest
{
  Matrix!(5, 5) m1 = Matrix!(5, 5)([
    [1.0, 2.0, 3.0, 4.0, 5.0],
    [6.0, 7.0, 8.0, 9.0, 10.0],
    [11.0, 12.0, 13.0, 14.0, 15.0],
    [16.0, 17.0, 18.0, 19.0, 20.0],
    [21.0, 22.0, 23.0, 24.0, 25.0]
  ]);
  assert(m1.x0y1 == 6.0);
  assert(m1.x1y3 == 17.0);
  assert(m1.x4y1 == 10.0);
  assert(m1.x0y0 == 1.0);

  Matrix!(1, 2) m2 = Matrix!(1, 2)([
      [1.0, 2.0]
    ]);

  assert(m2.x0y0 == 1.0);
  assert(m2.x1y0 == 2.0);
}

/**
 * Creates a `Matrix!(M,N)` filled with `0.0`s.
 * Where M is the number of rows and N the number of columns.
 * Authors: eXodiquas
 * Date: September 5, 2023
 * Params:
 *     M = is the number of rows.
 *     N = is the number of columns.
 * Returns: A `Matrix!(M,N)` filled with `0.0`s.
 */
Matrix!(M, N) zeroMN(size_t M, size_t N)() pure @safe
{
  double[N][M] components = 0.0;
  return Matrix!(M, N)(components);
}

unittest
{
  auto m1 = zeroMN!(10, 10);
  assert(m1.components == [
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    ]);

  auto m2 = zeroMN!(1, 1);
  assert(m2.components == [
      [0.0]
    ]);

  auto m3 = zeroMN!(3, 2);
  assert(m3.components == [
      [0.0, 0.0],
      [0.0, 0.0],
      [0.0, 0.0]
    ]);

  auto m4 = zeroMN!(1, 3);
  assert(m4.components == [
      [0.0, 0.0, 0.0],
    ]);

  auto m5 = zeroMN!(3, 1);
  assert(m5.components == [
      [0.0],
      [0.0],
      [0.0],
    ]);
}
