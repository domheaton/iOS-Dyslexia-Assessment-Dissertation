//
//  TestResults.swift
//  test
//
//  Created by Dominic Heaton on 25/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

class TestResults {
    
    var name: String?
    var testName: String?
    
    var testTowreSWE: Double?
    var testTowrePDE: Double?
    var testDigitSpan: Double?
    var testRevDigitSpan: Double?
    
    init(name: String?, testName: String?, testTowreSWE: Double?, testTowrePDE: Double?, testDigitSpan: Double?, testRevDigitSpan: Double?){
        self.name = name
        self.testName = testName
        self.testTowreSWE = testTowreSWE
        self.testTowrePDE = testTowrePDE
        self.testDigitSpan = testDigitSpan
        self.testRevDigitSpan = testRevDigitSpan
    }
    
}
