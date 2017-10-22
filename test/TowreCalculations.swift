//
//  TowreCalculations.swift
//  test
//
//  Created by Dominic Heaton on 22/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct TowreBrain {
    
    private var rawScore: Double?
    private var finalResults: Double?
    private var numberOfWords: Double?
    private var currentRawScore: Double?
    
    mutating func setNumberOfWords(_ number: Double) {
        numberOfWords = number
    }
    
    mutating func zeroScore() {
        rawScore = 0
    }
    
    mutating func updateRawScore(_ answer: String) {
        if answer == "correct" {
            rawScore = rawScore! + 1
        }
        else if answer == "incorrect" {
            rawScore = rawScore! + 0
        }
        
        //For debugging
        print("Current Raw Score: ", rawScore!)
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
        
        let userResults = ["username":userName!, "Towre":finalResults!] as [String : Any]
        refDatabase.child(key).setValue(userResults)
    }
}
