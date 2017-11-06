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
    private var finalRawDigit: Double?
    private var combinedRawScore: Double?
    private var combinedScaledScore: Double?
    
    var totalNumberPatternsRevDigit = 14.0 //Number of patterns used in Rev. Digit Span Test
    
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
            finalResults = (rawScore! / totalNumberPatternsRevDigit) * 100
        }
        
        scaleScores()
        
        //For debugging
        print("Final Result: ", finalResults!)
    }
    
    mutating func getFinalRawDigit(_ number: Double) {
        finalRawDigit = number
    }
    
    func getFinalResultsRevDigit() -> Double {
        return finalResults!
    }
    
    mutating func scaleScores() {
        combinedRawScore = rawScore! + finalRawDigit!
        print("Rev. Dig: ", rawScore!)
        print("Digit   : ", finalRawDigit!)
        print("Combined: ", combinedRawScore!)
        
        switch combinedRawScore! {
        case 4.0:
            combinedScaledScore = 54.0
        case 5.0:
            combinedScaledScore = 59.0
        case 6.0:
            combinedScaledScore = 64.0
        case 7.0:
            combinedScaledScore = 69.0
        case 8.0:
            combinedScaledScore = 74.0
        case 9.0:
            combinedScaledScore = 79.0
        case 10.0:
            combinedScaledScore = 85.0
        case 11.0:
            combinedScaledScore = 90.0
        case 12.0:
            combinedScaledScore = 95.0
        case 13.0:
            combinedScaledScore = 100.0
        case 14.0:
            combinedScaledScore = 105.0
        case 15.0:
            combinedScaledScore = 110.0
        case 16.0:
            combinedScaledScore = 115.0
        case 17.0:
            combinedScaledScore = 121.0
        case 18.0:
            combinedScaledScore = 126.0
        case 19.0:
            combinedScaledScore = 131.0
        case 20.0:
            combinedScaledScore = 136.0
        case 21.0:
            combinedScaledScore = 141.0
        case 22.0:
            combinedScaledScore = 146.0
        case 23.0:
            combinedScaledScore = 152.0
        case 24.0:
            combinedScaledScore = 157.0
        default:
            combinedScaledScore = 0.0
        }
    }
    
    func getCombinedFinalResult() -> Double {
        return combinedScaledScore!
    }
    
}
