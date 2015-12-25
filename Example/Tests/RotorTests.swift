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

class RotorTests: XCTestCase {
    
    var rotor: Rotor!

    override func setUp() {
        super.setUp()
        
        rotor = Rotor.I
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncodeWithAPositionAndASetting() {
        let expected: Character = "E"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeWithBPositionAndASetting() {
        rotor.position = 1
        
        let expected: Character = "J"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeWithDPositionAndASetting() {
        rotor.position = 3
        
        let expected: Character = "C"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeWithCOverflowPositionAndASetting() {
        rotor.position = 6
        
        let expected: Character = "X"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeWithAPositionAndBSetting() {
        rotor.setting = 1
        
        let expected: Character = "K"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testEncodeWithBPositionAndBSetting() {
        rotor.position = 1
        rotor.setting = 1
        
        let expected: Character = "E"
        let result = rotor.encode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testDecodeWithAPositionAndASetting() {
        let expected: Character = "U"
        let result = rotor.decode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testDecodeWithBPositionAndASetting() {
        rotor.position = 1
        
        let expected: Character = "V"
        let result = rotor.decode("A")
        
        XCTAssertEqual(expected, result)
    }
    
    func testDecodeWithBPositionAndBSetting() {
        rotor.position = 1
        rotor.setting = 1
        
        let expected: Character = "U"
        let result = rotor.decode("A")
        
        XCTAssertEqual(expected, result)
    }
}
