//
//  DashCompleted.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashCompleted: UIViewController {
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    var copyAlphabetTotalWritten = Double()
    var freeWritingTotalWritten = Double()
    
    private var brain = DashCalculations()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! Menu
        nextVC.copyBestWordsWritten = brain.getCopyBest() //WPM
        nextVC.copyFastWordsWritten = brain.getCopyFast() //WPM
        nextVC.copyAlphabetTotalWritten = brain.getCopyAlphabet() //WPM
        nextVC.freeWritingTotalWritten = brain.getFreeWriting() //WPM
        nextVC.finalResultDash = brain.getFinalResultDash() //Scaled & Standardised
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain.setInputsFromSubtests(copyBestWordsWritten, copyFastWordsWritten, copyAlphabetTotalWritten, freeWritingTotalWritten)
        
        brain.scaleResults()
        
        //For debugging
        print("Copy Best Result     : ", brain.getCopyBest())
        print("Copy Fast Result     : ", brain.getCopyFast())
        print("Alphabet Copy Result : ", brain.getCopyAlphabet())
        print("Free Writing Result  : ", brain.getFreeWriting())
        print("Standardised Result  : ", brain.getFinalResultDash())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Test Complete"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToMenuPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "dashToMenu", sender: nil)
    }
}

