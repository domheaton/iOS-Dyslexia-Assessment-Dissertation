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
    private var scaledScorePDE:Double?
    
    private var finalResultsSWE: Double?
    private var scaledScoreSWE: Double?
    
    private var sumOfScaledScores: Double?
    private var finalScoreTowre: Double?
    
    var setWordsToTestPDE: [String] = ["ip", "ga", "ko", "ta", "om", "ig", "ni", "pim", "wum", "lat", "baf", "din", "nup", "fet", "bave", "pate", "herm", "dess", "chur", "knap", "tive", "barp", "stip", "plin", "frip", "poth", "vasp", "meest", "shlee", "guddy", "skree", "felly", "clirt", "sline", "dreff", "prain", "zint", "bloot", "trisk", "kelm", "strone", "lu-naf", "cratty", "trober", "de-pate", "glant", "sploosh", "dre-ker", "rit-lun", "hed-fert", "bre-mick", "nif-pate", "brin-bert", "cla-bom", "drep-nort", "shrat-tec", "plo-fent", "smu-crit", "pel-na-dor", "forn-a-lask", "ferm-a-balt", "cre-nid-moke", "e-mul-ba-tate", "stro-ta-lant-ed", "pri-ling-dor-fent", "chun-fen-dilt"]
    
    mutating func setScaledScoreSWE(_ number: Double) {
        scaledScoreSWE = number
    }
    
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
        scaleScores()
        totalWordReadingEfficiency()
        print("Final Result: ", finalResultsPDE!)
        print("Scaled Scores: ", scaledScorePDE!)
        print("Total WRE: ", finalScoreTowre!)
    }

    func getFinalResultsSWE() -> Double {
        return finalResultsSWE!
    }
    
    func getFinalResultsPDE() -> Double {
        return finalResultsPDE!
    }
    
    func getFinalScaledTowre() -> Double {
        return finalScoreTowre!
    }
    
    mutating func scaleScores() {
        if rawScorePDE! < 3.0 {
            scaledScorePDE = 55.0
        }
        else {
            switch rawScorePDE! {
            case 3.0:
                scaledScorePDE = 56.0
            case 4.0:
                scaledScorePDE = 58.0
            case 5.0:
                scaledScorePDE = 59.0
            case 6.0:
                scaledScorePDE = 60.0
            case 7.0:
                scaledScorePDE = 62.0
            case 8.0:
                scaledScorePDE = 63.0
            case 9.0:
                scaledScorePDE = 65.0
            case 10.0:
                scaledScorePDE = 66.0
            case 11.0:
                scaledScorePDE = 67.0
            case 12.0:
                scaledScorePDE = 69.0
            case 13.0:
                scaledScorePDE = 70.0
            case 14.0:
                scaledScorePDE = 71.0
            case 15.0:
                scaledScorePDE = 73.0
            case 16.0:
                scaledScorePDE = 74.0
            case 17.0:
                scaledScorePDE = 75.0
            case 18.0:
                scaledScorePDE = 76.0
            case 19.0:
                scaledScorePDE = 78.0
            case 20.0:
                scaledScorePDE = 79.0
            case 21.0:
                scaledScorePDE = 80.0
            case 22.0:
                scaledScorePDE = 81.0
            case 23.0:
                scaledScorePDE = 82.0
            case 24.0:
                scaledScorePDE = 84.0
            case 25.0:
                scaledScorePDE = 85.0
            case 26.0:
                scaledScorePDE = 86.0
            case 27.0:
                scaledScorePDE = 87.0
            case 28.0:
                scaledScorePDE = 89.0
            case 29.0:
                scaledScorePDE = 90.0
            case 30.0:
                scaledScorePDE = 91.0
            case 31.0:
                scaledScorePDE = 92.0
            case 32.0:
                scaledScorePDE = 93.0
            case 33.0:
                scaledScorePDE = 95.0
            case 34.0:
                scaledScorePDE = 96.0
            case 35.0:
                scaledScorePDE = 97.0
            case 36.0:
                scaledScorePDE = 98.0
            case 37.0:
                scaledScorePDE = 99.0
            case 38.0:
                scaledScorePDE = 101.0
            case 39.0:
                scaledScorePDE = 102.0
            case 40.0:
                scaledScorePDE = 103.0
            case 41.0:
                scaledScorePDE = 104.0
            case 42.0:
                scaledScorePDE = 106.0
            case 43.0:
                scaledScorePDE = 107.0
            case 44.0:
                scaledScorePDE = 108.0
            case 45.0:
                scaledScorePDE = 110.0
            case 46.0:
                scaledScorePDE = 111.0
            case 47.0:
                scaledScorePDE = 112.0
            case 48.0:
                scaledScorePDE = 114.0
            case 49.0:
                scaledScorePDE = 115.0
            case 50.0:
                scaledScorePDE = 116.0
            case 51.0:
                scaledScorePDE = 118.0
            case 52.0:
                scaledScorePDE = 119.0
            case 53.0:
                scaledScorePDE = 121.0
            case 54.0:
                scaledScorePDE = 123.0
            case 55.0:
                scaledScorePDE = 124.0
            case 56.0:
                scaledScorePDE = 126.0
            case 57.0:
                scaledScorePDE = 128.0
            case 58.0:
                scaledScorePDE = 129.0
            case 59.0:
                scaledScorePDE = 131.0
            case 60.0:
                scaledScorePDE = 135.0
            case 61.0:
                scaledScorePDE = 140.0
            case 62.0:
                scaledScorePDE = 145.0
            case 63.0:
                scaledScorePDE = 145.0
            case 64.0:
                scaledScorePDE = 145.0
            case 65.0:
                scaledScorePDE = 145.0
            case 66.0:
                scaledScorePDE = 145.0
            default:
                scaledScorePDE = 0.0
            }
        }
    }
    
    mutating func totalWordReadingEfficiency() {
        sumOfScaledScores = scaledScoreSWE! + scaledScorePDE!
        switch sumOfScaledScores! {
        case 110.0:
            finalScoreTowre = 53.0
        case 111.0:
            finalScoreTowre = 53.0
        case 112.0:
            finalScoreTowre = 54.0
        case 113.0:
            finalScoreTowre = 54.0
        case 114.0:
            finalScoreTowre = 55.0
        case 115.0:
            finalScoreTowre = 55.0
        case 116.0:
            finalScoreTowre = 56.0
        case 117.0:
            finalScoreTowre = 56.0
        case 118.0:
            finalScoreTowre = 57.0
        case 119.0:
            finalScoreTowre = 57.0
        case 120.0:
            finalScoreTowre = 58.0
        case 121.0:
            finalScoreTowre = 58.0
        case 122.0:
            finalScoreTowre = 59.0
        case 123.0:
            finalScoreTowre = 59.0
        case 124.0:
            finalScoreTowre = 60.0
        case 125.0:
            finalScoreTowre = 60.0
        case 126.0:
            finalScoreTowre = 61.0
        case 127.0:
            finalScoreTowre = 62.0
        case 128.0:
            finalScoreTowre = 62.0
        case 129.0:
            finalScoreTowre = 63.0
        case 130.0:
            finalScoreTowre = 63.0
        case 131.0:
            finalScoreTowre = 64.0
        case 132.0:
            finalScoreTowre = 64.0
        case 133.0:
            finalScoreTowre = 65.0
        case 134.0:
            finalScoreTowre = 65.0
        case 135.0:
            finalScoreTowre = 66.0
        case 136.0:
            finalScoreTowre = 66.0
        case 137.0:
            finalScoreTowre = 67.0
        case 138.0:
            finalScoreTowre = 67.0
        case 139.0:
            finalScoreTowre = 68.0
        case 140.0:
            finalScoreTowre = 68.0
        case 141.0:
            finalScoreTowre = 69.0
        case 142.0:
            finalScoreTowre = 69.0
        case 143.0:
            finalScoreTowre = 70.0
        case 144.0:
            finalScoreTowre = 71.0
        case 145.0:
            finalScoreTowre = 71.0
        case 146.0:
            finalScoreTowre = 72.0
        case 147.0:
            finalScoreTowre = 72.0
        case 148.0:
            finalScoreTowre = 73.0
        case 149.0:
            finalScoreTowre = 73.0
        case 150.0:
            finalScoreTowre = 74.0
        case 151.0:
            finalScoreTowre = 74.0
        case 152.0:
            finalScoreTowre = 75.0
        case 153.0:
            finalScoreTowre = 75.0
        case 154.0:
            finalScoreTowre = 76.0
        case 155.0:
            finalScoreTowre = 76.0
        case 156.0:
            finalScoreTowre = 77.0
        case 157.0:
            finalScoreTowre = 77.0
        case 158.0:
            finalScoreTowre = 78.0
        case 159.0:
            finalScoreTowre = 78.0
        case 160.0:
            finalScoreTowre = 79.0
        case 161.0:
            finalScoreTowre = 79.0
        case 162.0:
            finalScoreTowre = 80.0
        case 163.0:
            finalScoreTowre = 81.0
        case 164.0:
            finalScoreTowre = 81.0
        case 165.0:
            finalScoreTowre = 82.0
        case 166.0:
            finalScoreTowre = 82.0
        case 167.0:
            finalScoreTowre = 83.0
        case 168.0:
            finalScoreTowre = 83.0
        case 169.0:
            finalScoreTowre = 84.0
        case 170.0:
            finalScoreTowre = 84.0
        case 171.0:
            finalScoreTowre = 85.0
        case 172.0:
            finalScoreTowre = 85.0
        case 173.0:
            finalScoreTowre = 86.0
        case 174.0:
            finalScoreTowre = 86.0
        case 175.0:
            finalScoreTowre = 87.0
        case 176.0:
            finalScoreTowre = 87.0
        case 177.0:
            finalScoreTowre = 88.0
        case 178.0:
            finalScoreTowre = 88.0
        case 179.0:
            finalScoreTowre = 89.0
        case 180.0:
            finalScoreTowre = 90.0
        case 181.0:
            finalScoreTowre = 90.0
        case 182.0:
            finalScoreTowre = 91.0
        case 183.0:
            finalScoreTowre = 91.0
        case 184.0:
            finalScoreTowre = 92.0
        case 185.0:
            finalScoreTowre = 92.0
        case 186.0:
            finalScoreTowre = 93.0
        case 187.0:
            finalScoreTowre = 93.0
        case 188.0:
            finalScoreTowre = 94.0
        case 189.0:
            finalScoreTowre = 94.0
        case 190.0:
            finalScoreTowre = 95.0
        case 191.0:
            finalScoreTowre = 95.0
        case 192.0:
            finalScoreTowre = 96.0
        case 193.0:
            finalScoreTowre = 96.0
        case 194.0:
            finalScoreTowre = 97.0
        case 195.0:
            finalScoreTowre = 97.0
        case 196.0:
            finalScoreTowre = 98.0
        case 197.0:
            finalScoreTowre = 98.0
        case 198.0:
            finalScoreTowre = 99.0
        case 199.0:
            finalScoreTowre = 100.0
        case 200.0:
            finalScoreTowre = 100.0
        case 201.0:
            finalScoreTowre = 101.0
        case 202.0:
            finalScoreTowre = 101.0
        case 203.0:
            finalScoreTowre = 102.0
        case 204.0:
            finalScoreTowre = 102.0
        case 205.0:
            finalScoreTowre = 103.0
        case 206.0:
            finalScoreTowre = 103.0
        case 207.0:
            finalScoreTowre = 104.0
        case 208.0:
            finalScoreTowre = 104.0
        case 209.0:
            finalScoreTowre = 105.0
        case 210.0:
            finalScoreTowre = 105.0
        case 211.0:
            finalScoreTowre = 106.0
        case 212.0:
            finalScoreTowre = 106.0
        case 213.0:
            finalScoreTowre = 107.0
        case 214.0:
            finalScoreTowre = 107.0
        case 215.0:
            finalScoreTowre = 108.0
        case 216.0:
            finalScoreTowre = 108.0
        case 217.0:
            finalScoreTowre = 109.0
        case 218.0:
            finalScoreTowre = 110.0
        case 219.0:
            finalScoreTowre = 110.0
        case 220.0:
            finalScoreTowre = 111.0
        case 221.0:
            finalScoreTowre = 111.0
        case 222.0:
            finalScoreTowre = 112.0
        case 223.0:
            finalScoreTowre = 112.0
        case 224.0:
            finalScoreTowre = 113.0
        case 225.0:
            finalScoreTowre = 113.0
        case 226.0:
            finalScoreTowre = 114.0
        case 227.0:
            finalScoreTowre = 114.0
        case 228.0:
            finalScoreTowre = 115.0
        case 229.0:
            finalScoreTowre = 115.0
        case 230.0:
            finalScoreTowre = 116.0
        case 231.0:
            finalScoreTowre = 116.0
        case 232.0:
            finalScoreTowre = 117.0
        case 233.0:
            finalScoreTowre = 117.0
        case 234.0:
            finalScoreTowre = 118.0
        case 235.0:
            finalScoreTowre = 119.0
        case 236.0:
            finalScoreTowre = 119.0
        case 237.0:
            finalScoreTowre = 120.0
        case 238.0:
            finalScoreTowre = 120.0
        case 239.0:
            finalScoreTowre = 121.0
        case 240.0:
            finalScoreTowre = 121.0
        case 241.0:
            finalScoreTowre = 122.0
        case 242.0:
            finalScoreTowre = 122.0
        case 243.0:
            finalScoreTowre = 123.0
        case 244.0:
            finalScoreTowre = 123.0
        case 245.0:
            finalScoreTowre = 124.0
        case 246.0:
            finalScoreTowre = 124.0
        case 247.0:
            finalScoreTowre = 125.0
        case 248.0:
            finalScoreTowre = 125.0
        case 249.0:
            finalScoreTowre = 126.0
        case 250.0:
            finalScoreTowre = 126.0
        case 251.0:
            finalScoreTowre = 127.0
        case 252.0:
            finalScoreTowre = 127.0
        case 253.0:
            finalScoreTowre = 128.0
        case 254.0:
            finalScoreTowre = 129.0
        case 255.0:
            finalScoreTowre = 129.0
        case 256.0:
            finalScoreTowre = 130.0
        case 257.0:
            finalScoreTowre = 130.0
        case 258.0:
            finalScoreTowre = 131.0
        case 259.0:
            finalScoreTowre = 131.0
        case 260.0:
            finalScoreTowre = 132.0
        case 261.0:
            finalScoreTowre = 132.0
        case 262.0:
            finalScoreTowre = 133.0
        case 263.0:
            finalScoreTowre = 133.0
        case 264.0:
            finalScoreTowre = 134.0
        case 265.0:
            finalScoreTowre = 134.0
        case 266.0:
            finalScoreTowre = 135.0
        case 267.0:
            finalScoreTowre = 135.0
        case 268.0:
            finalScoreTowre = 136.0
        case 269.0:
            finalScoreTowre = 136.0
        case 270.0:
            finalScoreTowre = 137.0
        case 271.0:
            finalScoreTowre = 138.0
        case 272.0:
            finalScoreTowre = 138.0
        case 273.0:
            finalScoreTowre = 139.0
        case 274.0:
            finalScoreTowre = 139.0
        case 275.0:
            finalScoreTowre = 140.0
        case 276.0:
            finalScoreTowre = 140.0
        case 277.0:
            finalScoreTowre = 141.0
        case 278.0:
            finalScoreTowre = 141.0
        case 279.0:
            finalScoreTowre = 142.0
        case 280.0:
            finalScoreTowre = 142.0
        case 281.0:
            finalScoreTowre = 143.0
        case 282.0:
            finalScoreTowre = 143.0
        case 283.0:
            finalScoreTowre = 144.0
        case 284.0:
            finalScoreTowre = 144.0
        case 285.0:
            finalScoreTowre = 145.0
        case 286.0:
            finalScoreTowre = 145.0
        case 287.0:
            finalScoreTowre = 146.0
        case 288.0:
            finalScoreTowre = 146.0
        case 289.0:
            finalScoreTowre = 147.0
        case 290.0:
            finalScoreTowre = 147.0
        default:
            finalScoreTowre = 0.0
        }
    }


}

