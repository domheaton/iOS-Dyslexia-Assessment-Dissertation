//
//  DigitSpan.swift
//  test
//
//  Created by Dominic Heaton on 02/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DigitSpan: UIViewController {
    
    //temp variables
    let finalResultsDigit: Double = 50.0
    
    @IBOutlet weak var patternToTest: UILabel!
    @IBOutlet weak var patternToReturn: UILabel!
    
    
    //Functions to hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternToTest.text = "1   5   3"
        patternToReturn.text = "1   5   3"
        
        performSegue(withIdentifier: "toDigitSubtest", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DigitSubtestComplete
        nextVC.finalResultsDigit = finalResultsDigit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctPressed(_ sender: UIButton) {

    }
    
    @IBAction func incorrectPressed(_ sender: UIButton) {

    }
    
    @IBAction func undoPressed(_ sender: UIButton) {

    }
    
}

