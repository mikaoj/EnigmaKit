// The MIT License (MIT)
//
// Copyright (c) 2017 Joakim Gyllström
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

import Foundation

/// A substitution cipher wheel
struct Wheel {
  enum Error: Swift.Error {
    case missmatchingAlphabets
    case invalidSetting
  }

  static var alphabet: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  var inner: [Character]
  var outer: [Character]
  var setting: Int

  init(inner: [Character], outer: [Character] = Wheel.alphabet, setting: Int = 0) throws {
    // Make sure we have the same number of characters in inner and outer rings.
    guard inner.count == outer.count else { throw Error.missmatchingAlphabets }

    // Validate setting
    guard setting >= 0 && setting < inner.count else { throw Error.invalidSetting }
    
    self.inner = inner
    self.outer = outer
    self.setting = setting
  }
}

extension Wheel: Equatable {
  static func ==(lhs: Wheel, rhs: Wheel) -> Bool {
    return lhs.inner == rhs.inner && lhs.outer == rhs.outer && lhs.setting == rhs.setting
  }
}

extension Wheel {
  func encode(_ character: Character) -> Character {
    // Get index of character
    guard let index = outer.firstIndex(of: character) else { return character }

    // Return character from inner with offseted index. Make sure not to go over bounds
    return inner[wrap: index + setting]
  }

  func decode(_ character: Character) -> Character {
    // Get index of character
    guard let index = inner.firstIndex(of: character) else { return character }

    // Return character from inner with offseted index. Make sure not to go under bounds
    return outer[wrap: index - setting]
  }
}
