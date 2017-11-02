//
//  Menu.swift
//  test
//
//  Created by Dominic Heaton on 22/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Menu: UIViewController {
    
    var finalResultsSWE = Double()
    var finalResultsPDE = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //override the back button in the navigation controller
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(self.signOut(sender:)))
        
        saveResults()
    }
    
    func saveResults() {
        var refDatabase: DatabaseReference!
        refDatabase = Database.database().reference().child("results").child("user")

        let userName = Auth.auth().currentUser?.email
        let key = refDatabase.childByAutoId().key
        let userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE] as [String : Any]
        refDatabase.child(key).setValue(userResults)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signOut(sender: AnyObject) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "signOut", sender: nil)
    }
    
}

