// RUN: %swift -target x86_64-apple-macosx10.9 %s -emit-ir
// XFAIL: linux

// Smoke test that SIL-IRGen can compile a standalone program offline.
func f() {}
f()
