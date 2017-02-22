//
//  ViewController.swift
//  Vault
//
//  Created by Liam Byrne on 2017-02-03.
//  Copyright © 2017 Liam Byrne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var original = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var cipher = ["X","Y","Z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W"]
    var count = 0
    var letterCount = 0

    // MARK: Properties
    @IBOutlet weak var encryptField: UITextField!
    @IBOutlet weak var decryptField: UITextField!
    @IBOutlet weak var encryptView: UITextView!
    @IBOutlet weak var decryptView: UITextView!
    @IBAction func doEncrypt(_ sender: UIButton) {
        var encryptMessage: String? = encryptField.text
        encryptMessage = encryptMessage?.uppercased()
        encryptView.text = encryptMessage
        let messageCount : Int = (encryptMessage?.characters.count)!
        var arrayMessage = encryptMessage?.characters.map { String($0) }
        count = 0
        letterCount = 0
        while count < messageCount {
            while letterCount < 26 {
                print(letterCount)
                print(count)
                if arrayMessage?[count] == original[letterCount] {
                    arrayMessage?[count] = cipher[letterCount]
                }
                letterCount += 1
            }
            letterCount = 0
            count += 1
        }
        let arrayMessageString = arrayMessage?.joined(separator: "")
        encryptView.text = arrayMessageString
        
    }
    @IBAction func doDecrypt(_ sender: UIButton) {
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

