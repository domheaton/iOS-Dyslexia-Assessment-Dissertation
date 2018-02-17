//
//  Towre.swift
//  test
//
//  Created by Dominic Heaton on 21/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CryptoSwift

class Towre: UIViewController {
    
    //Encryption Variables
    var key: Array<UInt8> = []
    var generatedKey: [UInt8]?
    let iv: Array<UInt8> = [0x26,0x54,0x72,0x45,0x77,0x27,0x99,0x57,036,0x34,0x37,0x66,0x11,0x10,0x73,0x98]
    var ciphertext: [UInt8] = []
    var encrypted: [UInt8]?
    
    var wordsToTest: [String] = []
    var counter = 0
    var timer = Timer()
    var time = 0
    
    private var brain = TowreBrain()
    
    @IBOutlet weak var wordToTest: UILabel!
    
    //Function to hide back button from navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 1: Sight Word Efficiency"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check the user's secure key has been loaded (is not nil)
        if key == [] {
            key = generateKey(Auth.auth().currentUser!.email!)
            
            //For debugging
            print("Secure Key: ", key)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Towre.checkTimeElapsed), userInfo: nil, repeats: true)
        wordsToTest = brain.setWordsToTestSWE
        brain.setNumberOfWords(Double(wordsToTest.count))
        brain.zeroScore()
        loadWord()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nextVC = segue.destination as! TowreSubtestPageController
//            nextVC.finalResultsSWE = brain.getFinalResults()
//            nextVC.scaledResultSWE = brain.getScaledScoreSWE()
        
         saveResults()
    }
    
    func saveResults() {
        var refDatabase: DatabaseReference!
        refDatabase = Database.database().reference().child("intermediateResults").child("user")
        
//        let userName = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        let key = refDatabase.child(uid!).key
        
        var userResults: [String : Any]
        
            userResults = ["finalResultsSWE".sha1():aesEncrypt(String(brain.getFinalResults())), "scaledResultSWE".sha1():aesEncrypt(String(brain.getScaledScoreSWE()))] as [String : Any]
        refDatabase.child(key).updateChildValues(userResults)
        print("Saved to Firebase")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctPressed(_ sender: UIButton) {
        brain.updateRawScore("correct")
        loadWord()
    }
    
    @IBAction func incorrectPressed(_ sender: UIButton) {
        brain.updateRawScore("incorrect")
        loadWord()
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
        if counter >= 2 {
            counter = counter - 2
            wordToTest.text = wordsToTest[counter]
            brain.setRawScore()
            counter = counter + 1
        }
    }
    
    //Function to increment timer - ends test after 45 Seconds -- Objective-C function call
    @objc func checkTimeElapsed() {
        if time < 45 { 
            time += 1
        }
        else {
            //For debugging
            print("Timer Expired")
            
            timer.invalidate()
            time = 0
            brain.calculateResult()
            performSegue(withIdentifier: "toTowreSubtest", sender: nil)
        }
    }
    
    //Function to load next word from array - or finish test if list completed
    func loadWord() {
        if counter < wordsToTest.count {
            wordToTest.text = wordsToTest[counter]
            counter = counter + 1
        }
        else {
            brain.calculateResult()
            timer.invalidate()
            performSegue(withIdentifier: "toTowreSubtest", sender: nil)
        }
    }
    
    //AES Encryption
    func aesEncrypt(_ value: String) -> [UInt8] {
        let input = Array(value.utf8)
        
        do {
            //encrypt using AES
            encrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).encrypt(input)
        } catch {
            print(error)
        }
        return encrypted!
    }
    
    //Generate the secure key for the user
    func generateKey(_ username: String) -> [UInt8] {
        let password: Array<UInt8> = Array(username.utf8)
        let salt: Array<UInt8> = Array("dominicheaton".utf8)
        
        do {
            generatedKey = try PKCS5.PBKDF2(password: password, salt: salt, iterations: 4096, variant: .sha256).calculate()
        } catch {
            print(error)
        }
        
        return generatedKey!
    }

}

