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

class IndividualScore: UIViewController, ChartViewDelegate {
    
    var getName = String()
    var getTowreSWE = Double()
    var getTowrePDE = Double()
    var getTowre2 = Double()
    var getForwardDigitSpan = Double()
    var getRevDigitSpan = Double()
    var getDigitSpan = Double()
    var getDashBest = Double()
    var getDashFast = Double()
    var getDashAlpha = Double()
    var getDashFree = Double()
    var getDashFinal = Double()
    var getBPVSFinal = Double()
    var getBPVSErrors = Double()
    var getBPVSSetNum = Double()
    
    var testArray: [String]!
    var testScoresToDisplay: [Double]!
    var selectedBarFromChart: String?
    var towrePercentage: Double?
    var digitSpanPercentage: Double?
    var dashPercentage: Double?
    var bpvsPercentage: Double?

    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var nameOfStudentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartView.delegate = self

        navigationItem.title = "Test Results"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Graph", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveGraph))
        
        instructionsLabel.adjustsFontSizeToFitWidth = true
        nameOfStudentLabel.adjustsFontSizeToFitWidth = true
        
        getDetails()
        
        barChartView.noDataText = "Hmmm, there should be some data around here somewhere."
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getDetails() {
        self.nameOfStudentLabel.text = getName
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
        
        towrePercentage = (getTowre2 / 147.0) * 100.0
        digitSpanPercentage = (getDigitSpan / 157.0) * 100.0
        
        //THESE IS MADE UP AT THE MOMENT! -- REPLACE WITH REAL STATS
        dashPercentage = (getDashFinal / 146) * 100
        bpvsPercentage = (getBPVSFinal / (getBPVSSetNum * 12.0)) * 100.0
        
        //select only the scores that are available
//        if getTowre2 == 0 {
//            testArray = ["BPVS-3", "DASH", "Digit Span"]
//            testScoresToDisplay = [bpvsPercentage!, dashPercentage!, digitSpanPercentage!]
//        }
//        else if getBPVSFinal == 0 {
//            testArray = ["Towre-2", "DASH", "Digit Span"]
//            testScoresToDisplay = [towrePercentage!, dashPercentage!, digitSpanPercentage!]
//        }
//        else if getDashFinal == 0 {
//            testArray = ["Towre-2", "BPVS-3", "Digit Span"]
//            testScoresToDisplay = [towrePercentage!, bpvsPercentage!, digitSpanPercentage!]
//        }
//        else if getDigitSpan == 0 {
//            testArray = ["Towre-2", "BPVS-3", "DASH"]
//            testScoresToDisplay = [towrePercentage!, bpvsPercentage!, dashPercentage!]
//        }
//        else
        if getTowre2 == 0 && getDigitSpan == 0 && getBPVSFinal == 0 {
            testArray = ["DASH"]
            testScoresToDisplay = [dashPercentage!]
        }
        else if getDashFinal == 0 && getDigitSpan == 0 && getBPVSFinal == 0 {
            testArray = ["Towre-2"]
            testScoresToDisplay = [towrePercentage!]
        }
        else if getDashFinal == 0 && getTowre2 == 0 && getBPVSFinal == 0 {
            testArray = ["Digit Span"]
            testScoresToDisplay = [digitSpanPercentage!]
        }
        else if getDashFinal == 0 && getTowre2 == 0 && getDigitSpan == 0 {
            testArray = ["BPVS-3"]
            testScoresToDisplay = [bpvsPercentage!]
        }
        else if getTowre2 == 0 && getDigitSpan == 0 {
            testArray = ["BPVS-3", "DASH"]
            testScoresToDisplay = [towrePercentage!, digitSpanPercentage!]
        }
        else if getTowre2 == 0 && getDashFinal == 0 {
            testArray = ["BPVS-3", "Digit Span"]
            testScoresToDisplay = [bpvsPercentage!, digitSpanPercentage!]
        }
        else if getTowre2 == 0 && getBPVSFinal == 0 {
            testArray = ["DASH", "Digit Span"]
            testScoresToDisplay = [dashPercentage!, digitSpanPercentage!]
        }
        else if getDashFinal == 0 && getDigitSpan == 0 {
            testArray = ["Towre-2", "BPVS-3"]
            testScoresToDisplay = [towrePercentage!, bpvsPercentage!]
        }
        else if getBPVSFinal == 0 && getDashFinal == 0 {
            testArray = ["Towre-2", "Digit Span"]
            testScoresToDisplay = [towrePercentage!, digitSpanPercentage!]
        }
        else if getBPVSFinal == 0 && getDigitSpan == 0 {
            testArray = ["Towre-2", "DASH"]
            testScoresToDisplay = [towrePercentage!, dashPercentage!]
        }
        else if getTowre2 == 0 {
            testArray = ["BPVS-3", "DASH", "Digit Span"]
            testScoresToDisplay = [bpvsPercentage!, dashPercentage!, digitSpanPercentage!]
        }
        else if getDigitSpan == 0 {
            testArray = ["Towre-2", "BPVS-3", "DASH"]
            testScoresToDisplay = [towrePercentage!, bpvsPercentage!, dashPercentage!]
        }
        else if getDashFinal == 0 {
            testArray = ["Towre-2", "BPVS-3", "Digit Span"]
            testScoresToDisplay = [towrePercentage!, bpvsPercentage!, digitSpanPercentage!]
        }
        else if getBPVSFinal == 0 {
            testArray = ["Towre-2", "DASH", "Digit Span"]
                        testScoresToDisplay = [towrePercentage!, dashPercentage!, digitSpanPercentage!]
        }
        else {
            testArray = ["Towre-2", "BPVS-3", "DASH", "Digit Span"]
            testScoresToDisplay = [towrePercentage!, bpvsPercentage!, dashPercentage!, digitSpanPercentage!]
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
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.5)
        
//        let limitline = ChartLimitLine(limit: 70.0, label: "Target")
//        barChartView.leftAxis.addLimitLine(limitline)
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
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        //For debugging
        print(testArray[Int(entry.x)])
        
        selectedBarFromChart = testArray[Int(entry.x)]
        
        performSegue(withIdentifier: "toIndepthScores", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! IndepthScores
        nextVC.getName = getName
        if selectedBarFromChart == "Towre-2" {
            nextVC.getTest = selectedBarFromChart!
            nextVC.getTowreSWE = getTowreSWE
            nextVC.getTowrePDE = getTowrePDE
        }
        else if selectedBarFromChart == "Digit Span" {
            nextVC.getTest = selectedBarFromChart!
            nextVC.getForwardDigitSpan = getForwardDigitSpan
            nextVC.getRevDigitSpan = getRevDigitSpan
            nextVC.getDigitSpan = getDigitSpan
        }
        else if selectedBarFromChart == "DASH" {
            nextVC.getTest = selectedBarFromChart!
            nextVC.getDashBest = getDashBest
            nextVC.getDashFast = getDashFast
            nextVC.getDashAlpha = getDashAlpha
            nextVC.getDashFree = getDashFree
            nextVC.getDashFinal = getDashFinal
        }
        else if selectedBarFromChart == "BPVS-3" {
            nextVC.getTest = selectedBarFromChart!
            nextVC.getBPVSFinal = getBPVSFinal
            nextVC.getBPVSErrors = getBPVSErrors
            nextVC.getBPVSSetNum = getBPVSSetNum
        }
    }
    
}
