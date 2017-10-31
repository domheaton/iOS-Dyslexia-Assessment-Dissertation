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
        self.nameOfTestLabel.text = getTest
        self.testScoreLabel.text = String(getScore)
    }
    
    @objc func saveGraph() {
        let image = barChartView.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    func updateGraph() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = getScore
        
        let dataEntry = BarChartDataEntry(x: Double(1), y: Double(visitorCounts))
        dataEntries.append(dataEntry)
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: getTest)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.chartDescription?.text = getName
        chartDataSet.colors = [UIColor(red: 74/255, green: 205/255, blue: 168/255, alpha: 1)]
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let limitline = ChartLimitLine(limit: 70.0, label: "Target")
        barChartView.leftAxis.addLimitLine(limitline)
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 100.0
        barChartView.rightAxis.enabled = false
        
        barChartView.data = chartData
    }
    
}
