//
//  TableMenuController.swift
//  test
//
//  Created by Dominic Heaton on 19/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TableMenuController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTests()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "signOut", sender: nil)
    }
    
    func loadTests() {
        
        let testsAvailable = Database.database().reference(withPath: "tests")
        testsAvailable.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            /*
            var availableTests: [tests] = []
            
            for item in snapshot.children {
                let test = tests(snapshot: item as! FIRDataSnapshot)
                availableTests.append(test)
            }
            self.items = availableTests
            self.tableView.reloadData()
        */
        })
    }

}
