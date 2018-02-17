//
//  Menu.swift
//  test
//
//  Created by Dominic Heaton on 22/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CryptoSwift

class Menu: UIViewController {
    
    //Encryption Variables
    var key: Array<UInt8> = []
    var generatedKey: [UInt8]?
    let iv: Array<UInt8> = [0x26,0x54,0x72,0x45,0x77,0x27,0x99,0x57,036,0x34,0x37,0x66,0x11,0x10,0x73,0x98]
    var ciphertext: [UInt8] = []
    var encrypted: [UInt8]?

    var finalResultsSWE = Double()
    var finalResultsPDE = Double()
    var finalResultsTowre = Double()
    
    var finalResultsDigit = Double()
    var finalResultsRevDigit = Double()
    var finalResultsDigitSpan = Double()
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    var copyAlphabetTotalWritten = Double()
    var freeWritingTotalWritten = Double()
    var finalResultDash = Double()
    
    var finalResultBPVS = Double()
    var finalErrorsBPVS = Double()
    var finalSetBPVS = Double()
    
    //Encrypted Variables for Upload
    var finalResultsDigitSpanUpload: [UInt8] = []       //Digit Span Combined
    var finalResultsDigitUpload: [UInt8] = []           //Forward Digit Span
    var finalResultsRevDigitUpload: [UInt8] = []        //Reverse Digit Span
    var finalResultsSWEUpload: [UInt8] = []             //Towre SWE
    var finalResultsPDEUpload: [UInt8] = []             //Towre PDE
    var finalResultsTowreUpload: [UInt8] = []           //Towre 2
    var copyBestWordsWrittenUpload: [UInt8] = []        //DASH Copy Best
    var copyFastWordsWrittenUpload: [UInt8] = []        //DASH Copy Fast
    var copyAlphabetTotalWrittenUpload: [UInt8] = []    //DASH Copy Alphabet
    var freeWritingTotalWrittenUpload: [UInt8] = []     //DASH Free Writing
    var finalResultDashUpload: [UInt8] = []             //DASH Final
    var finalResultBPVSUpload: [UInt8] = []             //Word Association Final
    var finalErrorsBPVSUpload: [UInt8] = []             //Word Association Errors Made
    var finalSetBPVSUpload: [UInt8] = []                //Word Association Set Number
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check the user's secure key has been loaded (is not nil)
        if key == [] {
            key = generateKey(Auth.auth().currentUser!.email!)
            
            //For debugging
            print("Secure Key: ", key)
        }
        
        //For debugging
        print("SWE        :", finalResultsSWE)
        print("PDE        :", finalResultsPDE)
        print("Towre      :", finalResultsTowre)
        print("For D      :", finalResultsDigit)
        print("Rev D      :", finalResultsRevDigit)
        print("Span       :", finalResultsDigitSpan)
        print("CopyB      :", copyBestWordsWritten)
        print("CopyF      :", copyFastWordsWritten)
        print("CopyA      :", copyAlphabetTotalWritten)
        print("FreeW      :", freeWritingTotalWritten)
        print("DASH       :", finalResultDash)
        print("BPVS Raw   :", finalResultBPVS)
        print("BPVS Errors:", finalErrorsBPVS)
        print("BPVS Set No:", finalSetBPVS)
        
