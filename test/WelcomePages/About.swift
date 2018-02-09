//
//  About.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
//import CryptoSwift

class About: UIViewController, UITextFieldDelegate {
    
//    let key: Array<UInt8> = [0x16,0x25,0x34,0x22,0x97,0x67,0x44,0x52,0x72,0x37,0x57,0x70,0x45,0x78,0x48,0x27]
//    let iv: Array<UInt8> = AES.randomIV(AES.blockSize)
//
//    var ciphertext: [UInt8] = []
//    var encrypted: [UInt8]?
    
//    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var textField: UITextField!
//
//    //Decrypt Function
//    @IBAction func decryptButton(_ sender: UIButton) {
//        aesDecrypt()
//    }
//
//    //Encrypt Function
//    @IBAction func button(_ sender: UIButton) {
//        let input: [UInt8] = Array(textField.text!.utf8)
//        aesEncrypt(input)
//    }
    
//    //AES Encryption
//    func aesEncrypt(_ input: [UInt8]) {
//        do {
//            //encrypt using AES
//            encrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).encrypt(input)
//
//            //Display encrypted value on label
//            label.text = "\(encrypted!)"
//
//            //Upload to Firebase
//            saveResults()
//
//            //For Debugging
//            print("P/T : ", textField.text!)
//            print("C/T : ", encrypted!)
//
//        } catch {
//            print(error)
//        }
//    }
    
//    //AES Decryption
//    func aesDecrypt() {
//        //Fetch results from Firebase
//        let fromFirebase = fetchResults()
//
//        //For debugging
//        print("fromFirebase", fromFirebase)
//
//        do {
//            //Decrypt using AES
//            let decrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(fromFirebase)
//
//            //From UInt8 to String
//            let decryptedData = String(bytes: Data(decrypted), encoding: .utf8)
//
//            //Display encrypted value on label
//            label.text = decryptedData!
//
//            //For Debugging
//            print("C/T*: ", encrypted!)
//            print("P/T*: ", decryptedData!)
//
//        } catch {
//            print(error)
//        }
//    }
    
//    //save encrypted value to firebase
//    func saveResults() {
//        var refDatabase: DatabaseReference!
//        refDatabase = Database.database().reference().child("tests")
//
//        let uid = "Encryption Test"
//        let key = refDatabase.child(uid).key
//
//        var uploadTest: [String : [UInt8]]
//        uploadTest = ["encrypted": encrypted!]
//
//        refDatabase.child(key).updateChildValues(uploadTest)
//    }
    
//    //fetch encrypted value from firebase
//    func fetchResults() -> [UInt8] {
//        let dbRef = Database.database().reference().child("tests").child("Encryption Test")
//        dbRef.observe(DataEventType.value, with: {(snapshot) in
//            if let firebaseSnap = snapshot.value as? [String: AnyObject] {
//                self.ciphertext = firebaseSnap["encrypted"] as! [UInt8]
//            } else {
//                print("error")
//            }
//        })
//        return self.ciphertext
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.textField.delegate = self;
        
//        let initializeFirebase = fetchResults()
//        print("Initializing Firebase: ", initializeFirebase)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    //Dismiss keyboard when in textfields
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
}
