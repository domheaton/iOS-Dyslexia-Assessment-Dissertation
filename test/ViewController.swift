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
    //@IBOutlet weak var logStatus: UILabel!
    
    var userName: String?
    var passWord: String?
    
    @IBAction func enterButton(_ sender: UIButton) {
        userName = usernameField.text!
        passWord = passwordField.text!
        
        //For debugging
            print(userName!)
            print(passWord!)
        
        logUserIn()
    }
    
    //function to verify login credentials against the database
    func logUserIn() {
        
        Auth.auth().signIn(withEmail: userName!, password: passWord!)
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toMenuController", sender: nil)
            }
            else if user == nil {
                let alertController = UIAlertController(title: "Error", message: "No user account found for that email and password combination. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toRegisterController", sender: nil)
    }
    
    //function for forgotten password recovery email
    @IBAction func forgotPassword(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: usernameField.text!) { error in
            if error != nil
            {
                //For Debugging
                    print("Error - Email not found")
            }
            else
            {
                //For Debugging
                    print("Success - Sent recovery email")
                
                let alertController = UIAlertController(title: "Forgotten Password", message:
                    "A recovery email has been sent to the entered email address", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
