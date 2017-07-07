//
//  SpindleTests.swift
//  EnigmaKitTests
//
//  Created by Joakim Gyllström on 7/5/17.
//

import XCTest
@testable import EnigmaKit

class SpindleTests: XCTestCase {
  func testSingleStep() {
    var I = Rotor.I
    I.position = 14
    var II = Rotor.II
    II.position = 3
    let III = Rotor.III
    var spindle = Spindle(reflector: Reflector.B, rotors: [I, II, III])
    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 15)
    XCTAssertEqual(spindle.rotors[1].position, 3)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 16)
    XCTAssertEqual(spindle.rotors[1].position, 3)
    XCTAssertEqual(spindle.rotors[2].position, 0)
  }

  func testMoreSingelStep() {
    var I = Rotor.I
    I.position = 0
    var II = Rotor.II
    II.position = 0
    var III = Rotor.III
    III.position = 20
    var spindle = Spindle(reflector: Reflector.B, rotors: [III, II, I])
    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 21)
    XCTAssertEqual(spindle.rotors[1].position, 0)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 22)
    XCTAssertEqual(spindle.rotors[1].position, 1)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 23)
    XCTAssertEqual(spindle.rotors[1].position, 1)
    XCTAssertEqual(spindle.rotors[2].position, 0)
  }

  func testDoubleStep() {
    var I = Rotor.I
    I.position = 16
    var II = Rotor.II
    II.position = 3
    let III = Rotor.III
    var spindle = Spindle(reflector: Reflector.B, rotors: [I, II, III])
    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 17)
    XCTAssertEqual(spindle.rotors[1].position, 4)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 18)
    XCTAssertEqual(spindle.rotors[1].position, 5)
    XCTAssertEqual(spindle.rotors[2].position, 1)
  }

  func testMoreDoubleStep() {
    var I = Rotor.I
    I.position = 0
    var II = Rotor.II
    II.position = 3
    var III = Rotor.III
    III.position = 20
    var spindle = Spindle(reflector: Reflector.B, rotors: [III, II, I])
    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 21)
    XCTAssertEqual(spindle.rotors[1].position, 3)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 22)
    XCTAssertEqual(spindle.rotors[1].position, 4)
    XCTAssertEqual(spindle.rotors[2].position, 0)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 23)
    XCTAssertEqual(spindle.rotors[1].position, 5)
    XCTAssertEqual(spindle.rotors[2].position, 1)

    _ = spindle.encode("A")

    XCTAssertEqual(spindle.rotors[0].position, 24)
    XCTAssertEqual(spindle.rotors[1].position, 5)
    XCTAssertEqual(spindle.rotors[2].position, 1)
  }

  func testEncode() {
    var s = Spindle(reflector: Reflector.B, rotors: [Rotor.III, Rotor.II, Rotor.I])

    let input = "AAAAA"
    let expected = "BDZGO"
    let result = String(input.map {
      s.encode($0)
    })

    XCTAssertEqual(result, expected)
  }

  static var allTests: [(String, (SpindleTests) -> () -> Void)] = [
    ("testSingleStep", testSingleStep),
    ("testMoreSingelStep", testMoreSingelStep),
    ("testDoubleStep", testDoubleStep),
    ("testMoreDoubleStep", testMoreDoubleStep),
    ("testEncode", testEncode),
  ]
}
