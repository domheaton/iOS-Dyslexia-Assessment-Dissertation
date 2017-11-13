//
//  DashFree.swift
//  test
//
//  Created by Dominic Heaton on 12/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashFree: UIViewController {
    
    var copyBestWordsWritten = Double()
    var copyFastWordsWritten = Double()
    var copyAlphabetTotalWritten = Double()
    
    var timer4 = Timer()
    var timeSeconds = 0.0
    var timeMinutes = 0
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 4: Free Writing"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DashFreeAnswers
        nextVC.copyBestWordsWritten = copyBestWordsWritten
        nextVC.copyFastWordsWritten = copyFastWordsWritten
        nextVC.copyAlphabetTotalWritten = copyAlphabetTotalWritten
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer4 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DashCopyBest.checkTimeElapsed), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //2 minute timer display = 0 : 00.0 -- min : sec.millisecond
    @objc func checkTimeElapsed() {
        if timeMinutes != 10 {
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
            
            timer4.invalidate()
            timeSeconds = 0.0
            timeMinutes = 0
            performSegue(withIdentifier: "toDashFreeAnswers", sender: nil)
        }
    }
    
    @IBAction func tempSkip(_ sender: Any) {
        //For debugging
        print("Temp Skip Pressed")
        
        timer4.invalidate()
        timeSeconds = 0.0
        timeMinutes = 0
        performSegue(withIdentifier: "toDashFreeAnswers", sender: nil)
    }
}
