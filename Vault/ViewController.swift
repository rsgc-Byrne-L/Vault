//
//  ViewController.swift
//  Vault
//
//  Created by Liam Byrne on 2017-02-03.
//  Copyright © 2017 Liam Byrne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Declare array that contains the alphabet, will be used to check the message
    var original = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    // Declare array that contains the cipher, which is a shift of 3 from original, will be used to encrypt the message
    var cipher = ["X","Y","Z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W"]
    // Declare variables to use for counting
    var count = 0
    var letterCount = 0

    // MARK: Properties
    @IBOutlet weak var encryptField: UITextField!
    @IBOutlet weak var decryptField: UITextField!
    @IBOutlet weak var encryptView: UITextView!
    @IBOutlet weak var decryptView: UITextView!
    @IBAction func doEncrypt(_ sender: UIButton) {
        // Take user's input
        var encryptMessage: String? = encryptField.text
        // Change user's input to all uppercase
        encryptMessage = encryptMessage?.uppercased()
        // Store user's message length
        let messageCount : Int = (encryptMessage?.characters.count)!
        // Declare array that stores each character of message
        var arrayMessage = encryptMessage?.characters.map { String($0) }
        // Reset counting variables
        count = 0
        letterCount = 0
        // Loop over the string
        while count < messageCount {
            // Loop over the alphabet
            while letterCount < 26 {
                if arrayMessage?[count] == original[letterCount] {
                    arrayMessage?[count] = cipher[letterCount]
                    letterCount = 26
                } else {
                letterCount += 1
            }
            }
            letterCount = 0
            count += 1
        }
        // Turn array back into string
        let arrayMessageString = arrayMessage?.joined(separator: "")
        // Display user's message
        encryptView.text = arrayMessageString
        
    }
    @IBAction func doDecrypt(_ sender: UIButton) {
        var decryptMessage: String? = decryptField.text
        decryptMessage = decryptMessage?.uppercased()
        let messageCount : Int = (decryptMessage?.characters.count)!
        var arrayMessage = decryptMessage?.characters.map { String($0) }
        count = 0
        letterCount = 0
        while count < messageCount {
            while letterCount < 26 {
                if arrayMessage?[count] == cipher[letterCount] {
                    arrayMessage?[count] = original[letterCount]
                    letterCount = 26
                } else {
                    letterCount += 1
                }
            }
            letterCount = 0
            count += 1
        }
        let arrayMessageString = arrayMessage?.joined(separator: "")
        decryptView.text = arrayMessageString
        
    }
    @IBAction func transferMessage(_ sender: UIButton) {
        decryptField.text = encryptView.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

