//
//  About.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CryptoSwift

class About: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func button(_ sender: UIButton) {
        label.text = textField.text!.sha512()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dismiss keyboard when in textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

