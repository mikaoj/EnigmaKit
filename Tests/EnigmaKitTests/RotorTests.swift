//
//  RotorTests.swift
//  EnigmaKitTests
//
//  Created by Joakim Gyllström on 6/24/17.
//

import XCTest
@testable import EnigmaKit

class RotorTests: XCTestCase {
  func testNoOffsetEncode() {
    let r = Rotor.I
    let c = r.encode("A", direction: .in)
    XCTAssertEqual(c, "E", "With no offset Rotor I should encode A to E")
  }

  func testOneOffsetEncode() {
    var r = Rotor.I
    r.position = 1
    let c = r.encode("A", direction: .in)
    XCTAssertEqual(c, "J", "With 1 offset Rotor I should encode A to J")
  }

  func testNoOffsetDecode() {
    let r = Rotor.I
    let c = r.encode("E", direction: .out)
    XCTAssertEqual(c, "A", "With no offset Rotor I should decode E to A")
  }

  func testOneOffsetDecode() {
    var r = Rotor.I
    r.position = 1
    let c = r.encode("J", direction: .out)
    XCTAssertEqual(c, "A", "With 1 offset Rotor I should decode J to A")
  }

  static var allTests: [(String, (RotorTests) -> () -> Void)] = [
    ("testNoOffsetEncode", testNoOffsetEncode),
    ("testOneOffsetEncode", testOneOffsetEncode),
    ("testNoOffsetDecode", testNoOffsetDecode),
    ("testOneOffsetDecode", testOneOffsetDecode),
  ]
}
