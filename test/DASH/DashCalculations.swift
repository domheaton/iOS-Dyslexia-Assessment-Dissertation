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
        scaleFinalResultDash()
    }
    
    mutating func scaleFinalResultDash() {
        standardiseCopyBest()
        standardiseCopyFast()
        standardiseCopyAlphabet()
        standardiseFreeWriting()
        
        standardiseFinalResultDash()
    }
    
    //Return Raw Values -- WPM
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
        return freeWritingTotalWritten!/5.0
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
    
    mutating func standardiseCopyBest() {
        let tempCopyBest = copyBestWordsWritten!
        if tempCopyBest > 24 {
            scaledCopyBest = 17.0
        }
        else {
            switch tempCopyBest {
            case 1.0:
                scaledCopyBest = 3.0
            case 2.0:
                scaledCopyBest = 3.0
            case 3.0:
                scaledCopyBest = 3.0
            case 4.0:
                scaledCopyBest = 3.0
            case 5.0:
                scaledCopyBest = 4.0
            case 6.0:
                scaledCopyBest = 4.0
            case 7.0:
                scaledCopyBest = 5.0
            case 8.0:
                scaledCopyBest = 6.0
            case 9.0:
                scaledCopyBest = 6.0
            case 10.0:
                scaledCopyBest = 7.0
            case 11.0:
                scaledCopyBest = 7.0
            case 12.0:
                scaledCopyBest = 8.0
            case 13.0:
                scaledCopyBest = 9.0
            case 14.0:
                scaledCopyBest = 10.0
            case 15.0:
                scaledCopyBest = 10.0
            case 16.0:
                scaledCopyBest = 11.0
            case 17.0:
                scaledCopyBest = 12.0
            case 18.0:
                scaledCopyBest = 13.0
            case 19.0:
                scaledCopyBest = 13.0
            case 20.0:
                scaledCopyBest = 14.0
            case 21.0:
                scaledCopyBest = 15.0
            case 22.0:
                scaledCopyBest = 15.0
            case 23.0:
                scaledCopyBest = 16.0
            case 24.0:
                scaledCopyBest = 16.0
            default:
                scaledCopyBest = 0.0
            }
        }
    }
    
    mutating func standardiseCopyFast() {
        let tempCopyFast = copyFastWordsWritten!
        if tempCopyFast > 30 {
            scaledCopyFast = 17.0
        }
        else {
            switch tempCopyFast {
            case 1.0:
                scaledCopyFast = 3.0
            case 2.0:
                scaledCopyFast = 3.0
            case 3.0:
                scaledCopyFast = 3.0
            case 4.0:
                scaledCopyFast = 3.0
            case 5.0:
                scaledCopyFast = 3.0
            case 6.0:
                scaledCopyFast = 3.0
            case 7.0:
                scaledCopyFast = 3.0
            case 8.0:
                scaledCopyFast = 3.0
            case 9.0:
                scaledCopyFast = 3.0
            case 10.0:
                scaledCopyFast = 3.0
            case 11.0:
                scaledCopyFast = 4.0
            case 12.0:
                scaledCopyFast = 5.0
            case 13.0:
                scaledCopyFast = 5.0
            case 14.0:
                scaledCopyFast = 6.0
            case 15.0:
                scaledCopyFast = 7.0
            case 16.0:
                scaledCopyFast = 7.0
            case 17.0:
                scaledCopyFast = 8.0
            case 18.0:
                scaledCopyFast = 8.0
            case 19.0:
                scaledCopyFast = 9.0
            case 20.0:
                scaledCopyFast = 10.0
            case 21.0:
                scaledCopyFast = 11.0
            case 22.0:
                scaledCopyFast = 11.0
            case 23.0:
                scaledCopyFast = 12.0
            case 24.0:
                scaledCopyFast = 12.0
            case 25.0:
                scaledCopyFast = 13.0
            case 26.0:
                scaledCopyFast = 13.0
            case 27.0:
                scaledCopyFast = 14.0
            case 28.0:
                scaledCopyFast = 15.0
            case 29.0:
                scaledCopyFast = 16.0
            case 30.0:
                scaledCopyFast = 16.0
            default:
                scaledCopyFast = 0.0
            }
        }
    }
    
    mutating func standardiseCopyAlphabet() {
        let tempCopyAlphabet = copyAlphabetTotalWritten!
        if tempCopyAlphabet < 6.0 {
            scaledCopyAlphabet = 3.0
        }
        else if tempCopyAlphabet >= 6.0 && tempCopyAlphabet < 12.0 {
            scaledCopyAlphabet = 4.0
        }
        else if tempCopyAlphabet >= 12.0 && tempCopyAlphabet < 19.0 {
            scaledCopyAlphabet = 5.0
        }
        else if tempCopyAlphabet >= 19.0 && tempCopyAlphabet < 25.0 {
            scaledCopyAlphabet = 6.0
        }
        else if tempCopyAlphabet >= 25.0 && tempCopyAlphabet < 32.0 {
            scaledCopyAlphabet = 7.0
        }
        else if tempCopyAlphabet >= 32.0 && tempCopyAlphabet < 39.0 {
            scaledCopyAlphabet = 8.0
        }
        else if tempCopyAlphabet >= 39.0 && tempCopyAlphabet < 45.0 {
            scaledCopyAlphabet = 9.0
        }
        else if tempCopyAlphabet >= 45.0 && tempCopyAlphabet < 51.0 {
            scaledCopyAlphabet = 10.0
        }
        else if tempCopyAlphabet >= 51.0 && tempCopyAlphabet < 58.0 {
            scaledCopyAlphabet = 11.0
        }
        else if tempCopyAlphabet >= 58.0 && tempCopyAlphabet < 65.0 {
            scaledCopyAlphabet = 12.0
        }
        else if tempCopyAlphabet >= 65.0 && tempCopyAlphabet < 71.0 {
            scaledCopyAlphabet = 13.0
        }
        else if tempCopyAlphabet >= 71.0 && tempCopyAlphabet < 77.0 {
            scaledCopyAlphabet = 14.0
        }
        else if tempCopyAlphabet >= 77.0 && tempCopyAlphabet < 83.0 {
            scaledCopyAlphabet = 15.0
        }
        else if tempCopyAlphabet >= 83.0 && tempCopyAlphabet <= 90.0 {
            scaledCopyAlphabet = 16.0
        }
        else if tempCopyAlphabet > 90.0 {
            scaledCopyAlphabet = 17.0
        }
        else {
            scaledCopyAlphabet = 0.0
        }
    }
    
    mutating func standardiseFreeWriting() {
        let tempFreeWriting = freeWritingTotalWritten! / 5.0
        if tempFreeWriting > 25 {
            scaledFreeWriting = 17.0
        }
        else if tempFreeWriting < 4.0 {
            scaledFreeWriting = 3.0
        }
        else {
            switch tempFreeWriting {
            case 4.0:
                scaledFreeWriting = 4.0
            case 5.0:
                scaledFreeWriting = 4.0
            case 6.0:
                scaledFreeWriting = 5.0
            case 7.0:
                scaledFreeWriting = 5.0
            case 8.0:
                scaledFreeWriting = 6.0
            case 9.0:
                scaledFreeWriting = 7.0
            case 10.0:
                scaledFreeWriting = 7.0
            case 11.0:
                scaledFreeWriting = 8.0
            case 12.0:
                scaledFreeWriting = 9.0
            case 13.0:
                scaledFreeWriting = 9.0
            case 14.0:
                scaledFreeWriting = 10.0
            case 15.0:
                scaledFreeWriting = 10.0
            case 16.0:
                scaledFreeWriting = 11.0
            case 17.0:
                scaledFreeWriting = 12.0
            case 18.0:
                scaledFreeWriting = 12.0
            case 19.0:
                scaledFreeWriting = 13.0
            case 20.0:
                scaledFreeWriting = 14.0
            case 21.0:
                scaledFreeWriting = 14.0
            case 22.0:
                scaledFreeWriting = 15.0
            case 23.0:
                scaledFreeWriting = 15.0
            case 24.0:
                scaledFreeWriting = 16.0
            case 25.0:
                scaledFreeWriting = 16.0
            default:
                scaledFreeWriting = 0.0
            }
        }
    }
    
    mutating func standardiseFinalResultDash() {
        let tempFinalResult = scaledCopyBest! + scaledCopyFast! + scaledCopyAlphabet! + scaledFreeWriting!
        if tempFinalResult <= 16.0 {
            finalResultDash = 54.0
        }
        else {
            switch tempFinalResult {
            case 17.0:
                finalResultDash = 59.0
            case 18.0:
                finalResultDash = 62.0
            case 19.0:
                finalResultDash = 67.0
            case 20.0:
                finalResultDash = 70.0
            case 21.0:
                finalResultDash = 72.0
            case 22.0:
                finalResultDash = 74.0
            case 23.0:
                finalResultDash = 75.0
            case 24.0:
                finalResultDash = 76.0
            case 25.0:
                finalResultDash = 77.0
            case 26.0:
                finalResultDash = 79.0
            case 27.0:
                finalResultDash = 80.0
            case 28.0:
                finalResultDash = 82.0
            case 29.0:
                finalResultDash = 84.0
            case 30.0:
                finalResultDash = 86.0
            case 31.0:
                finalResultDash = 87.0
            case 32.0:
                finalResultDash = 89.0
            case 33.0:
                finalResultDash = 90.0
            case 34.0:
                finalResultDash = 92.0
            case 35.0:
                finalResultDash = 93.0
            case 36.0:
                finalResultDash = 94.0
            case 37.0:
                finalResultDash = 95.0
            case 38.0:
                finalResultDash = 97.0
            case 39.0:
                finalResultDash = 99.0
            case 40.0:
                finalResultDash = 100.0
            case 41.0:
                finalResultDash = 102.0
            case 42.0:
                finalResultDash = 104.0
            case 43.0:
                finalResultDash = 105.0
            case 44.0:
                finalResultDash = 106.0
            case 45.0:
                finalResultDash = 108.0
            case 46.0:
                finalResultDash = 109.0
            case 47.0:
                finalResultDash = 110.0
            case 48.0:
                finalResultDash = 111.0
            case 49.0:
                finalResultDash = 113.0
            case 50.0:
                finalResultDash = 114.0
            case 51.0:
                finalResultDash = 116.0
            case 52.0:
                finalResultDash = 118.0
            case 53.0:
                finalResultDash = 119.0
            case 54.0:
                finalResultDash = 121.0
            case 55.0:
                finalResultDash = 122.0
            case 56.0:
                finalResultDash = 123.0
            case 57.0:
                finalResultDash = 124.0
            case 58.0:
                finalResultDash = 126.0
            case 59.0:
                finalResultDash = 127.0
            case 60.0:
                finalResultDash = 129.0
            case 61.0:
                finalResultDash = 130.0
            case 62.0:
                finalResultDash = 133.0
            case 63.0:
                finalResultDash = 134.0
            case 64.0:
                finalResultDash = 135.0
            case 65.0:
                finalResultDash = 136.0
            case 66.0:
                finalResultDash = 138.0
            case 67.0:
                finalResultDash = 141.0
            case 68.0:
                finalResultDash = 146.0
            default:
                finalResultDash = 0.0
            }
        }
    }
}

