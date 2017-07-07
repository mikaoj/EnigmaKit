//
//  EnigmaTests.swift
//  EnigmaKitTests
//
//  Created by Joakim Gyllström on 7/7/17.
//

import XCTest
@testable import EnigmaKit

class EnigmaTests: XCTestCase {
  func testHelloWorld() {
    let enigma = Enigma()
    let input = "HELLO WORLD"
    let expected = "ILBDA AMTAZ"
    let output = enigma.encode(input)

    XCTAssertEqual(output, expected)
  }

  func testWeatherReport() {
    let enigma = Enigma()
    let input = "WEATHER REPORT"
    let expected = "KLZFMNN TWLLLN"
    let output = enigma.encode(input)

    XCTAssertEqual(output, expected)
  }

  static var allTests: [(String, (EnigmaTests) -> () -> Void)] = [
    ("testHelloWorld", testHelloWorld),
    ("testWeatherReport", testWeatherReport),
  ]
}
