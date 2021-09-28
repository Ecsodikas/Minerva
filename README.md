# Minerva

![example workflow](https://github.com/exodiquas/Minerva/actions/workflows/d.yml/badge.svg)

!!! IMPORTANT !!! This library is still in beta, the functionality it has works fine, but it gets expanded and the interface is subject to change.

Minerva, named after the roman goddess of wisdom (and other stuff), is a dependency less (except phobos) D linear algebra library. Main goal is to make the library 100% pure, functional and safe, plus make it one single file.

The main reason Minerva exists is to power Saturn, a complete D only ray tracer without interfacing with any C/C++ library at all.

## Current State

- [x] The 2 and 3-dimensional vectors
- [x] 2x2 and 3x3 matrices
- [x] n-dimensional vectors
- [ ] n x m matrices
- [ ] operator overloading for basic functions like `add`, `scale`.

## Documentation

The documentation can be found here: [https://exodiquas.github.io/Minerva/](https://exodiquas.github.io/Minerva/)

## Tutorial

Still work in progress...

To start working with minerva, just add the dependency from dub into your project: [https://code.dlang.org/packages/minerva](https://code.dlang.org/packages/minerva).

To use it in your project just import it like `import minerva` and you are ready to go. 2 and 3 dimensional vectors are implemented by hand, because they have some special use cases like the cross product. To see all the functionalites you can look at the documentation.

See that every operation creates a new vector, so there is no mutation. This has several advantages, but also the downside of not being the most performant calculations possible. If you need high performance, please do not use this library.

```d
import minerva;

void main() {
  auto a = Vector2(2.0, 1.0);
  norm(Vector2(5.0, 0.0)); // Vector2(1.0, 0.0) 
  auto b = a.add(Vector2(1.0, 1.0)); // Vector2(3.0, 2.0)
  auto c = b.upgrade(); // Vector3(3.0, 2.0, 0.0)
  c.downgrade(Vector3Pos.X); // Vector2(2.0, 0.0) 
  a.swap(); // Vector2(1.0, 2.0) exists only for Vector2.
  c.rotateClockwise(); // Vector3(0.0, 3.0, 2.0)
  
  
  auto d = Vector!5([1, 2, 3, 4, 5]); // Vector!5([1, 2, 3, 4, 5])
  auto e = Vector!5([1, 2, 3, 4, 5]); // Vector!5([1, 2, 3, 4, 5])
  d.add(e); // Vector!5([2, 4, 6, 8, 10]) only two vectors with same dimensions can be added. 
  d.scale(10); // Vector!5([10, 20, 30, 40, 50])
  d.mag(); // sqrt(55.0)
  d.norm(); // Vector!5([1.0/sqrt(55), 2.0/sqrt(55), 3.0/sqrt(55), 4.0/sqrt(55), sqrt(5.0/11.0)])
}
```

## Help
If you want to help with this project, or if you have problems with the library, just let me know via an issue. I'm more than happy to help out and fix some bugs or issues.
