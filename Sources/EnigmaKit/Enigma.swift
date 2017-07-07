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

/// Enigma machine simulator
public class Enigma {
  private var spindle: Spindle
  /// Plugboard
  private(set) public var plugboard: Plugboard

  /// Initializes enigma machine with given reflector, rotors and plugboard
  ///
  /// - Parameters:
  ///   - reflector: Reflector to use
  ///   - rotors: Rotors to use
  ///   - plugboard: Plugboard to use
  public init(reflector: Reflector = Reflector.B, rotors: [Rotor] = [Rotor.III, Rotor.II, Rotor.I], plugboard: Plugboard = Plugboard()) {
    self.spindle = Spindle(reflector: reflector, rotors: rotors)
    self.plugboard = plugboard
  }

  /// Encodes with enigma cipher
  ///
  /// - Parameter input: The string to encode
  /// - Returns: Encoded string
  public func encode(_ input: String) -> String {
    return String(input.uppercased().map {
      encode(character: $0)
    })
  }

  /// Encode character
  ///
  /// - Parameter char: character to encode
  /// - Returns: encoded character
  private func encode(character char: Character) -> Character {
    // Through the plugboard, into all the rotors and reflector and then back through plugboard again
    return plugboard.encode(spindle.encode(plugboard.encode(char)))
  }
}

extension Enigma {
  /// Rotors
  public var rotors: [Rotor] {
    return spindle.rotors
  }

  /// Reflector
  public var reflector: Reflector {
    return spindle.reflector
  }
}
