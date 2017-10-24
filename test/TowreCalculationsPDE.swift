//
//  TowreCalculationsPDE.swift
//  test
//
//  Created by Dominic Heaton on 24/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct TowreBrainPDE {
    
    private var rawScore: Double?
    private var finalResults: Double?
    private var numberOfWords: Double?
    private var currentRawScore: Double?
    private var previousRawScore: Double?
    
    var setWordsToTestPDE: [String] = ["PDE", "TEST", "cat", "red", "me", "to", "no", "we", "he", "the", "and", "yes", "of", "him", "as", "book", "was", "help", "then", "time", "wood", "let", "men", "baby", "new", "stop", "work", "jump", "part", "fast", "fine", "milk", "back", "lost", "find", "paper", "open", "kind", "able", "shoes", "money", "great", "father", "river", "space", "short", "left", "people", "almost", "waves", "child", "strong", "crowd", "better", "inside", "plane", "pretty", "famous", "children", "without", "finally", "strange", "budget", "repress", "contain", "justice", "morning", "resolve", "describe", "garment", "business", "qualify", "potent", "collapse", "elements", "pioneer", "remember", "dangerous", "uniform", "necessary", "problems", "absentee", "advertise", "pleasant", "property", "distress", "information", "recession", "understand", "emphasis", "confident", "intuition", "boisterous", "plausible", "courageous", "alienate", "extinguish", "prairie", "limousine", "valentine", "detective", "recently", "instruction", "transient", "phenomenon", "calculated", "alternative", "collective"]
    
    
    mutating func setNumberOfWords(_ number: Double) {
        numberOfWords = number
    }

    mutating func zeroScore() {
        previousRawScore = 0
        rawScore = 0
    }
    
    mutating func updateRawScore(_ answer: String) {
        if answer == "correct" {
            previousRawScore = rawScore!
            rawScore = rawScore! + 1
        }
        else if answer == "incorrect" {
            previousRawScore = rawScore!
            rawScore = rawScore! + 0
        }
        
        //For debugging
        print("Current Prev. Score: ", previousRawScore!)
        print("Current Raw  Score : ", rawScore!)
    }
    
    mutating func setRawScore() {
        rawScore = previousRawScore!
        previousRawScore = previousRawScore! - 1
        
        //For debugging
        print("Current Prev. Score: ", previousRawScore!)
        print("Current Raw  Score : ", rawScore!)
    }
    
    mutating func calculateResult() {
        finalResults = (rawScore! / numberOfWords!) * 100
        
        //For debugging
        print("Final Result: ", finalResults!)
        
        saveResults()
    }
    
    func saveResults() {
        var refDatabase: DatabaseReference!
        refDatabase = Database.database().reference().child("results").child("user")
        
        let userName = Auth.auth().currentUser?.email
        let key = refDatabase.childByAutoId().key
        
        let userResults = ["username":userName!, "TowreSWE":finalResults!] as [String : Any]
        refDatabase.child(key).setValue(userResults)
    }

}

