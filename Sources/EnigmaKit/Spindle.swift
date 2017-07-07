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

struct Spindle {
  var reflector: Reflector
  var rotors: [Rotor]

  init(reflector: Reflector, rotors: [Rotor]) {
    self.reflector = reflector
    self.rotors = rotors
  }

  mutating func encode(_ character: Character) -> Character {
    // Make sure character is valid before stepping
    guard Wheel.alphabet.contains(character) else { return character }
    
    step()
    var c = character

    // Go through every rotor
    for rotor in rotors {
      c = rotor.encode(c, direction: .in)
    }

    // Into reflector
    c = reflector.encode(c)

    // And then back out again
    for rotor in rotors.reversed() {
      c = rotor.encode(c, direction: .out)
    }

    return c
  }

  private mutating func step() {
    // Only the 3 first rotors stepped.
    // So in the navy enigma with 4 rotors the last rotor was in a fixed position
    
    // Keep current state of notches before stepping
    let atNotch = rotors.map { $0.isAtNotch }

    // Fast rotor always steps
    rotors[0].step()

    // Middle rotor steps if fast rotor was at a notch
    // Or if middle rotor is at notch
    guard atNotch[0] || atNotch[1] else { return }
    rotors[1].step()

    // Slow rotor steps if middle rotor was at a notch
    guard atNotch[1] else { return }
    rotors[2].step()
  }
}

extension Spindle: Equatable {
  static func ==(lhs: Spindle, rhs: Spindle) -> Bool {
    return lhs.reflector == rhs.reflector && lhs.rotors == rhs.rotors
  }
}