        //override the back button in the navigation controller
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(self.signOut(sender:)))
        
        let testScoresToSave: [Double]! = [finalResultsSWE, finalResultsPDE, finalResultsDigit, finalResultsRevDigit, finalResultsTowre, finalResultsDigitSpan, copyBestWordsWritten, copyFastWordsWritten, copyAlphabetTotalWritten, freeWritingTotalWritten, finalResultDash, finalResultBPVS, finalErrorsBPVS, finalSetBPVS]
        
        if testScoresToSave[0] != 0 || testScoresToSave[1] != 0 || testScoresToSave[2] != 0 || testScoresToSave[3] != 0 || testScoresToSave[4] != 0 || testScoresToSave[5] != 0 || testScoresToSave[6] != 0 || testScoresToSave[7] != 0 || testScoresToSave[8] != 0 || testScoresToSave[9] != 0 || testScoresToSave[10] != 0 || testScoresToSave[11] != 0 || testScoresToSave[12] != 0 || testScoresToSave[13] != 0 {
            
            //Encrypt Scores for Upload to Firebase
            finalResultsDigitSpanUpload = aesEncrypt(String(finalResultsDigitSpan))
            finalResultsDigitUpload = aesEncrypt(String(finalResultsDigit))
            finalResultsRevDigitUpload = aesEncrypt(String(finalResultsRevDigit))
            finalResultsSWEUpload = aesEncrypt(String(finalResultsSWE))
            finalResultsPDEUpload = aesEncrypt(String(finalResultsPDE))
            finalResultsTowreUpload = aesEncrypt(String(finalResultsTowre))
            copyBestWordsWrittenUpload = aesEncrypt(String(copyBestWordsWritten))
            copyFastWordsWrittenUpload = aesEncrypt(String(copyFastWordsWritten))
            copyAlphabetTotalWrittenUpload = aesEncrypt(String(copyAlphabetTotalWritten))
            freeWritingTotalWrittenUpload = aesEncrypt(String(freeWritingTotalWritten))
            finalResultDashUpload = aesEncrypt(String(finalResultDash))
            finalResultBPVSUpload = aesEncrypt(String(finalResultBPVS))
            finalErrorsBPVSUpload = aesEncrypt(String(finalErrorsBPVS))
            finalSetBPVSUpload = aesEncrypt(String(finalSetBPVS))
            
            saveResults()
        }

    }
    
    func saveResults() {
        var refDatabase: DatabaseReference!
        refDatabase = Database.database().reference().child("results").child("user")

        //uploading key to Firebase
        let userCode = key
        
//        let userName = Auth.auth().currentUser?.email
        let userName = aesEncrypt((Auth.auth().currentUser?.email)!)
        let uid = Auth.auth().currentUser?.uid
        let userKey = refDatabase.child(uid!).key
        
        var userResults: [String : Any]
        
        if finalResultsTowre == 0 && finalResultDash == 0 && finalResultBPVS == 0 {
            userResults = ["username".sha1():userName, "Forward Digit Span".sha1():finalResultsDigitUpload, "Reverse Digit Span".sha1():finalResultsRevDigitUpload, "Digit Span".sha1():finalResultsDigitSpanUpload, "UserCode".sha1():userCode] as [String : Any]
        }
        else if finalResultsDigitSpan == 0 && finalResultDash == 0 && finalResultBPVS == 0 {
            userResults = ["username".sha1():userName, "TowreSWE".sha1():finalResultsSWEUpload, "TowrePDE".sha1():finalResultsPDEUpload, "Towre-2".sha1():finalResultsTowreUpload, "UserCode".sha1():userCode] as [String : Any]
        }
        else if finalResultsDigitSpan == 0 && finalResultsTowre == 0 && finalResultBPVS == 0 {
            userResults = ["username".sha1():userName, "Dash CopyBest".sha1():copyBestWordsWrittenUpload, "Dash CopyFast".sha1():copyFastWordsWrittenUpload, "Dash CopyAlpha".sha1():copyAlphabetTotalWrittenUpload, "Dash Free".sha1():freeWritingTotalWrittenUpload, "Dash Final".sha1():finalResultDashUpload, "UserCode".sha1():userCode] as [String : Any]
        }
        else if finalResultsTowre == 0 && finalResultDash == 0 && finalResultsDigitSpan == 0 {
            userResults = ["username".sha1():userName, "BPVS Final".sha1():finalResultBPVSUpload, "BPVS Errors".sha1():finalErrorsBPVSUpload, "BPVS Set Num".sha1():finalSetBPVSUpload, "UserCode".sha1():userCode] as [String : Any]
        }
        else {
            userResults = ["username".sha1():userName, "TowreSWE".sha1():finalResultsSWEUpload, "TowrePDE".sha1():finalResultsPDEUpload, "Towre-2".sha1():finalResultsTowreUpload, "Forward Digit Span".sha1():finalResultsDigitUpload, "Reverse Digit Span".sha1():finalResultsRevDigitUpload, "Digit Span".sha1():finalResultsDigitSpanUpload, "Dash CopyBest".sha1():copyBestWordsWrittenUpload, "Dash CopyFast".sha1():copyFastWordsWrittenUpload, "Dash CopyAlpha".sha1():copyAlphabetTotalWrittenUpload, "Dash Free".sha1():freeWritingTotalWrittenUpload, "Dash Final".sha1():finalResultDashUpload, "BPVS Final".sha1():finalResultBPVSUpload, "BPVS Errors".sha1():finalErrorsBPVSUpload, "BPVS Set Num".sha1():finalSetBPVSUpload, "UserCode".sha1():userCode] as [String : Any]
        }
        refDatabase.child(userKey).updateChildValues(userResults)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signOut(sender: AnyObject) {
        
        //clear key ready for next user to login
        key = []
        
        //clear all test results from local memory
        finalResultsSWE = 0
        finalResultsPDE = 0
        finalResultsTowre = 0
        finalResultsDigit = 0
        finalResultsRevDigit = 0
        finalResultsDigitSpan = 0
        copyBestWordsWritten = 0
        copyFastWordsWritten = 0
        copyAlphabetTotalWritten = 0
        freeWritingTotalWritten = 0
        finalResultDash = 0
        finalResultBPVS = 0
        finalErrorsBPVS = 0
        finalSetBPVS = 0
        
        //Sign Out
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "signOut", sender: nil)
    }
    
    //AES Encryption
    func aesEncrypt(_ userName: String) -> [UInt8] {
        let input = Array(userName.utf8)
        
        do {
            //encrypt using AES
            encrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).encrypt(input)
            
            //For Debugging
//            print("username:  ", userName)
//            print("encrypted: ", encrypted!)
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
