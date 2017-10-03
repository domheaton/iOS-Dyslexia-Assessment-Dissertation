//
//  ViewController.swift
//  test
//
//  Created by Dominic Heaton on 03/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logStatus: UILabel!
    
    var userName: String?
    var passWord: String?
    
    @IBAction func enterButton(_ sender: UIButton) {
        
        userName = usernameField.text!
        passWord = passwordField.text!
        
        print(userName!)
        print(passWord!)
        
        if(userName! == "dhh1g15" && passWord! == "1234567") {
            logStatus.text! = "Logged In"
        }
        else {
            logStatus.text! = "Logged Out"
        }
    }
    
}

