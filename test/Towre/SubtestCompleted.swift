//
//  SubtestCompleted.swift
//  test
//
//  Created by Dominic Heaton on 25/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SubtestCompleted: UIViewController {
    
//    var finalResultsSWE = Double()
//    var scaledResultSWE = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //For debugging
//        print("finalResultsSWE on SubtestCompleted: ", finalResultsSWE)
//        print("scaledResultSWE on SubtestCompleted: ", scaledResultSWE)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nextVC = segue.destination as! SubtestDescription
//        nextVC.finalResultsSWE = finalResultsSWE
//        nextVC.scaledResultSWE = scaledResultSWE
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
 
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Subtest Complete"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
