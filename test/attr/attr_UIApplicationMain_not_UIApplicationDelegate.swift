// RUN: rm -rf %t/clang-module-cache
// RUN: %swift %clang-importer-sdk -parse -parse-as-library -verify -module-cache-path %t/clang-module-cache %s
// XFAIL: linux

import UIKit

@UIApplicationMain // expected-error{{'UIApplicationMain' class must conform to the 'UIApplicationDelegate' protocol}}
class MyNonDelegate {
}
