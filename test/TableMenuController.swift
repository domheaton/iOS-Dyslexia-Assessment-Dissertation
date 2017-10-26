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
    
    let referenceResults = Database.database().reference().child("results").child("user")
    
    //The labels used in the table
    @IBOutlet var tableNames: UITableView!
    
    //Reference to the class containing test names
    var resultsList = [TestResults]()
    
    //Sets number of rows in table from database list number
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    //Assigns data from the database to a cell in the table
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCells
        let username: TestResults
        
        username = resultsList[indexPath.row]
        
        cell.labelName.text = username.name
        
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

    //function to read data from the database and fill table
    func loadTests() {
        referenceResults.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.resultsList.removeAll()
                
                for tests in snapshot.children.allObjects as![DataSnapshot]{
                    let nameObject = tests.value as? [String: AnyObject]
                    let userName = nameObject?["username"]
                    let name = TestResults(name: userName as! String?)
                    
                    self.resultsList.append(name)
                }
                self.tableNames.reloadData()
            }
        })
    }
}
