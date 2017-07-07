# 𝕰𝖓𝖎𝖌𝖒𝖆𝕶𝖎𝖙

[![CI Status](http://img.shields.io/travis/mikaoj/EnigmaKit.svg?style=flat)](https://travis-ci.org/mikaoj/EnigmaKit)
[![Version](https://img.shields.io/cocoapods/v/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
[![License](https://img.shields.io/cocoapods/l/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
[![Platform](https://img.shields.io/cocoapods/p/EnigmaKit.svg?style=flat)](http://cocoapods.org/pods/EnigmaKit)
![Alt text](enigma.gif "Enigma")

## 𝖀𝖘𝖆𝖌𝖊
```swift
// Will create an Enigma with an empty plugboard, rotors I, II, III and reflector B (wide).
let enigma = Enigma()
// Will output "ILBDA AMTAZ"
let result = enigma.encode("HELLO WORLD")
```

```swift
let enigma = Enigma()
// "HELLO WORLD"
let result = enigma.decode("ILBDA AMTAZ")
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 𝕮𝖔𝖒𝖕𝖔𝖓𝖊𝖓𝖙𝖘
#### 𝕻𝖑𝖚𝖌𝖇𝖔𝖆𝖗𝖉
```swift
// Create a plugboard and add a patch between A and D
let plugboard = Plugboard()
plugboard.add(("A", "D"))
```
#### 𝕽𝖔𝖙𝖔𝖗
```swift
// III rotor. EnigmaKit comes prebuilt with rotors I-VIII
let rotor = Rotor.III
rotor.setting = 5 // Ringstellung
rotor.position = 6 // Grundstellung

// Or initialize your own
let rotor = Rotor(name: "My custom rotor", wiring: "VZBRGITYUPSDNHLXAWMJQOFECK", notch: "QV")
```
#### 𝕽𝖊𝖋𝖑𝖊𝖈𝖙𝖔𝖗
```swift
// EnigmaKit comes with reflectors A-C (wide) and B-C (thin)
let reflector = Reflector.B

// Or you can create your own reflector
let reflector = Reflector(name: "My custom reflector", wiring: "VZBRGITYUPSDNHLXAWMJQOFECK")
```
#### 𝕰𝖓𝖎𝖌𝖒𝖆
```swift
// Create an enigma with your own plugboard, rotors and reflector of choice
let enigma = Enigma(reflector: Reflector.C, rotors: [Rotor.III, Rotor.IV, Rotor.II], plugboard: Plugboard())
```

## 𝕽𝖊𝖖𝖚𝖎𝖗𝖊𝖒𝖊𝖓𝖙𝖘
Don't mention the war

## 𝕴𝖓𝖘𝖙𝖆𝖑𝖑𝖆𝖙𝖎𝖔𝖓

EnigmaKit is available through [Swift Package Manager](https://swift.org/package-manager/), [CocoaPods](http://cocoapods.org).

## 𝕬𝖚𝖙𝖍𝖔𝖗

Joakim Gyllström, joakim@backslashed.se

## 𝕷𝖎𝖈𝖊𝖓𝖘𝖊

EnigmaKit is available under the MIT license. See the LICENSE file for more info.
