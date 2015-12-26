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
 A patch in the plugboard.
*/
public typealias Patch = (Character, Character)

/**
 Enigma plugboard
*/
public class Plugboard: Component {
    let name = "Plugboard"
    
    /**
     The patches that this plugboard has
     */
    public var patches: [Patch] {
        get {
            return _patches
        }
    }
    
    var _patches: [Patch] = []
    
    /**
     Initializes an empty plugboard
     */
    public init() { }
    
    /**
     Initializes a plugboard with a bunch of patches
     */
    public init(patches: [Patch]) {
        for patch in patches {
            addPatch(patch)
        }
    }
    
    /**
     Adds a patch to the plugboard
     -  returns: Bool indicating if patch was added or not
     - parameter patch: The patch to add
     */
    public func addPatch(patch: Patch) -> Bool {
        // Make sure there are no duplicates
        if let _ = _patches.indexOfPatch(patch) { return false }
        
        // Add patch
        _patches.append(patch)
        _patches.append((patch.1, patch.0))
        
        return true
    }
    
    public func encode(character: Character) -> Character {
        for patch in patches {
            if patch.0 == character {
                return patch.1
            }
        }
        
        return character
    }
    
    public func decode(character: Character) -> Character {
        for patch in patches {
            if patch.1 == character {
                return patch.0
            }
        }
        
        return character
    }
}

extension Array {
    func indexOfPatch(patch: Patch) -> Int? {
        
        for i in 0..<count {
            guard let existingPatch = self[i] as? Patch else { return nil }
            if existingPatch.0 == patch.0 || existingPatch.0 == patch.1 || existingPatch.1 == patch.0 || existingPatch.1 == patch.0 {
                return i
            }
        }
        
        return nil
    }
}
