//
//  DashAlphabet.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashAlphabet: UIViewController {
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    
    var timer3 = Timer()
    var timeSeconds = 0.0
    var timeMinutes = 0
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 3: Alphabet Copy"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DashAlphabetAnswers
        nextVC.copyBestWordsWritten = copyBestWordsWritten
        nextVC.copyFastWordsWritten = copyFastWordsWritten
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer3 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DashCopyBest.checkTimeElapsed), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //2 minute timer display = 0 : 00.0 -- min : sec.millisecond
    @objc func checkTimeElapsed() {
        if timeMinutes != 2 {
            if timeSeconds < 60 {
                timeSeconds += 0.1
                timeElapsedLabel.text = String(timeMinutes) + " : " + String(format: "%.1f", timeSeconds)
            }
            else {
                timeSeconds = 0.0
                timeMinutes += 1
                timeElapsedLabel.text = String(timeMinutes) + " : " + String(format: "%.1f", timeSeconds)
            }
        }
        else {
            //For debugging
            print("Timer Expired")
            
            timer3.invalidate()
            timeSeconds = 0.0
            timeMinutes = 0
            performSegue(withIdentifier: "toDashAlphabetAnswers", sender: nil)
        }
    }
    
    @IBAction func tempSkip(_ sender: Any) {
        //For debugging
        print("Temp Skip Pressed")
        
        timer3.invalidate()
        timeSeconds = 0.0
        timeMinutes = 0
        performSegue(withIdentifier: "toDashAlphabetAnswers", sender: nil)
    }
}
