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
    
    var wordsToTest: [String] = ["Hello", "Start", "Stop"]
    var counter = 0
    
    private var brain = TowreBrain()
    
    @IBOutlet weak var wordToTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        brain.setNumberOfWords(Double(wordsToTest.count))
        brain.zeroScore()
        loadWord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctPressed(_ sender: UIButton) {
        brain.updateRawScore("correct")
        loadWord()
    }
    
    @IBAction func incorrectPressed(_ sender: UIButton) {
        brain.updateRawScore("incorrect")
        loadWord()
    }
    
    func loadWord() {
        if counter < wordsToTest.count {
            wordToTest.text = wordsToTest[counter]
            counter = counter + 1
        }
        else {
            brain.calculateResult()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
}

