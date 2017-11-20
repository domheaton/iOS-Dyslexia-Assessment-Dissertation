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

class TableMenuController: UITableViewController {
    
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
                    let userName = nameObject?["username"]
                    let testName = nameObject?["test"]
                    let testTowreSWE = nameObject?["TowreSWE"]
                    let testTowrePDE = nameObject?["TowrePDE"]
                    let testForwardDigitSpan = nameObject?["Forward Digit Span"]
                    let testRevDigitSpan = nameObject?["Reverse Digit Span"]
                    let testTowre2 = nameObject?["Towre-2"]
                    let testDigitSpan = nameObject?["Digit Span"]
                    let testDashBest = nameObject?["Dash CopyBest"]
                    let testDashFast = nameObject?["Dash CopyFast"]
                    let testDashAlpha = nameObject?["Dash CopyAlpha"]
                    let testDashFree = nameObject?["Dash Free"]
                    let testDashFinal = nameObject?["Dash Final"]
                    let testBPVSFinal = nameObject?["BPVS Final"]
                    let testBPVSErrors = nameObject?["BPVS Errors"]
                    let testBPVSSetNum = nameObject?["BPVS Set Num"]
                   
                    //value to be printed in tableViewController Cells
                    let values = TestResults(name: userName as! String?, testName: testName as! String?, testTowreSWE: testTowreSWE as! Double?, testTowrePDE: testTowrePDE as! Double?, testTowre2: testTowre2 as! Double?, testForwardDigitSpan: testForwardDigitSpan as! Double?, testRevDigitSpan: testRevDigitSpan as! Double?, testDigitSpan: testDigitSpan as! Double?, testDashBest: testDashBest as! Double?, testDashFast: testDashFast as! Double?, testDashAlpha: testDashAlpha as! Double?, testDashFree: testDashFree as! Double?, testDashFinal: testDashFinal as! Double?, testBPVSFinal: testBPVSFinal as! Double?, testBPVSErrors: testBPVSErrors as! Double?, testBPVSSetNum: testBPVSSetNum as! Double?)
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
}
