// RUN: %swift -emit-ir %s
// XFAIL: linux

enum Singleton {
  case F(Singleton -> ())
}

enum Single {
  case F(Single -> ())
  case X
  case Y
}

enum Multi {
  case F(Multi -> ())
  case G(Multi -> ())
}
