//
//  ViewController.swift
//  test
//
//  Created by Dominic Heaton on 03/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userName: String?
    var passWord: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        userName = usernameField.text!
        passWord = passwordField.text!
        
        if userName! == "admin@test.com" && passWord! == "admin123" {
            Auth.auth().signIn(withEmail: "admin@test.com", password: "admin123")
            self.performSegue(withIdentifier: "toAdmin", sender: nil)
        }
        else {
            logUserIn(userName!, passWord!)
        }
    }

    //function to check username and password against database
    func logUserIn(_ username: String?, _ password: String?) {
        Auth.auth().signIn(withEmail: username!, password: password!) { user, error in
            if error == nil {
                Auth.auth().addStateDidChangeListener() { auth, user in
                    if user != nil {
                        self.performSegue(withIdentifier: "toMenu", sender: nil)
                    }
                }
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "No user account found for that email and password combination. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toRegisterController", sender: nil)
    }

    @IBAction func forgotPassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toForgotPassword", sender: nil)
    }
    
}
