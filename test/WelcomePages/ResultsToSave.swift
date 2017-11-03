//
//  ResultsToSave.swift
//  test
//
//  Created by Dominic Heaton on 03/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

class ResultsToSave {
    
    var name: String?
    var testTowreSWE: Double?
    var testTowrePDE: Double?
    var testDigitSpan: Double?
    var testRevDigitSpan: Double?
    
    init(name: String?, testDigitSpan: Double?, testRevDigitSpan: Double?){
        self.name = name
        self.testDigitSpan = testDigitSpan
        self.testRevDigitSpan = testRevDigitSpan
    }
    
    init(name: String?, testTowreSWE: Double?, testTowrePDE: Double?) {
        self.name = name
        self.testTowreSWE = testTowreSWE
        self.testTowrePDE = testTowrePDE
    }
}
