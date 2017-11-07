//
//  IndepthCalculations.swift
//  test
//
//  Created by Dominic Heaton on 07/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct IndepthCalculations {
    
    private var getDigitSpan: Double
    private var digitSpanPercentile: String
    
    func returnDigitSpanPercentile() -> String {
        return digitSpanPercentile
    }
    
    mutating func getDigitSpanPercentile() {
        if getDigitSpan >= 145 {
            digitSpanPercentile = "99.9%"
        }
        else {
            switch getDigitSpan {
            case 54.0:
                digitSpanPercentile = "0.1%"
            case 55.0:
                digitSpanPercentile = "0.1%"
            case 56.0:
                digitSpanPercentile = "0.2%"
            case 57.0:
                digitSpanPercentile = "0.2%"
            case 58.0:
                digitSpanPercentile = "0.3%"
            case 59.0:
                digitSpanPercentile = "0.3%"
            case 60.0:
                digitSpanPercentile = "0.4%"
            case 61.0:
                digitSpanPercentile = "0.5%"
            case 62.0:
                digitSpanPercentile = "0.6%"
            case 63.0:
                digitSpanPercentile = "0.7%"
            case 64.0:
                digitSpanPercentile = "0.8%"
            case 65.0:
                digitSpanPercentile = "1%"
            case 66.0:
                digitSpanPercentile = "1%"
            case 67.0:
                digitSpanPercentile = "1%"
            case 68.0:
                digitSpanPercentile = "2%"
            case 69.0:
                digitSpanPercentile = "2%"
            case 70.0:
                digitSpanPercentile = "2%"
            case 71.0:
                digitSpanPercentile = "3%"
            case 72.0:
                digitSpanPercentile = "3%"
            case 73.0:
                digitSpanPercentile = "4%"
            case 74.0:
                digitSpanPercentile = "4%"
            case 75.0:
                digitSpanPercentile = "5%"
            case 76.0:
                digitSpanPercentile = "5%"
            case 77.0:
                digitSpanPercentile = "6%"
            case 78.0:
                digitSpanPercentile = "7%"
            case 79.0:
                digitSpanPercentile = "8%"
            case 80.0:
                digitSpanPercentile = "9%"
            case 81.0:
                digitSpanPercentile = "10%"
            case 82.0:
                digitSpanPercentile = "12%"
            case 83.0:
                digitSpanPercentile = "13%"
            case 84.0:
                digitSpanPercentile = "14%"
            case 85.0:
                digitSpanPercentile = "16%"
            case 86.0:
                digitSpanPercentile = "18%"
            case 87.0:
                digitSpanPercentile = "19%"
            case 88.0:
                digitSpanPercentile = "21%"
            case 89.0:
                digitSpanPercentile = "23%"
            case 90.0:
                digitSpanPercentile = "25%"
            case 91.0:
                digitSpanPercentile = "27%"
            case 92.0:
                digitSpanPercentile = "30%"
            case 93.0:
                digitSpanPercentile = "32%"
            case 94.0:
                digitSpanPercentile = "34%"
            case 95.0:
                digitSpanPercentile = "37%"
            case 96.0:
                digitSpanPercentile = "39%"
            case 97.0:
                digitSpanPercentile = "42%"
            case 98.0:
                digitSpanPercentile = "45%"
            case 99.0:
                digitSpanPercentile = "47%"
            case 100.0:
                digitSpanPercentile = "50%"
            case 101.0:
                digitSpanPercentile = "53%"
            case 102.0:
                digitSpanPercentile = "55%"
            case 103.0:
                digitSpanPercentile = "58%"
            case 104.0:
                digitSpanPercentile = "61%"
            case 105.0:
                digitSpanPercentile = "63%"
            case 106.0:
                digitSpanPercentile = "66%"
            case 107.0:
                digitSpanPercentile = "68%"
            case 108.0:
                digitSpanPercentile = "70%"
            case 109.0:
                digitSpanPercentile = "73%"
            case 110.0:
                digitSpanPercentile = "75%"
            case 111.0:
                digitSpanPercentile = "77%"
            case 112.0:
                digitSpanPercentile = "79%"
            case 113.0:
                digitSpanPercentile = "81%"
            case 114.0:
                digitSpanPercentile = "82%"
            case 115.0:
                digitSpanPercentile = "84%"
            case 116.0:
                digitSpanPercentile = "86%"
            case 117.0:
                digitSpanPercentile = "87%"
            case 118.0:
                digitSpanPercentile = "88%"
            case 119.0:
                digitSpanPercentile = "90%"
            case 120.0:
                digitSpanPercentile = "91%"
            case 121.0:
                digitSpanPercentile = "92%"
            case 122.0:
                digitSpanPercentile = "93%"
            case 123.0:
                digitSpanPercentile = "94%"
            case 124.0:
                digitSpanPercentile = "95%"
            case 125.0:
                digitSpanPercentile = "95%"
            case 126.0:
                digitSpanPercentile = "96%"
            case 127.0:
                digitSpanPercentile = "96%"
            case 128.0:
                digitSpanPercentile = "97%"
            case 129.0:
                digitSpanPercentile = "97%"
            case 130.0:
                digitSpanPercentile = "98%"
            case 131.0:
                digitSpanPercentile = "98%"
            case 132.0:
                digitSpanPercentile = "98%"
            case 133.0:
                digitSpanPercentile = "99%"
            case 134.0:
                digitSpanPercentile = "99%"
            case 135.0:
                digitSpanPercentile = "99%"
            case 136.0:
                digitSpanPercentile = "99.2%"
            case 137.0:
                digitSpanPercentile = "99.3%"
            case 138.0:
                digitSpanPercentile = "99.4%"
            case 139.0:
                digitSpanPercentile = "99.5%"
            case 140.0:
                digitSpanPercentile = "99.6%"
            case 141.0:
                digitSpanPercentile = "99.7%"
            case 142.0:
                digitSpanPercentile = "99.7%"
            case 143.0:
                digitSpanPercentile = "99.8%"
            case 144.0:
                digitSpanPercentile = "99.8%"
            default:
                digitSpanPercentile = "0%"
            }
        }
    }
    
}
