//
//  DashCalculations.swift
//  test
//
//  Created by Dominic Heaton on 13/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct DashCalculations {
    
    private var copyBestWordsWritten: Double?
    private var copyFastWordsWritten: Double?
    private var copyAlphabetTotalWritten: Double?
    private var freeWritingTotalWritten: Double?
    
    private var scaledCopyBest: Double?
    private var scaledCopyFast: Double?
    private var scaledCopyAlphabet: Double?
    private var scaledFreeWriting: Double?
    private var finalResultDash: Double?
    
    //Fetching values from Subtests
    mutating func setInputsFromSubtests(_ copyBest: Double,_ copyFast: Double,_ copyAlphabet: Double,_ freeWriting: Double) {
        copyBestWordsWritten = copyBest
        copyFastWordsWritten = copyFast
        copyAlphabetTotalWritten = copyAlphabet
        freeWritingTotalWritten = freeWriting
    }
    
    mutating func scaleResults() {
        scaledCopyBest = copyBestWordsWritten! / 2.0
        scaledCopyFast = copyFastWordsWritten! / 2.0
        scaledCopyAlphabet = copyAlphabetTotalWritten! / 2.0
        scaledFreeWriting = freeWritingTotalWritten! / 10.0
        
        finalResultDash = ((scaledCopyBest! + scaledCopyFast! + scaledCopyAlphabet! + scaledFreeWriting!) / 4.0)
    }
    
    //Return Raw Values
    func getCopyBest() -> Double {
        return copyBestWordsWritten!
    }
    
    func getCopyFast() -> Double {
        return copyFastWordsWritten!
    }

    func getCopyAlphabet() -> Double {
        return copyAlphabetTotalWritten!
    }
    
    func getFreeWriting() -> Double {
        return freeWritingTotalWritten!
    }
    
    //Return Scaled Values
    func getScaledCopyBest() -> Double {
        return scaledCopyBest!
    }
    
    func getScaledCopyFast() -> Double {
        return scaledCopyFast!
    }
    
    func getScaledCopyAlphabet() -> Double {
        return scaledCopyAlphabet!
    }
    
    func getScaledFreeWriting() -> Double {
        return scaledFreeWriting!
    }
    
    func getFinalResultDash() -> Double {
        return finalResultDash!
    }
}

