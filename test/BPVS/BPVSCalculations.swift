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
    
    var setWordsToTest: [String] = ["ball", "duck", "mouth", "jumping", "spoon", "circle", "drinking", "cat", "apple", "blue", "swimming", "money", "toe", "fire", "aeroplane", "tortoise", "belt", "farmer", "thumb", "castle", "empty", "fence", "tunnel", "happy", "dancing", "panda", "whistle", "dressing", "nest", "ruler", "hopping", "mountain", "hook", "calendar", "juggling", "rectangle", "ring", "fountain", "branch", "elbow", "sawing", "gigantic", "sharing", "diamond", "zip", "feather", "spanner", "globe", "diving", "target", "delivering", "desk", "jogging", "binoculars", "astronaut", "map", "jewellery", "measuring", "terrified", "chimney", "tearing", "package", "rough", "violin", "chef", "floating", "harp", "ankle", "dripping", "vehicle", "sorting", "brain", "island", "waistcoat", "tugging", "pelvis", "avocado", "banister", "tubular", "pillar", "grooming", "hyena", "canoe", "hive", "towing", "links", "adjustable", "funnel", "valley", "greeting", "solo", "harvesting", "antlers", "tropical", "currency", "hurdling", "fictional", "luggage", "applauding", "inflated", "arctic", "hovering", "pedestrian", "snarling", "exhausted", "construction", "aquarium", "beaker", "canine", "clamp", "parallel", "bouquet", "polluting", "valve", "illumination", "nutritious", "departing", "trowel", "escorting", "wedge", "archaeologist", "duet", "fungus", "hoisting", "foundation", "rodent", "interior", "citrus", "feline", "coast", "detonation", "embracing", "garment", "capsules", "aviation", "consuming", "primate", "ascending", "beverage", "goblet", "tuba", "carpenter", "appliance", "incisor", "lever", "oasis", "talon", "lubricating", "easel", "angler", "perplexed", "cultivating", "maritime", "culinary", "sedan", "marsupial", "fowl", "encumbered", "castor", "bovine", "replenishing", "convex", "embossed", "incarcerating", "copious", "incandescent", "lacrimation", "apparel"]
    
    var setWordsToTestAnswer: [Int] = [3, 3, 1, 3, 1, 4, 1, 2, 4, 2, 4, 3, 4, 1, 1, 1, 3, 3, 1, 2, 2, 3, 2, 3, 3, 1, 1, 3, 4, 1, 1, 2, 4, 4, 4, 2, 4, 3, 4, 4, 3, 4, 2, 1, 2, 1, 3, 2, 2, 2, 4, 3, 4, 3, 3, 3, 1, 1, 3, 4, 4, 3, 3, 1, 1, 3, 1, 4, 4, 4, 1, 2, 1, 3, 2, 2, 1, 2, 1, 2, 4, 4, 2, 1, 1, 2, 2, 2, 1, 1, 4, 1, 3, 2, 3, 3, 1, 2, 3, 3, 2, 1, 3, 2, 2, 2, 1, 3, 1, 1, 4, 2, 3, 3, 4, 3, 3, 4, 4, 4, 1, 1, 3, 1, 1, 3, 1, 2, 2, 4, 2, 3, 4, 4, 1, 3, 1, 2, 1, 4, 1, 2, 1, 3, 2, 4, 3, 1, 4, 1, 2, 1, 1, 3, 1, 4, 4, 3, 3, 1, 3, 1, 2, 2, 2, 4, 1, 4]
    
    var setImagesToTest: [UIImage] = [#imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"),#imageLiteral(resourceName: "tearing"), #imageLiteral(resourceName: "package"), #imageLiteral(resourceName: "rough"), #imageLiteral(resourceName: "violin"), #imageLiteral(resourceName: "chef"), #imageLiteral(resourceName: "floating"), #imageLiteral(resourceName: "harp"), #imageLiteral(resourceName: "ankle"), #imageLiteral(resourceName: "dripping"), #imageLiteral(resourceName: "vehicle"), #imageLiteral(resourceName: "sorting"), #imageLiteral(resourceName: "brain"), #imageLiteral(resourceName: "island"), #imageLiteral(resourceName: "waistcoat"), #imageLiteral(resourceName: "tugging"), #imageLiteral(resourceName: "pelvis"), #imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "banister"), #imageLiteral(resourceName: "tubular"), #imageLiteral(resourceName: "pillar"), #imageLiteral(resourceName: "grooming"), #imageLiteral(resourceName: "hyena"), #imageLiteral(resourceName: "canoe"), #imageLiteral(resourceName: "hive"), #imageLiteral(resourceName: "towing"), #imageLiteral(resourceName: "links"), #imageLiteral(resourceName: "adjustable"), #imageLiteral(resourceName: "funnel"), #imageLiteral(resourceName: "valley"), #imageLiteral(resourceName: "greeting"), #imageLiteral(resourceName: "solo"), #imageLiteral(resourceName: "harvesting"), #imageLiteral(resourceName: "antlers"), #imageLiteral(resourceName: "tropical"), #imageLiteral(resourceName: "currency"), #imageLiteral(resourceName: "hurdling"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound"), #imageLiteral(resourceName: "nonFound")]
    
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

