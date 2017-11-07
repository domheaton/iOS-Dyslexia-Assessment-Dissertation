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
    private var previousRawScore: Double?
    private var scaledScore: Double?
    
    var setWordsToTestSWE: [String] = ["is", "up", "cat", "red", "me", "to", "no", "we", "he", "the", "and", "yes", "of", "him", "as", "book", "was", "help", "then", "time", "wood", "let", "men", "baby", "new", "stop", "work", "jump", "part", "fast", "fine", "milk", "back", "lost", "find", "paper", "open", "kind", "able", "shoes", "money", "great", "father", "river", "space", "short", "left", "people", "almost", "waves", "child", "strong", "crowd", "better", "inside", "plane", "pretty", "famous", "children", "without", "finally", "strange", "budget", "repress", "contain", "justice", "morning", "resolve", "describe", "garment", "business", "qualify", "potent", "collapse", "elements", "pioneer", "remember", "dangerous", "uniform", "necessary", "problems", "absentee", "advertise", "pleasant", "property", "distress", "information", "recession", "understand", "emphasis", "confident", "intuition", "boisterous", "plausible", "courageous", "alienate", "extinguish", "prairie", "limousine", "valentine", "detective", "recently", "instruction", "transient", "phenomenon", "calculated", "alternative", "collective"]
    
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
//        finalResults = (rawScore! / numberOfWords!) * 100

        scaleScores()
        finalResults = scaledScore!
        
        //For debugging
        print("Final Result: ", finalResults!)
        print("Scaled Score: ", scaledScore!)
    }
    
    func getFinalResults() -> Double {
        return finalResults!
    }
    
    func getScaledScoreSWE() -> Double {
        return scaledScore!
    }
    
    mutating func scaleScores() {
        if rawScore! < 29.0 {
            scaledScore = 55.0
        }
        else {
            switch rawScore! {
            case 29.0:
                scaledScore = 56.0
            case 30.0:
                scaledScore = 57.0
            case 31.0:
                scaledScore = 58.0
            case 32.0:
                scaledScore = 59.0
            case 33.0:
                scaledScore = 60.0
            case 34.0:
                scaledScore = 61.0
            case 35.0:
                scaledScore = 62.0
            case 36.0:
                scaledScore = 63.0
            case 37.0:
                scaledScore = 63.0
            case 38.0:
                scaledScore = 64.0
            case 39.0:
                scaledScore = 65.0
            case 40.0:
                scaledScore = 66.0
            case 41.0:
                scaledScore = 67.0
            case 42.0:
                scaledScore = 68.0
            case 43.0:
                scaledScore = 69.0
            case 44.0:
                scaledScore = 70.0
            case 45.0:
                scaledScore = 72.0
            case 46.0:
                scaledScore = 73.0
            case 47.0:
                scaledScore = 74.0
            case 48.0:
                scaledScore = 75.0
            case 49.0:
                scaledScore = 76.0
            case 50.0:
                scaledScore = 77.0
            case 51.0:
                scaledScore = 78.0
            case 52.0:
                scaledScore = 79.0
            case 53.0:
                scaledScore = 80.0
            case 54.0:
                scaledScore = 80.0
            case 55.0:
                scaledScore = 81.0
            case 56.0:
                scaledScore = 82.0
            case 57.0:
                scaledScore = 83.0
            case 58.0:
                scaledScore = 84.0
            case 59.0:
                scaledScore = 85.0
            case 60.0:
                scaledScore = 87.0
            case 61.0:
                scaledScore = 88.0
            case 62.0:
                scaledScore = 89.0
            case 63.0:
                scaledScore = 90.0
            case 64.0:
                scaledScore = 91.0
            case 65.0:
                scaledScore = 93.0
            case 66.0:
                scaledScore = 94.0
            case 67.0:
                scaledScore = 95.0
            case 68.0:
                scaledScore = 96.0
            case 69.0:
                scaledScore = 98.0
            case 70.0:
                scaledScore = 99.0
            case 71.0:
                scaledScore = 100.0
            case 72.0:
                scaledScore = 102.0
            case 73.0:
                scaledScore = 103.0
            case 74.0:
                scaledScore = 105.0
            case 75.0:
                scaledScore = 106.0
            case 76.0:
                scaledScore = 107.0
            case 77.0:
                scaledScore = 109.0
            case 78.0:
                scaledScore = 110.0
            case 79.0:
                scaledScore = 112.0
            case 80.0:
                scaledScore = 113.0
            case 81.0:
                scaledScore = 115.0
            case 82.0:
                scaledScore = 117.0
            case 83.0:
                scaledScore = 118.0
            case 84.0:
                scaledScore = 120.0
            case 85.0:
                scaledScore = 121.0
            case 86.0:
                scaledScore = 123.0
            case 87.0:
                scaledScore = 126.0
            case 88.0:
                scaledScore = 127.0
            case 89.0:
                scaledScore = 129.0
            case 90.0:
                scaledScore = 130.0
            case 91.0:
                scaledScore = 132.0
            case 92.0:
                scaledScore = 133.0
            case 93.0:
                scaledScore = 134.0
            case 94.0:
                scaledScore = 135.0
            case 95.0:
                scaledScore = 136.0
            case 96.0:
                scaledScore = 137.0
            case 97.0:
                scaledScore = 138.0
            case 98.0:
                scaledScore = 139.0
            case 99.0:
                scaledScore = 140.0
            case 100.0:
                scaledScore = 141.0
            case 101.0:
                scaledScore = 142.0
            case 102.0:
                scaledScore = 142.0
            case 103.0:
                scaledScore = 142.0
            case 104.0:
                scaledScore = 143.0
            case 105.0:
                scaledScore = 144.0
            case 106.0:
                scaledScore = 145.0
            case 107.0:
                scaledScore = 145.0
            case 108.0:
                scaledScore = 145.0
            default:
                scaledScore = 0.0
            }
        }
        
    }

}
