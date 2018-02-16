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
//    let key: Array<UInt8> = [0x16,0x25,0x34,0x22,0x97,0x67,0x44,0x52,0x72,0x37,0x57,0x70,0x45,0x78,0x48,0x27]
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
            userResults = ["username":userName, "Forward Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit, "Digit Span":finalResultsDigitSpan, "UserCode":userCode] as [String : Any]
        }
        else if finalResultsDigitSpan == 0 && finalResultDash == 0 && finalResultBPVS == 0 {
            userResults = ["username":userName, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE, "Towre-2":finalResultsTowre, "UserCode":userCode] as [String : Any]
        }
        else if finalResultsDigitSpan == 0 && finalResultsTowre == 0 && finalResultBPVS == 0 {
            userResults = ["username":userName, "Dash CopyBest":copyBestWordsWritten, "Dash CopyFast":copyFastWordsWritten, "Dash CopyAlpha":copyAlphabetTotalWritten, "Dash Free":freeWritingTotalWritten, "Dash Final":finalResultDash, "UserCode":userCode] as [String : Any]
        }
        else if finalResultsTowre == 0 && finalResultDash == 0 && finalResultsDigitSpan == 0 {
            userResults = ["username":userName, "BPVS Final":finalResultBPVS, "BPVS Errors":finalErrorsBPVS, "BPVS Set Num":finalSetBPVS, "UserCode":userCode] as [String : Any]
        }
        else {
            userResults = ["username":userName, "TowreSWE":finalResultsSWE, "TowrePDE":finalResultsPDE, "Towre-2":finalResultsTowre, "Digit Span":finalResultsDigit, "Reverse Digit Span":finalResultsRevDigit, "Digit Span":finalResultsDigitSpan, "Dash CopyBest":copyBestWordsWritten, "Dash CopyFast":copyFastWordsWritten, "Dash CopyAlpha":copyAlphabetTotalWritten, "Dash Free":freeWritingTotalWritten, "Dash Final":finalResultDash, "BPVS Final":finalResultBPVS, "BPVS Errors":finalErrorsBPVS, "BPVS Set Num":finalSetBPVS, "UserCode":userCode] as [String : Any]
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

