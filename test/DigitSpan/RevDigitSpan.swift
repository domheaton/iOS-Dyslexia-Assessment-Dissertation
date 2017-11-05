//
//  RevDigitSpan.swift
//  test
//
//  Created by Dominic Heaton on 02/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RevDigitSpan: UIViewController {
    
    var finalResultsDigit = Double()
    var patternsToTest: [[String]] = []
    var patternsToReturn: [[String]] = []
    var counter = 0
    var subcounter = 0
    var howManyWrong = 0
    
    @IBOutlet weak var patternToTestRev: UILabel!
    @IBOutlet weak var patternToReturnRev: UILabel!
    
    private var brain = RevDigitSpanCalculations()
    
    //Functions to hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternsToTest = brain.setPatternsToTestRevDigit
        patternsToReturn = brain.setPatternsToReturnRevDigit
        brain.zeroScore()
        loadFirstPattern()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DigitCompleted
        nextVC.finalResultsDigit = finalResultsDigit
        nextVC.finalResultsRevDigit = brain.getFinalResultsRevDigit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func incrementSubcounter() {
        if subcounter == 1 {
            subcounter = 0
            counter = counter + 1
        }
        else if subcounter == 0 {
            subcounter = 1
        }
        else {
            subcounter = 0
            print("Error has occured in subcounter")
        }
    }
    
    func decrementSubcounter() {
        if subcounter == 0 {
            subcounter = 1
            counter = counter - 1
        }
        else if subcounter == 1 {
            subcounter = 0
        }
        else {
            subcounter = 0
            print("Error has occured in subcounter")
        }
    }
    
    func loadFirstPattern() {
        patternToTestRev.text = patternsToTest[counter][subcounter]
        patternToReturnRev.text = patternsToTest[counter][subcounter]
    }
    
    func loadPattern() {
        if patternsToTest[counter][subcounter] == "9   4   6   1   7   3   8   5" {
            brain.setNumberOfSets(Double(counter))
            brain.calculateResult()
            performSegue(withIdentifier: "digitToTestCompleted", sender: nil)
        }
        else {
            incrementSubcounter()
            patternToTestRev.text = patternsToTest[counter][subcounter]
            patternToReturnRev.text = patternsToReturn[counter][subcounter]
        }
    }
    
    @IBAction func correctPressed(_ sender: UIButton) {
        brain.updateRawScore("correct")
        howManyWrong = 0
        loadPattern()
    }
    
    @IBAction func incorrectPressed(_ sender: UIButton) {
        brain.updateRawScore("incorrect")
        howManyWrong = howManyWrong + 1
        if subcounter == 1 && howManyWrong == 2 {
            brain.setNumberOfSets(Double(counter))
            brain.calculateResult()
            performSegue(withIdentifier: "digitToTestCompleted", sender: nil)
        }
        else {
            loadPattern()
        }
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
        if counter > 0 {
            decrementSubcounter()
            decrementSubcounter()
            patternToTestRev.text = patternsToTest[counter][subcounter]
            patternToReturnRev.text = patternsToReturn[counter][subcounter]
            brain.setRawScore()
            incrementSubcounter()
        }
    }
    
}
