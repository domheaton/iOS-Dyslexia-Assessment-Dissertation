//
//  TowrePDE.swift
//  test
//
//  Created by Dominic Heaton on 24/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CryptoSwift

class TowrePDE: UIViewController {
    
    //Encryption Variables
    var key: Array<UInt8> = []
    var generatedKey: [UInt8]?
    let iv: Array<UInt8> = [0x26,0x54,0x72,0x45,0x77,0x27,0x99,0x57,036,0x34,0x37,0x66,0x11,0x10,0x73,0x98]
    var ciphertext: [UInt8] = []
    
    var wordsToTest: [String] = []
    var counter = 0
    var timer2 = Timer()
    var time = 0
    
    let uid = Auth.auth().currentUser?.uid
    
    var finalResultsSWE = Double()
    var scaledResultSWE = Double()
    
    private var brain = TowreBrainPDE()
    
    @IBOutlet weak var wordToTestPDE: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! TestCompleted
        nextVC.finalResultsSWE = brain.getFinalResultsSWE()
        nextVC.finalResultsPDE = brain.getFinalResultsPDE()
        nextVC.finalResultsTowre = brain.getFinalScaledTowre()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check the user's secure key has been loaded (is not nil)
        if key == [] {
            key = generateKey(Auth.auth().currentUser!.email!)
            
            //For debugging
            print("Secure Key: ", key)
        }
        
        //Fetch SWE results from firebase
        getTowreSWEresults()
//        print("finalResultsSWE: ", finalResultsSWE)
//        print("scaledResultSWE: ", scaledResultSWE)
        
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TowrePDE.checkTimeElapsed), userInfo: nil, repeats: true)
        wordsToTest = brain.setWordsToTestPDE
        brain.setNumberOfWords(Double(wordsToTest.count))
        brain.zeroScore()
//        brain.setFinalResultsSWE(finalResultsSWE)
//        brain.setScaledScoreSWE(scaledResultSWE)
        
        //For debugging
        print("TowreSWE: ", finalResultsSWE)

        loadWord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 2: Phonemic Decoding Efficiency"
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
            wordToTestPDE.text = wordsToTest[counter]
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
            
            timer2.invalidate()
            time = 0
            brain.calculateResult()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
    
    //Function to load next word from array - or finish test if list completed
    func loadWord() {
        if counter < wordsToTest.count {
            wordToTestPDE.text = wordsToTest[counter]
            counter = counter + 1
        }
        else {
            brain.calculateResult()
            timer2.invalidate()
            performSegue(withIdentifier: "towreToTestCompleted", sender: nil)
        }
    }
    
    func getTowreSWEresults() {
        let dbRef = Database.database().reference().child("intermediateResults").child("user").child(uid!)
        dbRef.child("e46a4ae21385ca0fa7be3552e9c2a91caf423f2e").observeSingleEvent(of: .value) {
            (snapshot) in
            if let finalSWE = snapshot.value as? AnyObject {
//                self.finalResultsSWE = finalSWE
                self.brain.setFinalResultsSWE(self.aesDecryptResult(finalSWE as? [UInt8] ?? Array("0".utf8), self.key)!)
            }
        }
        dbRef.child("cadc3ac6af74c083f9699d3ef2ad30524e7fec2c").observeSingleEvent(of: .value) {
            (snapshot) in
            if let scaledSWE = snapshot.value as? AnyObject {
//                self.finalResultsSWE = scaledSWE
                self.brain.setScaledScoreSWE(self.aesDecryptResult(scaledSWE as? [UInt8] ?? Array("0".utf8), self.key)!)
            }
        }
    }
    
    //AES Decryption
    func aesDecryptResult(_ resultToDecrypt: [UInt8],_ downloadedKey: [UInt8]) -> Double? {
        var decryptedResult: String?
        var decryptedResultDouble: Double?
        do {
            
            //Decrypt using AES
            //            let decrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(username)
            let decrypted = try AES(key: downloadedKey, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(resultToDecrypt)
            
            //From UInt8 to String
            decryptedResult = (String(bytes: Data(decrypted), encoding: .utf8))
            
            //From String to Double
            decryptedResultDouble = Double(decryptedResult!)
            
        } catch {
            print(error)
        }
        return decryptedResultDouble
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
