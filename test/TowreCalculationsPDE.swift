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
    
    private var rawScorePDE: Double?
    private var finalResultsPDE: Double?
    private var numberOfWordsPDE: Double?
    private var currentRawScorePDE: Double?
    private var previousRawScorePDE: Double?
    private var finalResultsSWE: Double?
    
    var setWordsToTestPDE: [String] = ["ip", "ga", "ko", "ta", "om", "ig", "ni", "pim", "wum", "lat", "baf", "din", "nup", "fet", "bave", "pate", "herm", "dess", "chur", "knap", "tive", "barp", "stip", "plin", "frip", "poth", "vasp", "meest", "shlee", "guddy", "skree", "felly", "clirt", "sline", "dreff", "prain", "zint", "bloot", "trisk", "kelm", "strone", "lu-naf", "cratty", "trober", "de-pate", "glant", "sploosh", "dre-ker", "rit-lun", "hed-fert", "bre-mick", "nif-pate", "brin-bert", "cla-bom", "drep-nort", "shrat-tec", "plo-fent", "smu-crit", "pel-na-dor", "forn-a-lask", "ferm-a-balt", "cre-nid-moke", "e-mul-ba-tate", "stro-ta-lant-ed", "pri-ling-dor-fent", "chun-fen-dilt"]
    
    mutating func setFinalResultsSWE(_ number: Double) {
        finalResultsSWE = number
    }
    
    mutating func setNumberOfWords(_ number: Double) {
        numberOfWordsPDE = number
    }

    mutating func zeroScore() {
        previousRawScorePDE = 0
        rawScorePDE = 0
    }
    
    mutating func updateRawScore(_ answer: String) {
        if answer == "correct" {
            previousRawScorePDE = rawScorePDE!
            rawScorePDE = rawScorePDE! + 1
        }
        else if answer == "incorrect" {
            previousRawScorePDE = rawScorePDE!
            rawScorePDE = rawScorePDE! + 0
        }
        
        //For debugging
        print("Current Prev. Score: ", previousRawScorePDE!)
        print("Current Raw  Score : ", rawScorePDE!)
    }
    
    mutating func setRawScore() {
        rawScorePDE = previousRawScorePDE!
        previousRawScorePDE = previousRawScorePDE! - 1
        
        //For debugging
        print("Current Prev. Score: ", previousRawScorePDE!)
        print("Current Raw  Score : ", rawScorePDE!)
    }
    
    mutating func calculateResult() {
        finalResultsPDE = (rawScorePDE! / numberOfWordsPDE!) * 100
        
        //For debugging
        print("Final Result: ", finalResultsPDE!)

    }

    func getFinalResultsSWE() -> Double {
        return finalResultsSWE!
    }
    
    func getFinalResultsPDE() -> Double {
        return finalResultsPDE!
    }

}

