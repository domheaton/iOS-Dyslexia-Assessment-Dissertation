//
//  IndividualScore.swift
//  test
//
//  Created by Dominic Heaton on 28/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Charts

class IndividualScore: UIViewController {
    
    var getName = String()
    var getTest = String()
    var getScore = Double()
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var nameOfStudentLabel: UILabel!
    @IBOutlet weak var nameOfTestLabel: UILabel!
    @IBOutlet weak var testScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
        
        barChartView.noDataText = "Hmmm, there should be some data around here somewhere."
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDetails() {
        self.nameOfStudentLabel.text = getName
        self.nameOfTestLabel.text = getTest
        self.testScoreLabel.text = String(getScore)
    }
    
    func setChart(label: String, value: Double) {

        
        
    }

}
