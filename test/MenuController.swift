//
//  MenuController.swift
//  test
//
//  Created by Dominic Heaton on 09/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MenuController: UIViewController {
    
    @IBOutlet weak var accountName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getCredentials()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Gets the accounts details from Firebase -- CRASHES ON PASSWORD RESET
//    func getCredentials() {
//        accountName.text! = (Auth.auth().currentUser?.email!)!
//    }
    
    //Sign Out Button
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "signOut", sender: nil)
    }
    
}

