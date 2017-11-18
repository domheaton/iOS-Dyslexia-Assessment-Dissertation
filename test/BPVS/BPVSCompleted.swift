//
//  BPVSCompleted.swift
//  test
//
//  Created by Dominic Heaton on 18/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BPVSCompleted: UIViewController {
    
//    var finalResultsDigit = Double()
//    var finalResultsRevDigit = Double()
//    var finalResultDigitSpan = Double()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nextVC = segue.destination as! Menu
//        nextVC.finalResultsDigit = finalResultsDigit
//        nextVC.finalResultsRevDigit = finalResultsRevDigit
//        nextVC.finalResultsDigitSpan = finalResultDigitSpan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Test Complete"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnToMenuPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "BPVStoMenu", sender: nil)
    }
}


