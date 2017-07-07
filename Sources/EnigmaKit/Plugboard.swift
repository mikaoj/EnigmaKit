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

public struct Plugboard {
  public typealias Patch = (Character, Character)

  private(set) public var patches: [Character: Character]

  public init(_ patches: [Character: Character] = [:]) {
    self.patches = patches
  }

 @discardableResult public mutating func add(_ patch: Patch) -> Bool {
    // Make sure characters are unique
    guard patch.0 != patch.1 else { return false }
    
    // Make sure that there are no patches using those characters
    guard patches[patch.0] == nil && patches[patch.1] == nil else { return false }

    patches[patch.0] = patch.1
    patches[patch.1] = patch.0

    return true
  }

 @discardableResult public mutating func remove(_ patch: Patch) -> Bool {
    // Make sure we have that patch
    guard patches[patch.0] == patch.1 && patches[patch.1] == patch.0 else { return false }

    patches[patch.0] = nil
    patches[patch.1] = nil

    return true
  }
}

extension Plugboard {
  func encode(_ character: Character) -> Character {
    return patches[character] ?? character
  }
}

extension Plugboard: Equatable {
  public static func ==(lhs: Plugboard, rhs: Plugboard) -> Bool {
    return lhs.patches == rhs.patches
  }
}
