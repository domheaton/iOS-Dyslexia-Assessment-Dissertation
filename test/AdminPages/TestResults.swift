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
    var testTowre2: Double?
    var testForwardDigitSpan: Double?
    var testRevDigitSpan: Double?
    var testDigitSpan: Double?
    var testDashBest: Double?
    var testDashFast: Double?
    var testDashAlpha: Double?
    var testDashFree: Double?
    var testDashFinal: Double?
    
    init(name: String?, testName: String?, testTowreSWE: Double?, testTowrePDE: Double?, testTowre2: Double?, testForwardDigitSpan: Double?, testRevDigitSpan: Double?, testDigitSpan: Double?, testDashBest: Double?, testDashFast: Double?, testDashAlpha: Double?, testDashFree: Double?, testDashFinal: Double?) {
        self.name = name
        self.testName = testName
        self.testTowreSWE = testTowreSWE
        self.testTowrePDE = testTowrePDE
        self.testTowre2 = testTowre2
        self.testForwardDigitSpan = testForwardDigitSpan
        self.testRevDigitSpan = testRevDigitSpan
        self.testDigitSpan = testDigitSpan
        self.testDashBest = testDashBest
        self.testDashFast = testDashFast
        self.testDashAlpha = testDashAlpha
        self.testDashFree = testDashFree
        self.testDashFinal = testDashFinal
    }
    
}
