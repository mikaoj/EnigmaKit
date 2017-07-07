//
//  PlugboardTests.swift
//  EnigmaKitTests
//
//  Created by Joakim Gyllström on 6/25/17.
//

import XCTest
@testable import EnigmaKit

class PlugboardTests: XCTestCase {
  func testUnpatchedEncode() {
    let p = Plugboard()
    let c = p.encode("A")
    XCTAssertEqual(c, "A", "Encoding unpatched character should result in unchanged character")
  }

  func testPatchedEncode() {
    var p = Plugboard()
    p.add(("A", "B"))
    let c = p.encode("A")
    XCTAssertEqual(c, "B", "Encoding patched character should result in B")
  }

  func testAddSameCharacterPatch() {
    var p = Plugboard()
    XCTAssertFalse(p.add(("A", "A")), "Can't add patch to the same characters")
  }

  static var allTests: [(String, (PlugboardTests) -> () -> Void)] = [
    ("testUnpatchedEncode", testUnpatchedEncode),
    ("testPatchedEncode", testPatchedEncode),
  ]
}
