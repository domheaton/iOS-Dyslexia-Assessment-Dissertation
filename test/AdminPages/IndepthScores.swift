//
//  IndepthScores.swift
//  test
//
//  Created by Dominic Heaton on 06/11/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Charts

class IndepthScores: UIViewController {
    
    var getName = String()
    var getTest = String()
    var getTowreSWE = Double()
    var getTowrePDE = Double()
    var getTowre2 = Double()
    var getForwardDigitSpan = Double()
    var getRevDigitSpan = Double()
    var getDigitSpan = Double()
    
    var testArray: [String]!
    var testScoresToDisplay: [Double]!
    var selectedBarFromChart: String?
    var descriptionSWE: String?
    var descriptionPDE: String?
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var nameOfStudentLabel: UILabel!
    @IBOutlet weak var nameOfTestLabel: UILabel!
    @IBOutlet weak var subtest1Label: UILabel!
    @IBOutlet weak var subtest2Label: UILabel!
    @IBOutlet weak var subtest1Score: UILabel!
    @IBOutlet weak var subtest2Score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Test Breakdown"
        
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
        if getTest == "Towre-2" {
            self.subtest1Label.text = "Subtest: TowreSWE"
            self.subtest2Label.text = "Subtest: TowrePDE"

            getDescriptionSWE()
            getDescriptionPDE()
            
            self.subtest1Score.text = descriptionSWE
            self.subtest2Score.text = descriptionPDE
        }
        else if getTest == "Digit Span" {
            self.subtest1Label.text = "Subtest: Forw. Digit Span"
            self.subtest2Label.text = "Subtest: Rev.  Digit Span"
            self.subtest1Score.text = String(getForwardDigitSpan)
            self.subtest2Score.text = String(getRevDigitSpan)
        }
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
        
        //select only the scores that are available
        if getTowreSWE == 0 || getTowrePDE == 0 {
            testArray = ["Forward Digit Span", "Reverse Digit Span"]
            testScoresToDisplay = [getForwardDigitSpan, getRevDigitSpan]
        }
        else if getForwardDigitSpan == 0 || getRevDigitSpan == 0 {
            testArray = ["TowreSWE", "TowrePDE"]
            testScoresToDisplay = [getTowreSWE, getTowrePDE]
        }
        
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
        barChartView.xAxis.labelFont = UIFont(name: "HelveticaNeue", size: 10.0)!
        barChartView.legend.font = UIFont(name: "HelveticaNeue", size: 10.0)!
        barChartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue", size: 10.0)!
        chartDataSet.valueFont = UIFont(name: "HelveticaNeue", size: 12.0)!
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 105.0
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: testArray)
        barChartView.doubleTapToZoomEnabled = false
        
        barChartView.xAxis.granularity = 1
        
        barChartView.data = chartData
    }
    
    func getDescriptionSWE() {
        if getTowreSWE < 70 {
            descriptionSWE = "Very Poor"
        }
        else if getTowreSWE >= 70 && getTowreSWE < 80 {
            descriptionSWE = "Poor"
        }
        else if getTowreSWE >= 80 && getTowreSWE < 90 {
            descriptionSWE = "Below Average"
        }
        else if getTowreSWE >= 90 && getTowreSWE < 111 {
            descriptionSWE = "Average"
        }
        else if getTowreSWE >= 111 && getTowreSWE < 121 {
            descriptionSWE = "Above Average"
        }
        else if getTowreSWE >= 121 && getTowreSWE < 131 {
            descriptionSWE = "Superior"
        }
        else if getTowreSWE >= 131 {
            descriptionSWE = "Very Superior"
        }
    }
    
    func getDescriptionPDE() {
        if getTowrePDE < 70 {
            descriptionPDE = "Very Poor"
        }
        else if getTowrePDE >= 70 && getTowrePDE < 80 {
            descriptionPDE = "Poor"
        }
        else if getTowrePDE >= 80 && getTowrePDE < 90 {
            descriptionPDE = "Below Average"
        }
        else if getTowrePDE >= 90 && getTowrePDE < 111 {
            descriptionPDE = "Average"
        }
        else if getTowrePDE >= 111 && getTowrePDE < 121 {
            descriptionPDE = "Above Average"
        }
        else if getTowrePDE >= 121 && getTowrePDE < 131 {
            descriptionPDE = "Superior"
        }
        else if getTowrePDE >= 131 {
            descriptionPDE = "Very Superior"
        }
    }
    
}
