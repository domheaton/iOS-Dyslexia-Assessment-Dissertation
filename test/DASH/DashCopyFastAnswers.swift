//
//  DashCopyFastAnswers.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashCopyFastAnswers: UIViewController {
    
    var copyBestWordsWritten = Double()
    
//    @IBOutlet weak var stopStudentLabel: UILabel!
    @IBOutlet weak var value1Label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        value1Label.text = Int(sender.value).description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DashSubtestFastComplete
        nextVC.copyBestWordsWritten = copyBestWordsWritten
        nextVC.copyFastWordsWritten = Double(value1Label.text!)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 2: Copy Fast"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        stopStudentLabel.adjustsFontSizeToFitWidth = true
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 60 //reasonable max for this test
        stepper.stepValue = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toDashCopyFastComplete", sender: nil)
    }
}
