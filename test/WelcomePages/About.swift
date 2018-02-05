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
import CryptoSwift

class About: UIViewController, UITextFieldDelegate {
    
    let key: Array<UInt8> = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    
    let iv: Array<UInt8> = AES.randomIV(AES.blockSize)

    var encrypted: [UInt8]?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    //Decrypt Function
    @IBAction func decryptButton(_ sender: UIButton) {
        do {
            //Decrypt using AES
            let decrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(encrypted!)
            
            //From UInt8 to String
            let decryptedData = String(bytes: Data(decrypted), encoding: .utf8)
            
            //Display encrypted value on label
            label.text = decryptedData!
            
            //For Debugging
            print("C/T*: ", encrypted!)
            print("P/T*: ", decryptedData!)
        
        } catch {
            print(error)
        }
    }
    
    //Encrypt Function
    @IBAction func button(_ sender: UIButton) {
        //          SHA512 Function
        //          label.text = textField.text!.sha512()
        
        let input: [UInt8] = Array(textField.text!.utf8)
        
        do {
            //encrypt using AES
            encrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).encrypt(input)
            
            //Display encrypted value on label
            label.text = "\(encrypted!)"
            
            //For Debugging
            print("P/T : ", textField.text!)
            print("C/T : ", encrypted!)

        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dismiss keyboard when in textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
