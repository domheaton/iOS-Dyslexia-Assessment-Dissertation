//
//  DashFreeAnswers.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashFreeAnswers: UIViewController {
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    var copyAlphabetTotalWritten = Double()
    
//    @IBOutlet weak var stopStudentLabel: UILabel!
    @IBOutlet weak var value1Label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        value1Label.text = Int(sender.value).description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 4: Free Writing"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        stopStudentLabel.adjustsFontSizeToFitWidth = true
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 250 //reasonable max for this test
        stepper.stepValue = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DashCompleted
        nextVC.copyBestWordsWritten = copyBestWordsWritten
        nextVC.copyFastWordsWritten = copyFastWordsWritten
        nextVC.copyAlphabetTotalWritten = copyAlphabetTotalWritten
        nextVC.freeWritingTotalWritten = Double(value1Label.text!)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toDashCompleted", sender: nil)
    }
}

