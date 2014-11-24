// RUN: rm -rf %t/clang-module-cache
// RUN: %swift %clang-importer-sdk -parse -verify -module-cache-path %t/clang-module-cache -target x86_64-apple-macosx10.9 %s
// XFAIL: linux

// The accessibility APIs are handled differently. A class might conform to both 
// NSAccessibility (containing accessibility properties) and individual 
// accessibility protocols (containing accessibility methods with the same 
// names as the properties). This should not compile. To avoid the problem, we 
// import setters and getters instead of the accessibility properties from 
// NSAccessibility.
//
// radar://17509751

import AppKit

class A: NSView, NSAccessibilityButton {
  override func accessibilityLabel() -> String?  {return "Anna's button"}
  override func accessibilityPerformPress() -> Bool {return true}
  override func accessibilityParent() -> AnyObject? {return nil}
  override func isAccessibilityFocused() -> Bool {return false}
}

class AA: NSView {
   override func accessibilityPerformPress() -> Bool {return true}
}

let a = A()
print(a.accessibilityLabel())
