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

import Foundation

/**
 Enigma machine
*/
public class Enigma {
    /**
     Characters that the enigma can encode
     */
    public static let Alphabet: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    public let plugboard: Plugboard
    public let rotors: [Rotor]
    public let reflector: Reflector
    
    public init() {
        plugboard = Plugboard(patches: [])
        rotors = [Rotor.III, Rotor.II, Rotor.I]
        reflector = Reflector.B
    }
    
    /**
     Set up the enigma with plugboard, rotors and reflector
     */
    public init(plugboard: Plugboard, rotors: [Rotor], reflector: Reflector) {
        self.plugboard = plugboard
        self.rotors = rotors
        self.reflector = reflector
    }
    
    /**
     Encodes a string
     */
    public func encode(string: String) -> String {
        let characters = string.characters
        return String(characters.map { encodeCharacter($0) })
    }
    
    func encodeCharacter(character: Character) -> Character {
        var encoded = character
        
        // Convert to uppercase
        encoded = String(character).uppercaseString.characters.first!
        
        // Check if we have character in our alphabet, otherwise return the original character
        if Enigma.Alphabet.contains(encoded) == false {
            return character
        }
        
        // Increment rotors
        increment(rotors)
        
        // Go through plugboard
        encoded = plugboard.encode(encoded)
        
        // Then rotors
        for rotor in rotors {
            encoded = rotor.encode(encoded)
        }
        
        // Reflector
        encoded = reflector.encode(encoded)
        
        // Back through rotors
        for rotor in rotors.reverse() {
            encoded = rotor.decode(encoded)
        }
        
        // Plugboard
        encoded = plugboard.decode(encoded)
        
        // Done
        return encoded
    }
    
    func increment(rotors: [Rotor]) {
        var incrementNext: Bool = true
        for rotor in rotors {
            // If there are notches at the current position, increment next
            let character = Enigma.Alphabet[rotor.position]
            let atNotch = rotor.notches.contains(character)
            
            // Increment position for this rotor if previous rotor told us to do so
            // Or if we are at a notch (double step)
            var newPosition = rotor.position
            if incrementNext || atNotch {
                newPosition = rotor.position + 1
            }
            
            // Set new position
            rotor.position = newPosition
            incrementNext = atNotch
        }
    }
}
