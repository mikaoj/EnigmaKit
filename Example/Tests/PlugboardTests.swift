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

class PlugboardTests: XCTestCase {
    // If there are no patches. Output should be the same as input
    func testEmptyPlugboard() {
        let plugboard = Plugboard(patches: [])
        
        let input: [Character] = ["A", "B", "D"]
        let output = input.map { (character) -> Character in
            return plugboard.encode(character)
        }
        
        XCTAssertEqual(input, output)
    }
    
    // A<->K patch. A should be switched for K when encoding. And K for A
    func testAPatchEncode() {
        let plugboard = Plugboard(patches: [("A", "K")])
        
        let input: [Character] = ["A", "B", "D", "K"]
        let expected: [Character] = ["K", "B", "D", "A"]
        let output = input.map { (character) -> Character in
            return plugboard.encode(character)
        }
        
        XCTAssertEqual(expected, output)
    }
    
    // A<->K patch. K should be switched for A when decoding. And A for K
    func testAPatchDecode() {
        let plugboard = Plugboard(patches: [("A", "K")])
        
        let input: [Character] = ["K", "B", "D", "A"]
        let expected: [Character] = ["A", "B", "D", "K"]
        
        let output = input.map { (character) -> Character in
            return plugboard.decode(character)
        }
        
        XCTAssertEqual(expected, output)
    }
    
    func testAddPatch() {
        let plugboard = Plugboard()
        let patch: Patch = ("A", "B")
        
        XCTAssert(plugboard.addPatch(patch))
    }
    
    func testAddDuplicatePatch() {
        let plugboard = Plugboard()
        let patch: Patch = ("A", "B")
        let otherPatch: Patch = ("B", "Z")
        
        XCTAssert(plugboard.addPatch(patch))
        XCTAssert(plugboard.addPatch(otherPatch) == false)
    }
}
