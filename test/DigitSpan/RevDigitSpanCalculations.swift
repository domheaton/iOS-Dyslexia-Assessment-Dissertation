//
//  RevDigitSpanCalculations.swift
//  test
//
//  Created by Dominic Heaton on 03/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct RevDigitSpanCalculations {
    
    private var rawScore: Double?
    private var finalResults: Double?
    private var numberOfSets: Double?
    private var currentRawScore: Double?
    private var previousRawScore: Double?
    
    var setPatternsToTestRevDigit: [[String]] = [ ["8   3","2   9"],["4   7   5","6   1   5"],["2   6   1   9","3   8   5   2"],["2   8   7   3   6","5   9   4   1   3"],["6   2   4   7   1   9","2   7   6   3   9   1"],["4   1   8   3   6   2   7","1   5   8   6   9   3   7"],["5   2   6   2   4   1   9   7","9   4   6   1   7   3   8   5"] ]
    var setPatternsToReturnRevDigit: [[String]] = [ ["3   8","9   2"],["5   7   4","5   1   6"],["9   1   6   2","2   5   8   3"],["6   3   7   8   2","3   1   4   9   5"],["9   1   7   4   2   6","1   9   3   6   7   2"],["7   2   6   3   8   1   4","7   3   9   6   8   5   1"],["7   9   1   4   2   6   2   5","5   8   3   7   1   6   4   9"] ]
    
    mutating func setNumberOfSets(_ number: Double) {
        numberOfSets = number
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
        if numberOfSets! == 0 {
            finalResults = 0
        } else {
            finalResults = (rawScore! / (numberOfSets! * 2)) * 100
        }
        
        //For debugging
        print("Final Result: ", finalResults!)
    }
    
    func getFinalResultsRevDigit() -> Double {
        return finalResults!
    }
    
}
