//
//  Towre.swift
//  test
//
//  Created by Dominic Heaton on 21/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Towre: UIViewController {
    
    var wordsToTest = [String]()
    
    let referenceTests = Database.database().reference().child("tests")
    
    @IBOutlet weak var wordToTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadWords()
        //wordToTest.text =
        print(self.wordsToTest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctPressed(_ sender: UIButton) {
        //For debugging
        print("Correct")
        wordToTest.text = "Word was correct"
    }
    
    @IBAction func incorrectPressed(_ sender: UIButton) {
        //For debugging
        print("Incorrect")
        wordToTest.text = "Word was incorrect"
    }
    
    func loadWords() {
        referenceTests.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.wordsToTest.removeAll()
                
                for tests in snapshot.children.allObjects as![DataSnapshot]{
                    let nameObject = tests.value as? [String: AnyObject]
                    let testName = nameObject?["name"] as! String
                    
                    //let test = TowreDatabase(wordFromDatabase: testName as! String?)
                    
                    self.wordsToTest.append(testName)
                }
            }
        })
    }
}

