//
//  WheelTests.swift
//  EnigmaKitTests
//
//  Created by Joakim Gyllström on 6/24/17.
//

import XCTest
@testable import EnigmaKit

class WheelTests: XCTestCase {

  func testInitializeWithDifferentNumberOfCharacters() {
    do {
      let _ = try Wheel(inner: ["A"])
      XCTAssertTrue(false, "Should throw")
    } catch {
      XCTAssertTrue(true, "Should throw")
    }
  }

  func testInitializeWithSameNumberOfCharacters() {
    do {
      let _ = try Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"])
      XCTAssertTrue(true, "Should not throw")
    } catch {
      XCTAssertTrue(false, "Should not throw")
    }
  }

  func testInitializeWithNegativeOffset() {
    do {
      let _ = try Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: -1)
      XCTAssertTrue(false, "Should throw")
    } catch {
      XCTAssertTrue(true, "Should throw")
    }
  }

  func testInitializeWithTooLargeOffset() {
    do {
      let _ = try Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: 26)
      XCTAssertTrue(false, "Should throw")
    } catch {
      XCTAssertTrue(true, "Should throw")
    }
  }

  func testEncodeWithOffset() {
    let w = try! Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: 19)
    let c = w.encode("A")

    XCTAssertEqual(c, "T", "Encode A with setting 19 should give character T")
  }

  func testEncodeIndexOutOfBounds() {
    let w = try! Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: 19)
    let c = w.encode("Z")

    XCTAssertEqual(c, "S", "Encode Z with setting 19 should give character S")
  }

  func testDecodeWithOffset() {
    let w = try! Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: 19)
    let c = w.decode("T")

    XCTAssertEqual(c, "A", "Decode T with setting 19 should give character A")
  }

  func testDecodeIndexOutOfBounds() {
    let w = try! Wheel(inner: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"], setting: 19)
    let c = w.decode("A")

    XCTAssertEqual(c, "H", "Decode A with setting 19 should give character H")
  }

  static var allTests: [(String, (WheelTests) -> () -> Void)] = [
    ("testInitializeWithDifferentNumberOfCharacters", testInitializeWithDifferentNumberOfCharacters),
    ("testInitializeWithSameNumberOfCharacters", testInitializeWithSameNumberOfCharacters),
    ("testInitializeWithNegativeOffset", testInitializeWithNegativeOffset),
    ("testInitializeWithTooLargeOffset", testInitializeWithTooLargeOffset),
    ("testEncodeWithOffset", testEncodeWithOffset),
    ("testEncodeIndexOutOfBounds", testEncodeIndexOutOfBounds),
    ("testDecodeWithOffset", testDecodeWithOffset),
    ("testDecodeIndexOutOfBounds", testDecodeIndexOutOfBounds),
  ]
}
