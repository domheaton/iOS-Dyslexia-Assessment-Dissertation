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
    var getTowreSWE = Double()
    var getTowrePDE = Double()

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var nameOfStudentLabel: UILabel!
    @IBOutlet weak var nameOfTestLabel: UILabel!
    @IBOutlet weak var nameOfTestLabel2: UILabel!
    @IBOutlet weak var testScoreLabel: UILabel!
    @IBOutlet weak var testScoreLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Graph", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveGraph))
        getDetails()
        
        barChartView.noDataText = "Hmmm, there should be some data around here somewhere."
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getDetails() {
        self.nameOfStudentLabel.text = getName
        self.nameOfTestLabel.text = "TowreSWE"
        self.testScoreLabel.text = String(getTowreSWE)
        self.nameOfTestLabel2.text = "TowrePDE"
        self.testScoreLabel2.text = String(getTowrePDE)
    }
    
    @objc func saveGraph() {
        let image = barChartView.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        let alertController = UIAlertController(title: "Graph Saved", message: "The graph has been saved to Photos", preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateGraph() {
        var dataEntries: [BarChartDataEntry] = []
        
        let testArray: [String]! = ["TowreSWE", "TowrePDE"]
        let testScoresToDisplay: [Double]! = [getTowreSWE, getTowrePDE]
        
        for i in 0..<testArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: testScoresToDisplay[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Test Results for: " + getName)
        barChartView.chartDescription?.text = ""
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartDataSet.colors = [UIColor(red: 74/255, green: 205/255, blue: 168/255, alpha: 1)]
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
        
        let limitline = ChartLimitLine(limit: 70.0, label: "Target")
        barChartView.leftAxis.addLimitLine(limitline)
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 100.0
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: testArray)
//        barChartView.xAxis.wordWrapEnabled = true
        
        barChartView.xAxis.granularity = 1
        
        barChartView.data = chartData
    }
    
}
