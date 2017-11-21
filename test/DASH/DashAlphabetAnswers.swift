//
//  DashAlphabetAnswers.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashAlphabetAnswers: UIViewController {
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    
    @IBOutlet weak var value1Label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        value1Label.text = Int(sender.value).description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 3: Alphabet Copy"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 130 //reasonable max for this test
        stepper.stepValue = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DashSubtestAlphabetComplete
        nextVC.copyBestWordsWritten = copyBestWordsWritten
        nextVC.copyFastWordsWritten = copyFastWordsWritten
        nextVC.copyAlphabetTotalWritten = Double(value1Label.text!)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toDashAlphabetComplete", sender: nil)
    }
}

