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
    var descriptionSWE: String?
    var descriptionPDE: String?
    var digitSpanPercentage: Double?
    var digitSpanPercentile: String?
    var towrePercentageSWE: Double?
    var towrePercentagePDE: Double?
    var dashPercentile: String?
    var getBPVSStandardised: Double?
    
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
            self.subtest1Label.text = "TowreSWE Result Descriptor:"
            self.subtest2Label.text = "TowrePDE Result Descriptor:"

            getDescriptionSWE()
            getDescriptionPDE()
            
            self.subtest1Score.text = descriptionSWE
            self.subtest2Score.text = descriptionPDE
        }
        else if getTest == "Digit Span" {
            
            self.subtest1Label.text = "Test Percentage:"
            self.subtest2Label.text = "Percentile Equivalent:"
            
            testPercentage()
            getDigitSpanPercentile()
            
            //For debugging
            print("getDigitSpan: ", getDigitSpan)
            print("digitSpanPercentile: ", digitSpanPercentile!)
            print("digitSpanPercentage: ", digitSpanPercentage!)
            
            self.subtest1Score.text = String(format: "%.1f", Float(digitSpanPercentage!))
            self.subtest2Score.text = digitSpanPercentile!
        }
        else if getTest == "DASH" {

            self.subtest1Label.text = "Total Standardised Score:"
            self.subtest2Label.text = "Percentile Rank:"
            
            getDashPercentile()
            
            //reverse the pectange process used in individualscore.swift
            self.subtest1Score.text = String(getDashFinal)
            self.subtest2Score.text = dashPercentile!
        }
        else if getTest == "BPVS-3" {
            
            self.subtest1Label.text = "Test Raw Score:"
            self.subtest2Label.text = "Standardised Test Score:"
            
            standardiseBPVS()
            
            self.subtest1Score.text = String(format: "%.1f", getBPVSFinal)
            self.subtest2Score.text = String(getBPVSStandardised!)
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
        
        if getTest == "Towre-2" {
            testArray = ["TowreSWE", "TowrePDE"]
            testScoresToDisplay = [towrePercentageSWE!, towrePercentagePDE!]
        }
        else if getTest == "Digit Span" {
            testArray = ["Forward Digit Span", "Reverse Digit Span"]
            testScoresToDisplay = [getForwardDigitSpan, getRevDigitSpan]
        }
        else if getTest == "DASH" {
            testArray = ["Copy Best", "Copy Fast", "Alphabet", "Free"]
            testScoresToDisplay = [getDashBest, getDashFast, getDashAlpha, getDashFree]
        }
        else if getTest == "BPVS-3" {
            testArray = ["Raw Score", "Standardised Score", "No. Errors", "Final Set"]
            testScoresToDisplay = [getBPVSFinal, getBPVSStandardised!, getBPVSErrors, getBPVSSetNum]
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
        
        if getTest == "Towre-2" {
            let scaledLimitline = (100.0 / 145.0) * 100.0
            let limitline = ChartLimitLine(limit: scaledLimitline, label: "Average")
            barChartView.leftAxis.addLimitLine(limitline)
            let scaledLowerLimitline = (86.0 / 145.0) * 100.0
            let limitlineLower = ChartLimitLine(limit: scaledLowerLimitline, label: "Below Average")
            barChartView.leftAxis.addLimitLine(limitlineLower)
            let scaledUpperLimitline = (116.0 / 145.0) * 100.0
            let limitlineUpper = ChartLimitLine(limit: scaledUpperLimitline, label: "Above Average")
            barChartView.leftAxis.addLimitLine(limitlineUpper)
        }
        else if getTest == "BPVS-3" {
            let limitline = ChartLimitLine(limit: 78.0, label: "9-11 Years Average")
            barChartView.leftAxis.addLimitLine(limitline)
            let limitlineLower = ChartLimitLine(limit: 65.0, label: "Below Average")
            barChartView.leftAxis.addLimitLine(limitlineLower)
            let limitlineUpper = ChartLimitLine(limit: 90.0, label: "Above Average")
            barChartView.leftAxis.addLimitLine(limitlineUpper)
        }
        
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
        towrePercentageSWE = (getTowreSWE / 145.0) * 100.0
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
        towrePercentagePDE = (getTowrePDE / 145.0) * 100.0
    }
    
    func testPercentage() {
        digitSpanPercentage = (getDigitSpan / 157.0) * 100.0
    }
    
    func getDigitSpanPercentile() {
        if getDigitSpan >= 145 {
            digitSpanPercentile = "99.9"
        }
        else {
            switch getDigitSpan {
            case 54.0:
                digitSpanPercentile = "0.1"
            case 55.0:
                digitSpanPercentile = "0.1"
            case 56.0:
                digitSpanPercentile = "0.2"
            case 57.0:
                digitSpanPercentile = "0.2"
            case 58.0:
                digitSpanPercentile = "0.3"
            case 59.0:
                digitSpanPercentile = "0.3"
            case 60.0:
                digitSpanPercentile = "0.4"
            case 61.0:
                digitSpanPercentile = "0.5"
            case 62.0:
                digitSpanPercentile = "0.6"
            case 63.0:
                digitSpanPercentile = "0.7"
            case 64.0:
                digitSpanPercentile = "0.8"
            case 65.0:
                digitSpanPercentile = "1"
            case 66.0:
                digitSpanPercentile = "1"
            case 67.0:
                digitSpanPercentile = "1"
            case 68.0:
                digitSpanPercentile = "2"
            case 69.0:
                digitSpanPercentile = "2"
            case 70.0:
                digitSpanPercentile = "2"
            case 71.0:
                digitSpanPercentile = "3"
            case 72.0:
                digitSpanPercentile = "3"
            case 73.0:
                digitSpanPercentile = "4"
            case 74.0:
                digitSpanPercentile = "4"
            case 75.0:
                digitSpanPercentile = "5"
            case 76.0:
                digitSpanPercentile = "5"
            case 77.0:
                digitSpanPercentile = "6"
            case 78.0:
                digitSpanPercentile = "7"
            case 79.0:
                digitSpanPercentile = "8"
            case 80.0:
                digitSpanPercentile = "9"
            case 81.0:
                digitSpanPercentile = "10"
            case 82.0:
                digitSpanPercentile = "12"
            case 83.0:
                digitSpanPercentile = "13"
            case 84.0:
                digitSpanPercentile = "14"
            case 85.0:
                digitSpanPercentile = "16"
            case 86.0:
                digitSpanPercentile = "18"
            case 87.0:
                digitSpanPercentile = "19"
            case 88.0:
                digitSpanPercentile = "21"
            case 89.0:
                digitSpanPercentile = "23"
            case 90.0:
                digitSpanPercentile = "25"
            case 91.0:
                digitSpanPercentile = "27"
            case 92.0:
                digitSpanPercentile = "30"
            case 93.0:
                digitSpanPercentile = "32"
            case 94.0:
                digitSpanPercentile = "34"
            case 95.0:
                digitSpanPercentile = "37"
            case 96.0:
                digitSpanPercentile = "39"
            case 97.0:
                digitSpanPercentile = "42"
            case 98.0:
                digitSpanPercentile = "45"
            case 99.0:
                digitSpanPercentile = "47"
            case 100.0:
                digitSpanPercentile = "50"
            case 101.0:
                digitSpanPercentile = "53"
            case 102.0:
                digitSpanPercentile = "55"
            case 103.0:
                digitSpanPercentile = "58"
            case 104.0:
                digitSpanPercentile = "61"
            case 105.0:
                digitSpanPercentile = "63"
            case 106.0:
                digitSpanPercentile = "66"
            case 107.0:
                digitSpanPercentile = "68"
            case 108.0:
                digitSpanPercentile = "70"
            case 109.0:
                digitSpanPercentile = "73"
            case 110.0:
                digitSpanPercentile = "75"
            case 111.0:
                digitSpanPercentile = "77"
            case 112.0:
                digitSpanPercentile = "79"
            case 113.0:
                digitSpanPercentile = "81"
            case 114.0:
                digitSpanPercentile = "82"
            case 115.0:
                digitSpanPercentile = "84"
            case 116.0:
                digitSpanPercentile = "86"
            case 117.0:
                digitSpanPercentile = "87"
            case 118.0:
                digitSpanPercentile = "88"
            case 119.0:
                digitSpanPercentile = "90"
            case 120.0:
                digitSpanPercentile = "91"
            case 121.0:
                digitSpanPercentile = "92"
            case 122.0:
                digitSpanPercentile = "93"
            case 123.0:
                digitSpanPercentile = "94"
            case 124.0:
                digitSpanPercentile = "95"
            case 125.0:
                digitSpanPercentile = "95"
            case 126.0:
                digitSpanPercentile = "96"
            case 127.0:
                digitSpanPercentile = "96"
            case 128.0:
                digitSpanPercentile = "97"
            case 129.0:
                digitSpanPercentile = "97"
            case 130.0:
                digitSpanPercentile = "98"
            case 131.0:
                digitSpanPercentile = "98"
            case 132.0:
                digitSpanPercentile = "98"
            case 133.0:
                digitSpanPercentile = "99"
            case 134.0:
                digitSpanPercentile = "99"
            case 135.0:
                digitSpanPercentile = "99"
            case 136.0:
                digitSpanPercentile = "99.2"
            case 137.0:
                digitSpanPercentile = "99.3"
            case 138.0:
                digitSpanPercentile = "99.4"
            case 139.0:
                digitSpanPercentile = "99.5"
            case 140.0:
                digitSpanPercentile = "99.6"
            case 141.0:
                digitSpanPercentile = "99.7"
            case 142.0:
                digitSpanPercentile = "99.7"
            case 143.0:
                digitSpanPercentile = "99.8"
            case 144.0:
                digitSpanPercentile = "99.8"
            default:
                digitSpanPercentile = "0"
            }
        }
    }
    
    func getDashPercentile() {
        let tempFinalResult = getDashFinal
        if tempFinalResult <= 54.0 {
            dashPercentile = "0.2"
        }
        else {
            switch tempFinalResult {
            case 59.0:
                dashPercentile = "0.4"
            case 62.0:
                dashPercentile = "0.7"
            case 67.0:
                dashPercentile = "2.0"
            case 70.0:
                dashPercentile = "2.7"
            case 72.0:
                dashPercentile = "3.8"
            case 74.0:
                dashPercentile = "4.2"
            case 75.0:
                dashPercentile = "4.9"
            case 76.0:
                dashPercentile = "6.0"
            case 77.0:
                dashPercentile = "7.1"
            case 79.0:
                dashPercentile = "8.8"
            case 80.0:
                dashPercentile = "10.1"
            case 82.0:
                dashPercentile = "12.8"
            case 84.0:
                dashPercentile = "15.4"
            case 86.0:
                dashPercentile = "18.7"
            case 87.0:
                dashPercentile = "21.4"
            case 89.0:
                dashPercentile = "24.0"
            case 90.0:
                dashPercentile = "28.4"
            case 92.0:
                dashPercentile = "30.0"
            case 93.0:
                dashPercentile = "32.2"
            case 94.0:
                dashPercentile = "36.1"
            case 95.0:
                dashPercentile = "39.6"
            case 97.0:
                dashPercentile = "44.1"
            case 99.0:
                dashPercentile = "48.5"
            case 100.0:
                dashPercentile = "52.4"
            case 102.0:
                dashPercentile = "57.7"
            case 104.0:
                dashPercentile = "61.7"
            case 105.0:
                dashPercentile = "64.3"
            case 106.0:
                dashPercentile = "68.5"
            case 108.0:
                dashPercentile = "71.8"
            case 109.0:
                dashPercentile = "73.1"
            case 110.0:
                dashPercentile = "76.0"
            case 111.0:
                dashPercentile = "79.1"
            case 113.0:
                dashPercentile = "82.2"
            case 114.0:
                dashPercentile = "83.5"
            case 116.0:
                dashPercentile = "86.8"
            case 118.0:
                dashPercentile = "89.0"
            case 119.0:
                dashPercentile = "91.2"
            case 121.0:
                dashPercentile = "92.5"
            case 122.0:
                dashPercentile = "93.2"
            case 123.0:
                dashPercentile = "94.5"
            case 124.0:
                dashPercentile = "95.1"
            case 126.0:
                dashPercentile = "96.2"
            case 127.0:
                dashPercentile = "97.1"
            case 129.0:
                dashPercentile = "97.4"
            case 130.0:
                dashPercentile = "98.4"
            case 133.0:
                dashPercentile = "98.7"
            case 134.0:
                dashPercentile = "98.9"
            case 135.0:
                dashPercentile = "99.1"
            case 136.0:
                dashPercentile = "99.3"
            case 138.0:
                dashPercentile = "99.6"
            case 141.0:
                dashPercentile = "99.8"
            case 146.0:
                dashPercentile = "100.0"
            default:
                dashPercentile = "Error Occurred"
            }
        }
    }
    
    //Stats for Age 10years 0-2months
    func standardiseBPVS() {
        if getBPVSFinal < 99 {
            getBPVSStandardised = 69.0
        }
        else {
            switch getBPVSFinal {
            case 99.0:
                getBPVSStandardised = 70.0
            case 100.0:
                getBPVSStandardised = 71.0
            case 101.0:
                getBPVSStandardised = 72.0
            case 102.0:
                getBPVSStandardised = 73.0
            case 103.0:
                getBPVSStandardised = 74.0
            case 104.0:
                getBPVSStandardised = 75.0
            case 105.0:
                getBPVSStandardised = 76.0
            case 106.0:
                getBPVSStandardised = 77.0
            case 107.0:
                getBPVSStandardised = 78.0
            case 108.0:
                getBPVSStandardised = 79.0
            case 109.0:
                getBPVSStandardised = 80.0
            case 110.0:
                getBPVSStandardised = 80.0
            case 111.0:
                getBPVSStandardised = 81.0
            case 112.0:
                getBPVSStandardised = 81.0
            case 113.0:
                getBPVSStandardised = 82.0
            case 114.0:
                getBPVSStandardised = 82.0
            case 115.0:
                getBPVSStandardised = 83.0
            case 116.0:
                getBPVSStandardised = 83.0
            case 117.0:
                getBPVSStandardised = 84.0
            case 118.0:
                getBPVSStandardised = 84.0
            case 119.0:
                getBPVSStandardised = 85.0
            case 120.0:
                getBPVSStandardised = 86.0
            case 121.0:
                getBPVSStandardised = 87.0
            case 122.0:
                getBPVSStandardised = 87.0
            case 123.0:
                getBPVSStandardised = 88.0
            case 124.0:
                getBPVSStandardised = 89.0
            case 125.0:
                getBPVSStandardised = 90.0
            case 126.0:
                getBPVSStandardised = 92.0
            case 127.0:
                getBPVSStandardised = 93.0
            case 128.0:
                getBPVSStandardised = 94.0
            case 129.0:
                getBPVSStandardised = 95.0
            case 130.0:
                getBPVSStandardised = 96.0
            case 131.0:
                getBPVSStandardised = 97.0
            case 132.0:
                getBPVSStandardised = 98.0
            case 133.0:
                getBPVSStandardised = 99.0
            case 134.0:
                getBPVSStandardised = 100.0
            case 135.0:
                getBPVSStandardised = 101.0
            case 136.0:
                getBPVSStandardised = 102.0
            case 137.0:
                getBPVSStandardised = 102.0
            case 138.0:
                getBPVSStandardised = 103.0
            case 139.0:
                getBPVSStandardised = 104.0
            case 140.0:
                getBPVSStandardised = 105.0
            case 141.0:
                getBPVSStandardised = 106.0
            case 142.0:
                getBPVSStandardised = 107.0
            case 143.0:
                getBPVSStandardised = 107.0
            case 144.0:
                getBPVSStandardised = 108.0
            case 145.0:
                getBPVSStandardised = 109.0
            case 146.0:
                getBPVSStandardised = 110.0
            case 147.0:
                getBPVSStandardised = 112.0
            case 148.0:
                getBPVSStandardised = 113.0
            case 149.0:
                getBPVSStandardised = 114.0
            case 150.0:
                getBPVSStandardised = 115.0
            case 151.0:
                getBPVSStandardised = 117.0
            case 152.0:
                getBPVSStandardised = 118.0
            case 153.0:
                getBPVSStandardised = 120.0
            case 154.0:
                getBPVSStandardised = 121.0
            case 155.0:
                getBPVSStandardised = 122.0
            case 156.0:
                getBPVSStandardised = 123.0
            case 157.0:
                getBPVSStandardised = 125.0
            case 158.0:
                getBPVSStandardised = 126.0
            case 159.0:
                getBPVSStandardised = 127.0
            case 160.0:
                getBPVSStandardised = 128.0
            case 161.0:
                getBPVSStandardised = 129.0
            case 162.0:
                getBPVSStandardised = 131.0
            case 163.0:
                getBPVSStandardised = 132.0
            case 164.0:
                getBPVSStandardised = 133.0
            case 165.0:
                getBPVSStandardised = 134.0
            case 166.0:
                getBPVSStandardised = 135.0
            case 167.0:
                getBPVSStandardised = 137.0
            case 168.0:
                getBPVSStandardised = 138.0
            default:
                getBPVSStandardised = 0.0
            }
        }
    }
    
}
