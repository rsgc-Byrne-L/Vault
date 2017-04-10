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
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    // Declare array that contains the cipher, which is a shift of 3 from original, will be used to encrypt the message
    var cipher = ["X","Y","Z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W"]
    // Declare variables to use for counting
    var count = 0
    var count2 = 0
    var answer = ""
    var check = false
    var letterCount = 0
    
    // MARK: Properties
    @IBOutlet weak var encryptField: UITextField!
    @IBOutlet weak var decryptField: UITextField!
    @IBOutlet weak var encryptView: UITextView!
    @IBOutlet weak var decryptView: UITextView!
    @IBOutlet weak var caesarHelpView: UITextView!
    @IBOutlet weak var vigenereEncryptField: UITextField!
    @IBOutlet weak var vigenereDecryptField: UITextField!
    @IBOutlet weak var vigenereKeyField: UITextField!
    @IBOutlet weak var vigenereKeyDField: UITextField!
    @IBOutlet weak var vigenereEncryptView: UITextView!
    @IBOutlet weak var vigenereDecryptView: UITextView!
    // Function to encrypt using caesar cipher when clicked
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
    // Function to decrypt using caesar cipher when clicked
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
    // Function to encrypt using caesar vigenere when clicked
    @IBAction func vigenereEncrypt(_ sender: UIButton) {
        var plainText = vigenereEncryptField.text
        plainText = plainText?.uppercased()
        let key = self.key(count: (plainText?.characters.count)!)
        var arrayMessage = plainText?.characters.map { String($0) }
        var output = String()
        var textCount = key.count
        var letterTrack = 0
        var i = 0
        var k = 0
        
        while i < textCount {
            while arrayMessage?[i] != alphabet[letterTrack] {
                letterTrack += 1
            }
            while k <= key[i] {
            letterTrack += 1
            if letterTrack > 25 {
                letterTrack = 0
            }
                k += 1
            }
            k = 0
            output.append(alphabet[letterTrack-1])
            letterTrack = 0
            i += 1
        }
        
        print("output = \(output)")
        
        let arrayKeyString = key.flatMap { String($0) }
        let arrayKeyStringF = arrayKeyString.joined(separator: "")
        
        vigenereKeyField.text = arrayKeyStringF
        vigenereEncryptView.text = output
    }
    @IBAction func vigenereDecrypt(_ sender: UIButton) {
        
    }
    @IBAction func transferMessage(_ sender: UIButton) {
        decryptField.text = encryptView.text
    }
    // Clears fields and views for both caesar and vigenere cipher (only encrypt)
    @IBAction func clearEncrypt(_ sender: UIButton) {
        encryptField.text = ""
        encryptView.text = ""
    }
    // Clears fields and views for both caesar and vigenere cipher (only decrypt)
    @IBAction func clearDecrypt(_ sender: UIButton) {
        decryptField.text = ""
        decryptView.text = ""
    }
    // Clears fields and views for both caesar and vigenere cipher (both)
    @IBAction func clearAll(_ sender: UIButton) {
        encryptField.text = ""
        encryptView.text = ""
        decryptField.text = ""
        decryptView.text = ""
    }
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    // Back button for switching back and forth for help tabs
    @IBAction func caesarHelpBack(_ sender: UIButton) {
        caesarHelpView.text = "Known as one of the simplest encryption methods, Caesar Cipher simply takes each letter and shifts them a certain number of letters (in this case 3)."
    }
    // Next button for switching back and forth for help tabs
    @IBAction func caesarHelpNext(_ sender: UIButton) {
        caesarHelpView.text = "For example, the message: 'Hello friend!' would encrypt into 'EBIIL COFBKA!'. As you can see, each letter is first uppercased, and then shifted back by 3."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func key (count: Int) -> [Int] {
        var key = [Int]()
        
        for _ in 0..<count {
            key.append(Int(arc4random() % 10))
        }
        
        return key
    }
    
    func map() -> (forward: [String : Int], reversed: [Int : String], lastCharacterIndex: Int)
    {
        var forward = [String : Int]()
        var reversed = [Int : String]()
        var lastCharacterIndex = 0
        
        for (index, letter) in self.alphabet.enumerated() {
            forward[letter] = index
            reversed[index] = letter
            lastCharacterIndex = index
        }
        
        return (forward: forward, reversed: reversed, lastCharacterIndex: lastCharacterIndex)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

