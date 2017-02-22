//
//  ViewController.swift
//  Vault
//
//  Created by Liam Byrne on 2017-02-03.
//  Copyright © 2017 Liam Byrne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var encryptField: UITextField!
    @IBOutlet weak var decryptField: UITextField!
    @IBOutlet weak var encryptView: UITextView!
    @IBOutlet weak var decryptView: UITextView!
    @IBAction func doEncrypt(_ sender: UIButton) {
        var encryptMessage: String? = encryptField.text
        encryptView.text = encryptMessage
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

