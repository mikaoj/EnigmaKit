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
Enigma rotor
*/
public class Rotor: Component {
    let name: String
    let wiring: [Character]
    
    let notches: [Character]
    
    public var position: Int = 0 {
        didSet {
            // Make sure that we are within 0-25
            if position < 0 {
                position = Enigma.Alphabet.count - position
            } else if position != position % Enigma.Alphabet.count {
                position = position % Enigma.Alphabet.count
            }
        }
    }
    public var setting: Int = 0
    
    public init(name: String, wirings: [Character], notches: [Character]) {
        // Make sure that we have the same number of characters in inner and outer
        if Enigma.Alphabet.count != wirings.count { fatalError("Inner and outer ring should have the same number of character") }
        
        self.name = name
        self.wiring = wirings
        self.notches = notches
    }
    
    public func encode(character: Character) -> Character {
        guard Enigma.Alphabet.contains(character) else { return character }
        
        // Index for input
        let inputIndex = (Enigma.Alphabet.indexOf(character)! + position + Enigma.Alphabet.count - setting) % Enigma.Alphabet.count
        
        // Get internal character for that index
        let encoded = wiring[inputIndex]
        
        // Find the output index for that character
        let outputIndex = (Enigma.Alphabet.indexOf(encoded)! + (Enigma.Alphabet.count - position + setting)) % Enigma.Alphabet.count
        
        // And return character at that index
        return Enigma.Alphabet[outputIndex]
    }
    
    public func decode(character: Character) -> Character {
        guard Enigma.Alphabet.contains(character) else { return character }
        
        // Index for input
        let inputIndex = (Enigma.Alphabet.indexOf(character)! + position + Enigma.Alphabet.count - setting) % Enigma.Alphabet.count
        
        // Get character for that index
        let encoded = Enigma.Alphabet[inputIndex]
        
        let innerIndex = wiring.indexOf(encoded)!
        let innerCharacter = Enigma.Alphabet[innerIndex]
        
        let outerIndex = (Enigma.Alphabet.indexOf(innerCharacter)! + (Enigma.Alphabet.count - position + setting)) % Enigma.Alphabet.count
        
        return Enigma.Alphabet[outerIndex]
    }
}

public extension Rotor {
    // Convenience initializer
    public convenience init(name: String, wiring: String, notch: String) {
        self.init(name: name, wirings: Array(wiring.characters), notches: Array(notch.characters))
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
