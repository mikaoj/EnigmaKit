//
//  ReflectorTests.swift
//  EnigmaKit
//
//  Created by Joakim Gyllström on 7/1/17.
//

import XCTest
@testable import EnigmaKit

class ReflectorTests: XCTestCase {
  func testEncode() {
    let r = Reflector.A
    let c = r.encode("A")
    XCTAssertEqual(c, "E", "A should be wired to E on Reflector A")
  }
  
  static var allTests: [(String, (ReflectorTests) -> () -> Void)] = [
    ("testEncode", testEncode),
  ]
}
