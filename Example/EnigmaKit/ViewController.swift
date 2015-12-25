//
//  ViewController.swift
//  EnigmaKit
//
//  Created by Joakim Gyllstrom on 12/25/2015.
//  Copyright (c) 2015 Joakim Gyllstrom. All rights reserved.
//

import UIKit
import EnigmaKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let enigma = Enigma()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleButtonPressed(sender: UIButton) {
        if let text = textField.text {
            label.text = enigma.encode(text)
        } else {
            label.text = ""
        }
    }
}

