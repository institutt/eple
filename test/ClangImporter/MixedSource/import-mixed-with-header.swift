// RUN: %empty-directory(%t)
// RUN: cp -R %S/Inputs/mixed-target %t

// FIXME: BEGIN -enable-source-import hackaround
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -enable-objc-interop -emit-module -o %t %clang-importer-sdk-path/swift-modules/CoreGraphics.swift
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -enable-objc-interop -emit-module -o %t %clang-importer-sdk-path/swift-modules/Foundation.swift
// FIXME: END -enable-source-import hackaround

// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk-nosource -I %t) -I %S/../Inputs/custom-modules -import-objc-header %t/mixed-target/header.h -emit-module-path %t/MixedWithHeader.swiftmodule %S/Inputs/mixed-with-header.swift %S/../../Inputs/empty.swift -module-name MixedWithHeader -enable-objc-interop -disable-objc-attr-requires-foundation-module
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk-nosource -I %t) -I %S/../Inputs/custom-modules -enable-objc-interop -typecheck %s -verify

// RUN: rm -rf %t/mixed-target/
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk-nosource -I %t) -I %S/../Inputs/custom-modules -enable-objc-interop -typecheck %s -verify

// FIXME: Disabled due to https://github.com/apple/swift/issues/50307.
// REQUIRES: issue_50307

import MixedWithHeader

func testReexportedClangModules(_ foo : FooProto) {
  _ = foo.bar as CInt
  _ = ExternIntX.x as CInt
}

func testCrossReferences(_ derived: Derived) {
  let obj: Base = derived
  _ = obj.safeOverride(ForwardClass()) as NSObject
  _ = obj.safeOverrideProto(ForwardProtoAdopter()) as NSObject

  testProtocolWrapper(ProtoConformer())
  _ = testStruct(Point2D(x: 2,y: 3))
}
