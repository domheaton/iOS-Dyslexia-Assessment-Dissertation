//
//  TableMenuController.swift
//  test
//
//  Created by Dominic Heaton on 19/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CryptoSwift

class TableMenuController: UITableViewController {
    
    //Encryption Variables
//    let key: Array<UInt8> = [0x16,0x25,0x34,0x22,0x97,0x67,0x44,0x52,0x72,0x37,0x57,0x70,0x45,0x78,0x48,0x27]
    let iv: Array<UInt8> = [0x26,0x54,0x72,0x45,0x77,0x27,0x99,0x57,036,0x34,0x37,0x66,0x11,0x10,0x73,0x98]
    var ciphertext: [UInt8] = []
    
    let referenceResults = Database.database().reference().child("results").child("user")

    //The labels used in the table
    @IBOutlet var tableNames: UITableView!
    
    //Reference to the class containing test names
    var resultsList = [TestResults]()
    
    //Sets number of rows in table from database list number
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    //Assigns data from the database to a cell in the table
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCells
        let detailsToDisplay: TestResults
        
        detailsToDisplay = resultsList[indexPath.row]
        
        cell.labelName.text = detailsToDisplay.name
        cell.labelTest.text = detailsToDisplay.testName
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let initializeFirebase = fetchUsername()
//        print("Initializing Firebase: ", initializeFirebase)
        
        loadTests()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //function to read data from the database and fill table
    func loadTests() {
        referenceResults.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.resultsList.removeAll()
                
                for details in snapshot.children.allObjects as![DataSnapshot]{
                    let nameObject = details.value as? [String: AnyObject]
                    
                    //Non-SHA values for names in database
//                    let downloadedKey = nameObject?["UserCode"] as! [UInt8]
//                    let userName = self.aesDecrypt(nameObject?["username"] as! [UInt8], downloadedKey)
//                    let testName = nameObject?["test"]
//                    let testTowreSWE = nameObject?["TowreSWE"]
//                    let testTowrePDE = nameObject?["TowrePDE"]
//                    let testForwardDigitSpan = nameObject?["Forward Digit Span"]
//                    let testRevDigitSpan = nameObject?["Reverse Digit Span"]
//                    let testTowre2 = nameObject?["Towre-2"]
//                    let testDigitSpan = nameObject?["Digit Span"]
//                    let testDashBest = nameObject?["Dash CopyBest"]
//                    let testDashFast = nameObject?["Dash CopyFast"]
//                    let testDashAlpha = nameObject?["Dash CopyAlpha"]
//                    let testDashFree = nameObject?["Dash Free"]
//                    let testDashFinal = nameObject?["Dash Final"]
//                    let testBPVSFinal = nameObject?["BPVS Final"]
//                    let testBPVSErrors = nameObject?["BPVS Errors"]
//                    let testBPVSSetNum = nameObject?["BPVS Set Num"]
                    
                    //As SHA values rather than names
                    let downloadedKey = nameObject?["24e200d62f1ff2eaa018a92141156311140a5dc6"] as! [UInt8]
                    let userName = self.aesDecrypt(nameObject?["249ba36000029bbe97499c03db5a9001f6b734ec"] as! [UInt8], downloadedKey)
                    let testName = nameObject?["test"]
                    let testTowreSWE = nameObject?["a0b3f81c68950a336aac5c9d37b580d4c10c47d3"]
                    let testTowrePDE = nameObject?["a0b3f81c68950a336aac5c9d37b580d4c10c47d3"]
                    let testTowre2 = nameObject?["790527d5391de45bee16049182dc256a4dbd9249"]
                    let testForwardDigitSpan = nameObject?["afbff28320023674ab9d726b82f9950dfb8a682e"]
                    let testRevDigitSpan = nameObject?["ea5c0be2c72041e3e8a1967521a46fbec83aafb3"]
                    let testDigitSpan = nameObject?["0cc6b6e188c66b816f4815e36e7258151b5682e2"]
                    let testDashBest = nameObject?["15cebf73c08ae7ae6f8c1e5bf7e378cefedcbdb2"]
                    let testDashFast = nameObject?["46a9594bb26d34a115803e6ce8acb2f21b3581fb"]
                    let testDashAlpha = nameObject?["cd9d351ff52def3c4f600c6c950be2b097d5bb08"]
                    let testDashFree = nameObject?["43bfa942ccfeb50b1babd3f812d63686b39a234d"]
                    let testDashFinal = nameObject?["3796f1f65c09a69bab39f3b9c99ad258df5f941a"]
                    let testBPVSFinal = nameObject?["d6f4155db8522f4ade6be8fec5dedbc528da622c"]
                    let testBPVSErrors = nameObject?["965235c91599510f92375dff37b3f80e8c7fa620"]
                    let testBPVSSetNum = nameObject?["a9661b90e717297127f797ea16fa6ee8b6c7382d"]
                   
                    //value to be printed in tableViewController Cells
                    let values = TestResults(name: userName, testName: testName as! String?, testTowreSWE: testTowreSWE as! Double?, testTowrePDE: testTowrePDE as! Double?, testTowre2: testTowre2 as! Double?, testForwardDigitSpan: testForwardDigitSpan as! Double?, testRevDigitSpan: testRevDigitSpan as! Double?, testDigitSpan: testDigitSpan as! Double?, testDashBest: testDashBest as! Double?, testDashFast: testDashFast as! Double?, testDashAlpha: testDashAlpha as! Double?, testDashFree: testDashFree as! Double?, testDashFinal: testDashFinal as! Double?, testBPVSFinal: testBPVSFinal as! Double?, testBPVSErrors: testBPVSErrors as! Double?, testBPVSSetNum: testBPVSSetNum as! Double?)
                    self.resultsList.append(values)
                }
                self.tableNames.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "IndividualScore") as! IndividualScore

