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
        nextVC.copyBestWordsWritten = brain.getScaledCopyBest()
        nextVC.copyFastWordsWritten = brain.getScaledCopyFast()
        nextVC.copyAlphabetTotalWritten = brain.getScaledCopyAlphabet()
        nextVC.freeWritingTotalWritten = brain.getScaledFreeWriting()
        nextVC.finalResultDash = brain.getFinalResultDash()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain.setInputsFromSubtests(copyBestWordsWritten, copyFastWordsWritten, copyAlphabetTotalWritten, freeWritingTotalWritten)
        
        brain.scaleResults()
        
        //For debugging
        print("Copy Best Result     : ", brain.getScaledCopyBest())
        print("Copy Fast Result     : ", brain.getScaledCopyFast())
        print("Alphabet Copy Result : ", brain.getScaledCopyAlphabet())
        print("Free Writing Result  : ", brain.getScaledFreeWriting())
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

