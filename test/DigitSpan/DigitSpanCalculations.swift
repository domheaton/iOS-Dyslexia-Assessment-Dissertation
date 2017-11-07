//
//  DigitSpanCalculations.swift
//  test
//
//  Created by Dominic Heaton on 03/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct DigitSpanCalculations {
    
    private var rawScore: Double?
    private var finalResults: Double?
    private var numberOfSets: Double?
    private var currentRawScore: Double?
    private var previousRawScore: Double?
    
    var totalNumberPatternsDigit = 16.0 //Number of patterns used in Digit Span Test
    
    var setPatternsToTestDigit: [[String]] = [ ["4   3","1   6"],["7   9   2","8   4   7"],["5   9   4   1","7   2   5   3"],["9   3   8   7   2","7   5   3   9   6"],["1   5   2   6   4   9","2   1   6   7   4   8"],["3   7   4   5   2   6   1","4   9   2   5   3   1   6"],["8   2   9   7   3   5   4   6","6   9   1   7   4   2   5   3"],["2   4   6   9   3   7   1   8   5","3   7   1   6   2   5   9   4   8"] ]
    
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
        if rawScore! > 0 {
            rawScore = previousRawScore!
            previousRawScore = previousRawScore! - 1
        }
        
        //For debugging
        print("Current Prev. Score: ", previousRawScore!)
        print("Current Raw  Score : ", rawScore!)
    }
    
    mutating func calculateResult() {
        if numberOfSets! == 0 {
            finalResults = 0
        } else {
            finalResults = (rawScore! / totalNumberPatternsDigit) * 100
        }
        
        //For debugging
        print("Final Result: ", finalResults!)
    }
    
    func getFinalResultsDigit() -> Double {
        return finalResults!
    }
    
    func getFinalRawDigit() -> Double {
        return rawScore!
    }
    
}

