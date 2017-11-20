//
//  BPVS.swift
//  test
//
//  Created by Dominic Heaton on 17/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BPVS: UIViewController {
    
    var wordsToTest: [String] = []
    var wordsToTestAnswer: [Int] = []
    var imagesToTest: [UIImage] = []
    var initialWord = 72 //starts the wordsToTest array at the set of words for age 9-11
    var currentWord: Int?
    var wordToTestAnswer: Int?
    var imageToTest: UIImage?
    var errorsInSet = 0 //errors made within the set
    var numberWordInSet = 1 //words in set numbered from 1 to 12
    var sets = [1,2,3,4,5,6,7,8,9,10,11,12,13,14] //Available sets
    var setSelector = 6 //Used to select set 7 to begin with
    var setInUse: Int?
    var previousSetInUse: Int?
    var findingBaselSet: Bool?
    var setsDeleted = 0
    var finalResultBPVS: Int?
    
    private var brain = BPVSCalculations()
    
    @IBOutlet weak var wordToTest: UILabel!
    @IBOutlet weak var imageLoaded: UIImageView!
    
    //Function to hide back button from navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Test: BPVS 3"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInUse = sets.remove(at: setSelector) //Load set 7 as default for age 10-11
        setsDeleted += 1
        
        //For debugging
        print("Initial Set Loaded: ", setInUse!)
        
        wordsToTest = brain.setWordsToTest
        wordsToTestAnswer = brain.setWordsToTestAnswer
        imagesToTest = brain.setImagesToTest
        
        loadInitialWord()
        findingBaselSet = true
        
        brain.zeroScore()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BPVSCompleted
        nextVC.finalResultBPVS = Double(finalResultBPVS!)
        nextVC.finalErrorsBPVS = Double(brain.getNumberOfErrorsMade())
        nextVC.finalSetBPVS = Double(setInUse!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 1 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }
        
        loadWord()
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 2 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }
        
        loadWord()
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 3 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }

        loadWord()
    }
    
    @IBAction func button4Pressed(_ sender: UIButton) {
        if wordsToTestAnswer[currentWord!] == 4 {
            brain.updateRawScore("correct")
        }
        else {
            brain.updateRawScore("incorrect")
            errorsInSet += 1
        }

        loadWord()
    }
    
    func loadInitialWord() {
        wordToTest.text! = wordsToTest[initialWord]
        wordToTestAnswer = wordsToTestAnswer[initialWord]
        imageToTest = imagesToTest[initialWord]
        currentWord = initialWord
        loadPicture()
    }
    
    func loadWord() {
        previousSetInUse = setInUse!
        
        if findingBaselSet == true {
            if numberWordInSet == 12 {
                if errorsInSet > 1 {
                    setSelector -= 1
                    setInUse = sets.remove(at: (setSelector))
                    setsDeleted += 1
                    
                    //For debugging
                    print("Sets: ", sets)
                    print("Errors in set: ", errorsInSet)
                    print("Finding Basel - Set decremented to: ", setInUse!)
                    
                    errorsInSet = 0
                    numberWordInSet = 1
                }
                else if errorsInSet < 2 {
                    brain.setBaselSet(setInUse!)
                    findingBaselSet = false
                    errorsInSet = 0
                    setInUse = sets[setSelector]
                    setsDeleted += 1
                    
                    //For debugging
                    print("Now testing Set: ", setInUse!)
                    
                    numberWordInSet = 1
                }
            }
            else if numberWordInSet < 13 {
                numberWordInSet += 1
            }
        }
        else {
            if numberWordInSet == 12 {
                if errorsInSet < 8 {
                    setSelector += 1
                    setInUse = sets[setSelector]
                    setsDeleted += 1
                    
                    //For debugging
                    print("Set incremented: ", setInUse!)
                    
                    numberWordInSet = 1
                    errorsInSet = 0
                }
                else {
                    brain.setCeilingSet(setInUse!)
                    endTest()
                }
            }
            else if numberWordInSet < 13 {
                numberWordInSet += 1
            }
        }

        if previousSetInUse! > setInUse! { //set has decreased
            currentWord = currentWord! - 23
            
        }
        else if previousSetInUse == setInUse {//set unchanged
            if numberWordInSet < 13 {
                currentWord! += 1
            }
        }
        else if previousSetInUse! < setInUse! {
            currentWord = currentWord! + 1 + ((setInUse! - previousSetInUse!)-1)*12
        }
        
        //For debugging
        print("numberWordInSet: ", numberWordInSet)

        wordToTest.text! = wordsToTest[currentWord!]
        wordToTestAnswer = wordsToTestAnswer[currentWord!]
        imageToTest = imagesToTest[currentWord!]
        loadPicture()
    }
    
    func loadPicture() {
        imageLoaded.image = imageToTest
    }
    
    func endTest() {
        //For debugging
        print("Test Finished")
        
        brain.setCeilingWordNumber(currentWord!)
        finalResultBPVS = brain.calculateResult()
        performSegue(withIdentifier: "toBPVScompleted", sender: nil)
    }
    
}