        //pass data to IndividualScore VC depending on which cell was pressed
        let detailsToPass: TestResults
        detailsToPass = resultsList[indexPath.row]
        nextVC.getName = detailsToPass.name!
//        if detailsToPass.testTowreSWE != nil {
//            nextVC.getTowreSWE = detailsToPass.testTowreSWE!
//        }
//        if detailsToPass.testTowrePDE != nil {
//            nextVC.getTowrePDE = detailsToPass.testTowrePDE!
//        }
//        if detailsToPass.testForwardDigitSpan != nil {
//          nextVC.getForwardDigitSpan = detailsToPass.testForwardDigitSpan!
//        }
//        if detailsToPass.testRevDigitSpan != nil {
//            nextVC.getRevDigitSpan = detailsToPass.testRevDigitSpan!
//        }
//        if detailsToPass.testTowre2 != nil {
//            nextVC.getTowre2 = detailsToPass.testTowre2!
//        }
//        if detailsToPass.testDigitSpan != nil {
//            nextVC.getDigitSpan = detailsToPass.testDigitSpan!
//        }
        if detailsToPass.testTowre2 != nil {
            nextVC.getTowre2 = detailsToPass.testTowre2!
            nextVC.getTowrePDE = detailsToPass.testTowrePDE!
            nextVC.getTowreSWE = detailsToPass.testTowreSWE!
        }
        if detailsToPass.testDigitSpan != nil {
            nextVC.getDigitSpan = detailsToPass.testDigitSpan!
            nextVC.getForwardDigitSpan = detailsToPass.testForwardDigitSpan!
            nextVC.getRevDigitSpan = detailsToPass.testRevDigitSpan!
        }
        if detailsToPass.testDashFinal != nil {
            nextVC.getDashFinal = detailsToPass.testDashFinal!
            nextVC.getDashBest = detailsToPass.testDashBest!
            nextVC.getDashFast = detailsToPass.testDashFast!
            nextVC.getDashAlpha = detailsToPass.testDashAlpha!
            nextVC.getDashFree = detailsToPass.testDashFree!
        }
        if detailsToPass.testBPVSFinal != nil {
            nextVC.getBPVSFinal = detailsToPass.testBPVSFinal!
            nextVC.getBPVSErrors = detailsToPass.testBPVSErrors!
            nextVC.getBPVSSetNum = detailsToPass.testBPVSSetNum!
        }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //AES Decryption
    func aesDecrypt(_ username: [UInt8],_ downloadedKey: [UInt8]) -> String {
        var decryptedData: String?
        do {
            
            //Decrypt using AES
//            let decrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(username)
            let decrypted = try AES(key: downloadedKey, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(username)

            //From UInt8 to String
            decryptedData = String(bytes: Data(decrypted), encoding: .utf8)
            
            print("username: ", username)
            print("decrypted: ", decrypted)
            print("decryptedData: ", decryptedData!)

        } catch {
            print(error)
        }
        return decryptedData!
    }

}
