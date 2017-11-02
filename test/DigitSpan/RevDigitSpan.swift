//
//  RevDigitSpan.swift
//  test
//
//  Created by Dominic Heaton on 02/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RevDigitSpan: UIViewController {
    
    var finalResultsDigit = Double()
    
    //temp variables
    let finalResultsRevDigit = 40.0
    
    @IBOutlet weak var patternToTestRev: UILabel!
    @IBOutlet weak var patternToReturnRev: UILabel!
    
    
    //Functions to hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternToTestRev.text = "1   5   3"
        patternToReturnRev.text = "3   5   1"
        
        performSegue(withIdentifier: "digitToTestCompleted", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DigitCompleted
        nextVC.finalResultsDigit = finalResultsDigit
        nextVC.finalResultsRevDigit = finalResultsRevDigit
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
