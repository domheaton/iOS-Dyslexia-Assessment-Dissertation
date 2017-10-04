//
//  ViewController.swift
//  test
//
//  Created by Dominic Heaton on 03/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    var refDatabase: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FirebaseApp.configure()
        refDatabase = Database.database().reference().child("Logins");
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
    var queriedUsername: String?
    
    @IBAction func enterButton(_ sender: UIButton) {
        userName = usernameField.text!
        passWord = passwordField.text!
        
        //For debugging
        print(userName!)
        print(passWord!)
        
        checkLogins()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        userName = usernameField.text!
        passWord = passwordField.text!
        
        //For debugging
        print(userName!)
        print(passWord!)
        
        //call registration function
        addUsername()
    }
    
    //function to add username and password to the database
    func addUsername() {
        let key = refDatabase.childByAutoId().key
        
        let logins = ["id":key, "username":userName! as String, "password":passWord! as String]
        
        refDatabase.child(key).setValue(logins)
    }
    
    func checkLogins() {
        //function to verify login credentials against the database
    }
    
}

