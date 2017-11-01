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
//    var testScore: Double?
    
    var testTowreSWE: Double?
    var testTowrePDE: Double?
    
    init(name: String?, testName: String?/*, testScore: Double?*/, testTowreSWE: Double?, testTowrePDE: Double?){
        self.name = name
        self.testName = testName
//        self.testScore = testScore
        self.testTowreSWE = testTowreSWE
        self.testTowrePDE = testTowrePDE
    }
    
}
