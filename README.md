# EnigmaKit

[![CI Status](http://img.shields.io/travis/mikaoj/EnigmaKit.svg?style=flat)](https://travis-ci.org/mikaoj/EnigmaKit)
[![Version](https://img.shields.io/cocoapods/v/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
[![License](https://img.shields.io/cocoapods/l/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
[![Platform](https://img.shields.io/cocoapods/p/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
![Alt text](enigma.gif "Enigma")

## Usage
```swift
let enigma = Enigma() // Will create an Enigma with an empty plugboard, rotors I, II, III and reflector B (wide).
let result = enigma.encode("Hello world")
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### Plugboard
```swift
// Create a plugboard and add a patch between A and D
let plugboard = Plugboard()
plugboard.addPatch(("A", "D"))
```
#### Rotor
```swift
// III rotor
let rotor = Rotor.III
rotor.setting = 5 // Internal ring position
rotor.position = 6 // Outer ring position
```
#### Reflector
```swift
let rotor = Reflector.B
```
#### Enigma
```swift
// Create an enigma with your own plugboard, rotors and reflector of choice
let enigma = Enigma(plugboard: Plugboard(), rotors: [Rotor.III, Rotor.IV, Rotor.II], reflector: Reflector.C)
```

## Requirements
Don't mention the war

## Installation

EnigmaKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EnigmaKit"
```

## Author

Joakim Gyllström, joakim@backslashed.se

## License

EnigmaKit is available under the MIT license. See the LICENSE file for more info.
