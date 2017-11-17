//
//  BPVS.swift
//  test
//
//  Created by Dominic Heaton on 17/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BPVS: UIViewController {
    
    var wordsToTest: [String] = []
    var wordsToTestAnswer: [Int] = []
    var initialWord = 72 //starts the wordsToTest array at the set of words for age 9-11
    var currentWord: Int?
    var wordToTestAnswer: Int?
    var errorsInSet = 0 //errors made within the set
    var numberWordInSet = 1 //words in set numbered from 1 to 12
    var setInUse = 7 //starts in the set for age 9-11
    
    private var brain = BPVSCalculations()
    
    @IBOutlet weak var wordToTest: UILabel!
    @IBOutlet weak var imageLoaded: UIImageView!
    
    //Function to hide back button from navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Test: BPVS 3"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsToTest = brain.setWordsToTest
        wordsToTestAnswer = brain.setWordsToTestAnswer
        
        loadInitialWord()
        
        //Set name of image to be displayed on screen
        
        brain.zeroScore()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nextVC = segue.destination as! SubtestCompleted
//        nextVC.finalResultsSWE = brain.getFinalResults()
//        nextVC.scaledResultSWE = brain.getScaledScoreSWE()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 1 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }
        
        loadWord()
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 2 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }
        
        loadWord()
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 3 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }

        loadWord()
    }
    
    @IBAction func button4Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 4 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }

        loadWord()
    }
    
    func loadInitialWord() {
        wordToTest.text! = wordsToTest[initialWord]
        wordToTestAnswer = wordsToTestAnswer[initialWord]
        currentWord = initialWord
    }
    
    func loadWord() {
        //NEED TO ADD A CHECK TO MAKE SURE NOT TOO MANY INCORRECT ANSWERS
        
        if currentWord! < 156 {
            currentWord! += 1
        }
        else {
            print("ALL ITEMS ADMINISTERED")
        }
        
        wordToTest.text! = wordsToTest[currentWord!]
        wordToTestAnswer = wordsToTestAnswer[currentWord!]
        
        if numberWordInSet < 12 {
            numberWordInSet += 1
        }
        else {
            setInUse += 1
            numberWordInSet = 1
        }
    }
    
//    //Function to load next word from array - or finish test if list completed
//    func loadWord() {
//        if counter < wordsToTest.count {
//            wordToTest.text = wordsToTest[counter]
//            counter = counter + 1
//        }
//        else {
//            brain.calculateResult()
//            timer.invalidate()
//            performSegue(withIdentifier: "toTowreSubtest", sender: nil)
//        }
//    }
    
}
