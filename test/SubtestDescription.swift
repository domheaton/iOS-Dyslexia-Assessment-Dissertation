//
//  SubtestDescription.swift
//  test
//
//  Created by Dominic Heaton on 26/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SubtestDescription: UIViewController {
    
    var sweKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For debugging
        print("sweKey to be sent to TowrePDE: " + sweKey)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let passToTowreCalculationsPDE = storyboard.instantiateViewController(withIdentifier: "TowrePDE") as! TowrePDE
        passToTowreCalculationsPDE.receivedKey = sweKey
    }
    
    //Functions to hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
