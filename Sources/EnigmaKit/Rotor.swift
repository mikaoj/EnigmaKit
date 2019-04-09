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

public struct Rotor {
  enum Direction {
    case `in`
    case out
  }
  
  public var name: String
  public var notches: [Character]
  public var position: Int
  public var setting: Int {
    get {
      return wheel.setting
    }
    set {
      wheel.setting = newValue
    }
  }
  var wheel: Wheel

  public init(name: String, wiring: [Character], notch: [Character], position: Int = 0, setting: Int = 0) {
    self.name = name
    self.notches = notch
    self.wheel = try! Wheel(inner: wiring, setting: setting)
    self.position = position
  }

  mutating func step() {
    position += 1

    // Reset to if we go out of bounds
    if position >= wheel.outer.count {
      position = 0
    }
  }

  public var isAtNotch: Bool {
    return notches.contains(wheel.outer[position])
  }
}

extension Rotor {
  func encode(_ character: Character, direction: Direction) -> Character {
    switch direction {
    case .in:
      return code(character, coder: wheel.encode)
    case .out:
      return code(character, coder: wheel.decode)
    }
  }

  private func code(_ character: Character, coder: (Character) -> Character) -> Character {
    // Get index of character
    guard let inputIndex = wheel.outer.firstIndex(of: character) else { return character }

    // Encode character at that index + offset
    let c = coder(wheel.outer[wrap: inputIndex + position])

    // Get index of encoded character
    guard let outputIndex = wheel.outer.firstIndex(of: c) else { return character }

    // Aaand return character at that index - offset
    return wheel.outer[wrap: outputIndex - position]
  }
}

extension Rotor: Equatable {
  public static func ==(lhs: Rotor, rhs: Rotor) -> Bool {
    return lhs.name == rhs.name && lhs.notches == rhs.notches && lhs.position == rhs.position && lhs.wheel == rhs.wheel
  }
}

extension Rotor {
  // Convenience initializer
  public init(name: String, wiring: String, notch: String) {
    self.init(name: name, wiring: Array(wiring), notch: Array(notch))
  }

  public static var I: Rotor {
    return Rotor(name: "I", wiring: "EKMFLGDQVZNTOWYHXUSPAIBRCJ", notch: "Q")
  }

  public static var II: Rotor {
    return Rotor(name: "II", wiring: "AJDKSIRUXBLHWTMCQGZNPYFVOE", notch: "E")
  }

  public static var III: Rotor {
    return Rotor(name: "III", wiring: "BDFHJLCPRTXVZNYEIWGAKMUSQO", notch: "V")
  }

  public static var IV: Rotor {
    return Rotor(name: "IV", wiring: "ESOVPZJAYQUIRHXLNFTGKDCMWB", notch: "J")
  }

  public static var V: Rotor {
    return Rotor(name: "V", wiring: "VZBRGITYUPSDNHLXAWMJQOFECK", notch: "Z")
  }

  public static var VI: Rotor {
    return Rotor(name: "VI", wiring: "JPGVOUMFYQBENHZRDKASXLICTW", notch: "ZM")
  }

  public static var VII: Rotor {
    return Rotor(name: "VII", wiring: "NZJHGRCXMYSWBOUFAIVLPEKQDT", notch: "ZM")
  }

  public static var VIII: Rotor {
    return Rotor(name: "VIII", wiring: "FKQHTLXOCBJSPDZRAMEWNIUYGV", notch: "ZM")
  }
}
