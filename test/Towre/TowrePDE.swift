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
    
    let uid = Auth.auth().currentUser?.uid
    
    var finalResultsSWE = Double()
    var scaledResultSWE = Double()
    
    private var brain = TowreBrainPDE()
    
    @IBOutlet weak var wordToTestPDE: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! TestCompleted
        nextVC.finalResultsSWE = brain.getFinalResultsSWE()
        nextVC.finalResultsPDE = brain.getFinalResultsPDE()
        nextVC.finalResultsTowre = brain.getFinalScaledTowre()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch SWE results from firebase
        getTowreSWEresults()
//        print("finalResultsSWE: ", finalResultsSWE)
//        print("scaledResultSWE: ", scaledResultSWE)
        
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TowrePDE.checkTimeElapsed), userInfo: nil, repeats: true)
        wordsToTest = brain.setWordsToTestPDE
        brain.setNumberOfWords(Double(wordsToTest.count))
        brain.zeroScore()
//        brain.setFinalResultsSWE(finalResultsSWE)
//        brain.setScaledScoreSWE(scaledResultSWE)
        
        //For debugging
        print("TowreSWE: ", finalResultsSWE)

        loadWord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 2: Phonemic Decoding Efficiency"
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
            timer2.invalidate()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
    
    func getTowreSWEresults() {
        let dbRef = Database.database().reference().child("intermediateResults").child("user").child(uid!)
        dbRef.child("finalResultsSWE").observeSingleEvent(of: .value) {
            (snapshot) in
            if let finalSWE = snapshot.value as? Double {
//                self.finalResultsSWE = finalSWE
                self.brain.setFinalResultsSWE(finalSWE)
            }
        }
        dbRef.child("scaledResultSWE").observeSingleEvent(of: .value) {
            (snapshot) in
            if let scaledSWE = snapshot.value as? Double {
//                self.finalResultsSWE = scaledSWE
                self.brain.setScaledScoreSWE(scaledSWE)
            }
        }
    }

}
