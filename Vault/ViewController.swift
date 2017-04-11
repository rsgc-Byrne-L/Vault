//
//  ViewController.swift
//  Vault
//
//  Created by Liam Byrne on 2017-02-03.
//  Copyright © 2017 Liam Byrne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Declare arrays that contain the alphabet, will be used to check the message for various ciphers
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
    @IBOutlet weak var vigenereKeyView: UITextView!
    @IBOutlet weak var encryptField: UITextField!
    @IBOutlet weak var decryptField: UITextField!
    @IBOutlet weak var encryptView: UITextView!
    @IBOutlet weak var decryptView: UITextView!
    @IBOutlet weak var caesarHelpView: UITextView!
    @IBOutlet weak var vigenereHelpView: UITextView!
    @IBOutlet weak var vigenereEncryptField: UITextField!
    @IBOutlet weak var vigenereDecryptField: UITextField!
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
        // Grab user input and uppercase it
        var decryptMessage: String? = decryptField.text
        decryptMessage = decryptMessage?.uppercased()
        let messageCount : Int = (decryptMessage?.characters.count)!
        // Put the message in an array
        var arrayMessage = decryptMessage?.characters.map { String($0) }
        count = 0
        letterCount = 0
        // Loop over messageCount (length of message)
        while count < messageCount {
            // Loop over the alphabet
            while letterCount < 26 {
                // If the letter is the same as the letter in the cipher
                if arrayMessage?[count] == cipher[letterCount] {
                    // Set the letter to another letter (shifted 3)
                    arrayMessage?[count] = original[letterCount]
                    letterCount = 26
                } else {
                    letterCount += 1
                }
            }
            letterCount = 0
            count += 1
        }
        // Return the array into string
        let arrayMessageString = arrayMessage?.joined(separator: "")
        // Display the encrypted message
        decryptView.text = arrayMessageString
        
    }
    // Function to encrypt using caesar vigenere when clicked
    @IBAction func vigenereEncrypt(_ sender: UIButton) {
        // Variable to help check if string is composed of numbers
        let numberCharacters = NSCharacterSet.decimalDigits
        // Check if number is numbers
        if vigenereEncryptField.text?.rangeOfCharacter(from: numberCharacters) != nil {
            // If there are numbers, display this alert
            let alert = UIAlertController(title: "Whoops!", message: "Message can't include numbers!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            // If not, run normally
        var plainText = vigenereEncryptField.text
        plainText = plainText?.uppercased()
            // Get the count (generate the key)
        var key = self.key(count: (plainText?.characters.count)!)
            // Put the plainText into an array
        var arrayMessage = plainText?.characters.map { String($0) }
        var output = String()
            // Get length of the key (and text)
        var textCount = key.count
        var letterTrack = 0
        var i = 0
        var k = 0
        
            // Count over the message/key length
        while i < textCount {
            // Check if there is a space, if there is, add space to the final output
            if arrayMessage?[i] == " " {
                output.append(" ")
                letterTrack = 0
                i += 1
                // If no space...
            } else {
                // Loop over the message and check if it equal to each letter in the alphabet, if not add one to letterCount and keep checking
                while arrayMessage?[i] != alphabet[letterTrack] {
                    letterTrack += 1
                }
                // After finding where the letter lies, add how ever much the key is
                while k <= key[i] {
                    letterTrack += 1
                    // Make sure that it doesnt go over the amount of letters in the alphabet
                    if letterTrack > 26 {
                        letterTrack = 0
                    }
                    k += 1
                }
                k = 0
                // Add the letter into the output
                output.append(alphabet[letterTrack])
                letterTrack = 0
                i += 1
            }
        }
        
            // Return the array into a string
        let arrayKeyString = key.flatMap { String($0) }
        let arrayKeyStringF = arrayKeyString.joined(separator: "")
        
            // Display the generated key
        vigenereKeyView.text = arrayKeyStringF
            // Display the final output
        vigenereEncryptView.text = output
        }
    }
    @IBAction func vigenereDecrypt(_ sender: UIButton) {
        // If the input is an int, continue, if else, display alert
        // Variable to help check if string is composed of numbers
        let numberCharacters = NSCharacterSet.decimalDigits
        // Check if number is numbers
        if vigenereDecryptField.text?.rangeOfCharacter(from: numberCharacters) != nil {
            let alert = UIAlertController(title: "Whoops!", message: "Message must not have numbers!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
        if let _ = Int(vigenereKeyDField.text!) {
            if (vigenereKeyDField.text?.characters.count)! > (vigenereDecryptField.text?.characters.count)! {
                let alert = UIAlertController(title: "Whoops!", message: "Key length must be shorter or equal to length of message!", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            } else {
            var cipherText = vigenereDecryptField.text
            cipherText = cipherText?.uppercased()
            var keyString = vigenereKeyDField.text
            var key = [Int]()
            for element in (keyString?.characters)!
            {
                key.append(Int(String(element))!)
            }
            var arrayMessage = cipherText?.characters.map { String($0) }
            var output = String()
            var textCount = key.count
            var letterTrack = 0
            var i = 0
            var k = 0
            
            while i < textCount {
                if arrayMessage?[i] == " " {
                    output.append(" ")
                    letterTrack = 0
                    i += 1
                } else {
                    while arrayMessage?[i] != alphabet[letterTrack] {
                        letterTrack += 1
                    }
                    while k <= key[i] {
                        letterTrack -= 1
                        if letterTrack <= 0 {
                            letterTrack = 25
                        }
                        k += 1
                    }
                    k = 0
                    output.append(alphabet[letterTrack])
                    letterTrack = 0
                    i += 1
                }
            }
            
            vigenereDecryptView.text = output
            }
        } else {
            let alert = UIAlertController(title: "Whoops!", message: "Key must be composed of numbers!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)

    }
        }
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
    @IBAction func vigenereTransterMessage(_ sender: UIButton) {
        vigenereKeyDField.text = vigenereKeyView.text
        vigenereDecryptField.text = vigenereEncryptView.text
    }
    @IBAction func vigenereEncryptClear(_ sender: UIButton) {
        vigenereEncryptField.text = ""
        vigenereEncryptView.text = ""
        vigenereKeyView.text = ""
    }
    @IBAction func vigenereDecryptClear(_ sender: UIButton) {
        vigenereDecryptField.text = ""
        vigenereKeyDField.text = ""
        vigenereDecryptView.text = ""
    }
    @IBAction func vigenereClearAll(_ sender: UIButton) {
        vigenereEncryptField.text = ""
        vigenereEncryptView.text = ""
        vigenereKeyView.text = ""
        vigenereDecryptField.text = ""
        vigenereKeyDField.text = ""
        vigenereDecryptView.text = ""
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
    // Back button for switching back and forth for help tabs
    @IBAction func vigenereHelpBack(_ sender: UIButton) {
        vigenereHelpView.text = "A much more secure encryption method compared to Caesar cipher. It begins by creating a random key with the same length as the message."
    }
    // Next button for switching back and forth for help tabs
    @IBAction func vigenereHelpNext(_ sender: UIButton) {
        vigenereHelpView.text = "It then takes each letter from the message and combines it with each number in the key. For example, the message 'hello' with a key of '62957' would turn into 'OHVRW'."
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

