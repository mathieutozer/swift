// RUN: rm -rf %t/clang-module-cache
// RUN: %swift %clang-importer-sdk -parse -verify -module-cache-path %t/clang-module-cache -I %S/Inputs/custom-modules -enable-experimental-availability-checking -target x86_64-apple-macosx10.9 %s
// XFAIL: linux

import Foundation

// Tests for uses of version-based potential unavailability imported from ObjC APIs.
func callUnavailableObjC() {
  let _ = NSAvailableOn10_10() // expected-error {{'NSAvailableOn10_10' is only available on OS X version 10.10 or greater}}
  
  
  if #os(OSX >= 10.10) {
    let o = NSAvailableOn10_10()
    
    // Properties
    let _ = o.propertyOn10_11 // expected-error {{'propertyOn10_11' is only available on OS X version 10.11 or greater}}
    o.propertyOn10_11 = 22 // expected-error {{'propertyOn10_11' is only available on OS X version 10.11 or greater}}
    
    // Methods
    o.methodAvailableOn10_11() // expected-error {{'methodAvailableOn10_11()' is only available on OS X version 10.11 or greater}}
    
    // Initializers
    
    let _ = NSAvailableOn10_10(stringOn10_11:"Hi") // expected-error {{'init(stringOn10_11:)' is only available on OS X version 10.11 or greater}}
  }
}

// Declarations with Objective-C-originated potentially unavailable APIs

func functionWithObjCParam(o: NSAvailableOn10_10) { // expected-error {{'NSAvailableOn10_10' is only available on OS X version 10.10 or greater}}
}

class ClassExtendingUnvailableClass : NSAvailableOn10_10 { // expected-error {{'NSAvailableOn10_10' is only available on OS X version 10.10 or greater}}
}

class ClassAdoptingUnavailableProtocol : NSProtocolAvailableOn10_10 { // expected-error {{'NSProtocolAvailableOn10_10' is only available on OS X version 10.10 or greater}}
}
