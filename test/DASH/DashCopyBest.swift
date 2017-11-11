//
//  DashCopyBest.swift
//  test
//
//  Created by Dominic Heaton on 11/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DashCopyBest: UIViewController {
   
    var timer = Timer()
    var timeSeconds = 0.0
    var timeMinutes = 0
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest 1: Copy Best"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DashCopyBest.checkTimeElapsed), userInfo: nil, repeats: true)
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
            
            timer.invalidate()
            timeSeconds = 0.0
            timeMinutes = 0
            performSegue(withIdentifier: "toDashCopyBestAnswers", sender: nil)
        }
    }
    
    @IBAction func tempSkip(_ sender: Any) {
        //For debugging
        print("Temp Skip Pressed")
        
        timer.invalidate()
        timeSeconds = 0.0
        timeMinutes = 0
        performSegue(withIdentifier: "toDashCopyBestAnswers", sender: nil)
    }
}
