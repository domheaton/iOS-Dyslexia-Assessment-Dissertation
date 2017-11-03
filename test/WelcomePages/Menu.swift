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
    var finalResultsDigit = Double()
    var finalResultsRevDigit = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For debugging
        print("SWE  :", finalResultsSWE)
        print("PDE  :", finalResultsPDE)
        print("Digit:", finalResultsDigit)
        print("Rev D:", finalResultsRevDigit)
        
        //override the back button in the navigation controller
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(self.signOut(sender:)))
        
        let testScoresToSave: [Double]! = [finalResultsSWE, finalResultsPDE, finalResultsDigit, finalResultsRevDigit]
        
        if testScoresToSave[0] != 0 || testScoresToSave[1] != 0 || testScoresToSave[2] != 0 || testScoresToSave[3] != 0 {
            saveResults()
        }

    }
    
    func saveResults() {
        var refDatabase: DatabaseReference!
        refDatabase = Database.database().reference().child("results").child("user")

        let userName = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
//        let key = refDatabase.childByAutoId().key
        let key = refDatabase.child(uid!).key
        
        var userResults: [String : Any]
        
        if finalResultsSWE == 0 && finalResultsPDE == 0 {
            userResults = ["username":userName!, "Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit] as [String : Any]
        }
        else if finalResultsDigit == 0 && finalResultsRevDigit == 0 {
            userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE] as [String : Any]
        }
        else if finalResultsSWE == 0 {
            userResults = ["username":userName!, "TowrePDE":finalResultsPDE, "Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit] as [String : Any]
        }
        else if finalResultsPDE == 0 {
            userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit] as [String : Any]
        }
        else if finalResultsDigit == 0 {
            userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE, "Reverse Digit Span":finalResultsRevDigit] as [String : Any]
        }
        else if finalResultsRevDigit == 0 {
            userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE, "Digit Span":finalResultsDigit] as [String : Any]
        }
        else {
            userResults = ["username":userName!, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE, "Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit] as [String : Any]
        }
//        refDatabase.child(key).setValue(userResults)
        refDatabase.child(key).updateChildValues(userResults)
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
