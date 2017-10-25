//
//  TowrePDE.swift
//  test
//
//  Created by Dominic Heaton on 24/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TowrePDE: UIViewController {
    
    var wordsToTest: [String] = []
    var counter = 0
    var timer2 = Timer()
    var time = 0
    
    private var brain = TowreBrainPDE()
    
    @IBOutlet weak var wordToTestPDE: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TowrePDE.checkTimeElapsed), userInfo: nil, repeats: true)
        wordsToTest = brain.setWordsToTestPDE
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
    
    @IBAction func undoPressed(_ sender: UIButton) {
        if counter >= 2 {
            counter = counter - 2
            wordToTestPDE.text = wordsToTest[counter]
            brain.setRawScore()
            counter = counter + 1
        }
    }
    
    //Function to increment timer - ends test after 45 Seconds -- Objective-C function call
    @objc func checkTimeElapsed() {
        if time < 45 {
            time += 1
        }
        else {
            //For debugging
            print("Timer Expired")
            
            timer2.invalidate()
            time = 0
            brain.calculateResult()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
    
    //Function to load next word from array - or finish test if list completed
    func loadWord() {
        if counter < wordsToTest.count {
            wordToTestPDE.text = wordsToTest[counter]
            counter = counter + 1
        }
        else {
            brain.calculateResult()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
}


