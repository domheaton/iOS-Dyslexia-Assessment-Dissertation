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
    
    var finalResultsSWE = Double()
    var scaledResultSWE = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //For debugging
        print("SubtestDescription: ", finalResultsSWE)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! TowrePDE
        nextVC.finalResultsSWE = finalResultsSWE
        nextVC.scaledResultSWE = scaledResultSWE
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
