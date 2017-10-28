//
//  IndividualScore.swift
//  test
//
//  Created by Dominic Heaton on 28/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class IndividualScore: UIViewController {
    
    let referenceDatabase = Database.database().reference().child("results").child("user")
    
    @IBOutlet weak var nameOfStudentLabel: UILabel!
    @IBOutlet weak var nameOfTestLabel: UILabel!
    @IBOutlet weak var testScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDetails() {
        referenceDatabase.observe(DataEventType.value, with: {(snapshot) in
                for tests in snapshot.children.allObjects as![DataSnapshot]{
                    let nameObject = tests.value as? [String: AnyObject]
                    let name = nameObject?["username"] as! String?
                    let test = nameObject?["test"] as! String?
                    let result = nameObject?["score"] as! Double?
                    
                    self.nameOfStudentLabel.text = name!
                    self.nameOfTestLabel.text = test!
                    self.testScoreLabel.text = String(result!)
                }
        })
    }

}
