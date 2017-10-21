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
    
    let referenceTests = Database.database().reference().child("tests")
    
    //The labels used in the table
    @IBOutlet var tableNames: UITableView!
    
    //Reference to the class containing test names
    var testsList = [testModel]()
    
    //Sets number of rows in table from database list number
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testsList.count
    }
    
    //Assigns data from the database to a cell in the table
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let nameOfTest: testModel
        
        nameOfTest = testsList[indexPath.row]
        
        cell.labelName.text = nameOfTest.name
        
        return cell
    }
    
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
    
    //function to read data from the database and fill table
    func loadTests() {
        referenceTests.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.testsList.removeAll()
                
                for tests in snapshot.children.allObjects as![DataSnapshot]{
                    let nameObject = tests.value as? [String: AnyObject]
                    let testName = nameObject?["name"]
                    
                    let test = testModel(name: testName as! String?)
                    
                    self.testsList.append(test)
                }
                self.tableNames.reloadData()
            }
        })
    }
    
    @IBAction func selectTest(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTestDescription", sender: self)
    }
    
}
