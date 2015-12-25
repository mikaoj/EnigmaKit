// The MIT License (MIT)
//
// Copyright (c) 2015 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
import EnigmaKit

class EnigmaTests: XCTestCase {
    
    var enigma: Enigma!

    override func setUp() {
        super.setUp()
        
        enigma = Enigma()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncodeAAAAA() {
        let input = "AAAAA"
        let expected = "BDZGO"
        let result = enigma.encode(input)
        
        
        XCTAssert(enigma.rotors.first!.position == 5)
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeAAAAAWithRingSetting() {
        enigma.rotors[0].setting = 1
        enigma.rotors[1].setting = 1
        enigma.rotors[2].setting = 1
        
        
        let input = "AAAAA"
        let expected = "EWTYX"
        let result = enigma.encode(input)
        
        XCTAssert(enigma.rotors.first!.position == 5)
        XCTAssertEqual(expected, result)
    }
    
    func testNormalStep() {
        enigma.rotors[0].position = 20
        enigma.rotors[1].position = 0
        enigma.rotors[2].position = 0
        
        enigma.encode("A")
        
        XCTAssertEqual(enigma.rotors[0].position, 21)
        XCTAssertEqual(enigma.rotors[1].position, 0)
        XCTAssertEqual(enigma.rotors[2].position, 0)
        
        enigma.encode("A")
        
        XCTAssertEqual(enigma.rotors[0].position, 22)
        XCTAssertEqual(enigma.rotors[1].position, 1)
        XCTAssertEqual(enigma.rotors[2].position, 0)
        
        enigma.encode("A")
        
        XCTAssertEqual(enigma.rotors[0].position, 23)
        XCTAssertEqual(enigma.rotors[1].position, 1)
        XCTAssertEqual(enigma.rotors[2].position, 0)
    }
    
    func testDoubleStep() {
        // Set up rotor position ADU
        enigma.rotors[0].position = 20 // U
        enigma.rotors[1].position = 3 // D
        enigma.rotors[2].position = 0 // A
        
        enigma.encode("A")
        
        // We should now be at position ADV.
        // The fast rotor is at a notch V
        XCTAssertEqual(enigma.rotors[0].position, 21) // V
        XCTAssertEqual(enigma.rotors[1].position, 3) // D
        XCTAssertEqual(enigma.rotors[2].position, 0) // A
        
        enigma.encode("A")
        
        // Position AEW
        // Middle motor is at a notch
        XCTAssertEqual(enigma.rotors[0].position, 22) // W
        XCTAssertEqual(enigma.rotors[1].position, 4) // E
        XCTAssertEqual(enigma.rotors[2].position, 0) // A
        
        enigma.encode("A")
        
        // Which should mean that we now have taken a double step
        // BFX
        XCTAssertEqual(enigma.rotors[0].position, 23) // X
        XCTAssertEqual(enigma.rotors[1].position, 5) // F
        XCTAssertEqual(enigma.rotors[2].position, 1) // B
        
        enigma.encode("A")
        
        // Back to doing normal steps
        // BFY
        XCTAssertEqual(enigma.rotors[0].position, 24) // Y
        XCTAssertEqual(enigma.rotors[1].position, 5) // F
        XCTAssertEqual(enigma.rotors[2].position, 1) // B
    }
    
    func testEncodeLowerCase() {
        let expected = "B"
        let result = enigma.encode("a")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeEmoji() {
        let expected = "😀"
        let result = enigma.encode("😀")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeABunchOnNonAlphaChars() {
        let expected = " !?`,.äåö"
        let result = enigma.encode(expected)
        
        XCTAssertEqual(expected, result)
    }
}
