//
//  BPVSCalculations.swift
//  test
//
//  Created by Dominic Heaton on 17/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//


import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct BPVSCalculations {
    
    private var rawScore: Double?
    private var previousRawScore: Double?
    private var setBaselSet: Int?
    private var setCeilingSet: Int?
    private var numberOfErrorsMade = 0
    private var ceilingWordNumber: Int?
    private var finalCalculatedRawScore: Int?
    
    var setWordsToTest: [String] = ["ball", "bird", "ear", "running", "fork", "square", "water", "dog", "apple", "purple", "swimming", "coin", "finger", "fire", "helicopter", "turtle", "belt", "farmer", "toe", "house", "empty", "fence", "tunnel", "sad", "sitting", "panda", "sing", "coat", "nest", "ruler", "hiking", "mountain", "handle", "calendar", "climbing", "circle", "ring", "fountain", "branch", "knee", "sawing", "small", "sharing", "jewel", "zip", "feather", "spanner", "globe", "diving", "binoculars", "astronaut","target", "delivering", "desk", "jogging", "flying", "chimney", "waves", "violin", "chef", "floating", "harp", "neck", "map", "jewellery", "measuring", "dripping", "rough", "sorting", "brain", "island", "waistcoat"]
    
    var setWordsToTestAnswer: [Int] = [1, 3, 4, 1, 1, 3, 2, 4, 2, 1, 2, 3, 1, 1, 2, 3, 4, 1, 3, 2, 1, 1, 2, 3, 2, 1, 2, 2, 1, 4, 1, 3, 1, 3, 3, 1, 3, 2, 3, 4, 1, 1, 4, 1, 2, 3, 1, 3, 1, 1, 1, 4, 3, 1, 3, 3, 1, 1, 2, 1, 1, 2, 2, 4, 2, 3, 1, 4, 2, 1, 3, 1]
    
    var setImagesToTest: [UIImage] = [#imageLiteral(resourceName: "ball"), #imageLiteral(resourceName: "bird"), #imageLiteral(resourceName: "ear"), #imageLiteral(resourceName: "running"), #imageLiteral(resourceName: "fork"), #imageLiteral(resourceName: "square"), #imageLiteral(resourceName: "water"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "swimming"), #imageLiteral(resourceName: "coin"), #imageLiteral(resourceName: "finger"), #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "helicopter"), #imageLiteral(resourceName: "turtle"), #imageLiteral(resourceName: "belt"), #imageLiteral(resourceName: "farmer"), #imageLiteral(resourceName: "toe"), #imageLiteral(resourceName: "house"), #imageLiteral(resourceName: "empty"), #imageLiteral(resourceName: "fence"), #imageLiteral(resourceName: "tunnel"), #imageLiteral(resourceName: "sad"), #imageLiteral(resourceName: "sitting"), #imageLiteral(resourceName: "panda"), #imageLiteral(resourceName: "sing"), #imageLiteral(resourceName: "coat"), #imageLiteral(resourceName: "nest"), #imageLiteral(resourceName: "ruler"), #imageLiteral(resourceName: "hiking"), #imageLiteral(resourceName: "mountain"), #imageLiteral(resourceName: "handle"), #imageLiteral(resourceName: "calendar"), #imageLiteral(resourceName: "climbing"), #imageLiteral(resourceName: "circle"), #imageLiteral(resourceName: "ring"), #imageLiteral(resourceName: "fountain"), #imageLiteral(resourceName: "branch"), #imageLiteral(resourceName: "knee"), #imageLiteral(resourceName: "sawing"), #imageLiteral(resourceName: "small"), #imageLiteral(resourceName: "sharing"), #imageLiteral(resourceName: "jewel"), #imageLiteral(resourceName: "zip"), #imageLiteral(resourceName: "feather"), #imageLiteral(resourceName: "spanner"), #imageLiteral(resourceName: "global"), #imageLiteral(resourceName: "diving"), #imageLiteral(resourceName: "binoculars"), #imageLiteral(resourceName: "astronaut"), #imageLiteral(resourceName: "target"), #imageLiteral(resourceName: "delivering"), #imageLiteral(resourceName: "desk"), #imageLiteral(resourceName: "jogging"), #imageLiteral(resourceName: "flying"), #imageLiteral(resourceName: "chimney"), #imageLiteral(resourceName: "waves"), #imageLiteral(resourceName: "violin"), #imageLiteral(resourceName: "chef"), #imageLiteral(resourceName: "floating"), #imageLiteral(resourceName: "harp"), #imageLiteral(resourceName: "neck"), #imageLiteral(resourceName: "map"), #imageLiteral(resourceName: "jewellery"), #imageLiteral(resourceName: "measuring"), #imageLiteral(resourceName: "dripping"), #imageLiteral(resourceName: "rough"), #imageLiteral(resourceName: "sorting"), #imageLiteral(resourceName: "brain"), #imageLiteral(resourceName: "island"), #imageLiteral(resourceName: "waistcoat")]
    
    mutating func zeroScore() {
        previousRawScore = 0
        rawScore = 0
    }
    
    mutating func setBaselSet(_ setNumber: Int) {
        setBaselSet = setNumber
        print("Basel Set: ", setBaselSet!)
    }
    
    mutating func setCeilingSet(_ setNumber: Int) {
        setCeilingSet = setNumber
        print("Ceiling Set: ", setCeilingSet!)
    }
    
    mutating func setCeilingWordNumber(_ wordNumber: Int) {
        ceilingWordNumber = wordNumber + 1
    }
    
    func getNumberOfErrorsMade() -> Int {
        return numberOfErrorsMade
    }
    
    mutating func updateRawScore(_ answer: String) {
        if answer == "correct" {
            previousRawScore = rawScore!
            rawScore = rawScore! + 1.0
        }
        else if answer == "incorrect" {
            previousRawScore = rawScore!
            rawScore = rawScore!
            numberOfErrorsMade += 1
        }
        
        //For debugging
        print("Current Prev. Score: ", previousRawScore!)
        print("Current Raw  Score : ", rawScore!)
        print("Total Errors Made  : ", numberOfErrorsMade)
    }
    
    mutating func calculateResult() -> Int {
        finalCalculatedRawScore = ceilingWordNumber! - numberOfErrorsMade
        return finalCalculatedRawScore!
    }

}

