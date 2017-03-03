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
    var count2 = 0
    var check = false
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
    @IBOutlet weak var vigenereEncryptField: UITextField!
    @IBOutlet weak var vigenereDecryptField: UITextField!
    @IBOutlet weak var vigenereKeyField: UITextField!
    @IBOutlet weak var vigenereKeyDField: UITextField!
    @IBOutlet weak var vigenereEncryptView: UITextView!
    @IBOutlet weak var vigenereDecryptView: UITextView!
    
    @IBAction func vigenereEncrypt(_ sender: UIButton) {
        var messageTrack = 0
        var keyTrack = 0
        var encryptTrack = 0
        var output = [String]()

        // Get the text from the textfield if there is any
        guard let vigenereKey = vigenereKeyField.text?.uppercased() else {
            return
        }
        
        guard let vigenereEncryptMessage = vigenereEncryptField.text?.uppercased() else {
            return
        }
        
        // Get the length of the message
        let messageCount : Int = vigenereEncryptMessage.characters.count
        
        // Convert the message into an array of Characters
        var arrayMessage = vigenereEncryptMessage.characters.map { String($0)}

        // Get the length of the key
        let keyCount : Int = vigenereKey.characters.count
        
        // Convert the key into an array of Characters
        var arrayKey = vigenereKey.characters.map { String($0)}
        
        if keyCount < messageCount {
            count2 = keyCount
            count = 0
            while count2 < messageCount {
                arrayKey.append(arrayKey[count])
                count2 += 1
                count += 1
            }
        } else if keyCount > messageCount {
            count = keyCount
            while count > messageCount {
                arrayKey.remove(at: (count-1))
                count -= 1
            }
        }
        
        count = 0
        while count < messageCount {
            check = false
            while letterCount < 26 {
                if arrayMessage[count] == " " {
                    letterCount = 26
                    check = true
                    output.append(" ")
                } else {
                if arrayMessage[count] == original[letterCount] {
                    messageTrack = letterCount
                }
                if arrayKey[count] == original[letterCount] {
                    keyTrack = letterCount
                }
                if messageTrack != 0 && keyTrack != 0 {
                    encryptTrack = messageTrack + keyTrack
                    encryptTrack = encryptTrack % 25
                }
                letterCount += 1
                }
            }
            if check != true {
            output.append(original[encryptTrack])
            }
            letterCount = 0
            count += 1
            
        let outputString = output.joined(separator: "")
        vigenereEncryptView.text = outputString
        }
    }
    @IBAction func transferMessage(_ sender: UIButton) {
        decryptField.text = encryptView.text
    }
    
    @IBAction func clearEncrypt(_ sender: UIButton) {
        encryptField.text = ""
        encryptView.text = ""
    }
    @IBAction func clearDecrypt(_ sender: UIButton) {
        decryptField.text = ""
        decryptView.text = ""
    }
    @IBAction func clearAll(_ sender: UIButton) {
        encryptField.text = ""
        encryptView.text = ""
        decryptField.text = ""
        decryptView.text = ""
    }
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
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

