//
//  ChartsViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 15/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit
import Charts

// How to add charts to your application using the ios-charts library by Daniel
// Cohen Gindi. ios-charts is an iOS port of the fairly popular Android library
// MPAndroidChart created by Philipp Jahoda.

//Manual installation:
//    
//Download the ios-charts project 
//https://github.com/danielgindi/ios-charts/archive/master.zip 
//The zip file contains the library (in a folder named Charts) and a demo project
//(named ChartsDemo).
//
//Unzip the downloaded file and copy the Charts folder and paste it into your
//project’s root directory. Open this Charts folder in Finder and drag
//Charts.xcodeproj to your project in Xcode.
//
//Next select your project from the Project Navigator and make sure that the target
//is selected. In the General tab on the right, locate the Embedded Binaries section
//and hit the + in this section to add the charts framework. Select Charts.framework
//from the list and click Add.
//
// Add 'import Charts' to your view controller.


class ChartsViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var ChartSegmentedControl: UISegmentedControl!
    
    // Segmented control to select between Pie and Bar chart view
    @IBAction func ChangeChart(sender: UISegmentedControl) {
        switch ChartSegmentedControl.selectedSegmentIndex {
        case 0:
            barChartView.hidden = true
            pieChartView.hidden = false
            pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseInCirc)
        case 1:
            pieChartView.hidden = true
            barChartView.hidden = false
            barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .Linear)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // ChartViewDelegate protocal provides tapping actions,
        // see chartValueSelected() below
        pieChartView.delegate = self
        barChartView.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // expenses by expense types
        var expensesByType = [String : Double]()
        var types : [String] = []
        var typeSums : [Double] = []
        
        // sum expenses for each type into dictionary
        for item in MyGlobalVariables.myArrayOfExpenses {
            
            if let previousSum = expensesByType[item.expenseType] {
                expensesByType[item.expenseType] = previousSum + Double(item.expenseValue)
            } else {
                expensesByType[item.expenseType] = Double(item.expenseValue)
            }
        }
        
        // fill expense type and sum arrays from dictionary
        for (type, value) in expensesByType {
            types.append(type)
            typeSums.append(value)
        }
        
        // draw charts of given types and sums
        setPieChart(types, values: typeSums)
        setBarChart(types, values: typeSums)
        
        // default order of charts in the beginning
        ChartSegmentedControl.selectedSegmentIndex = 0
        barChartView.hidden = true
        pieChartView.hidden = false
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseInCirc)

    }
    
    //
    // Function for drawing Pie chart
    //
    func setPieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Expenses")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        // predefined colour templates available
        pieChartDataSet.colors = ChartColorTemplates.pastel()
        
        pieChartView.descriptionText = ""
        
    }
    
    //
    // Function for drawing Bar chart
    //
    func setBarChart(dataPoints: [String], values: [Double]) {
        
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Expenses")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChartView.data = chartData
        
        // remove description text from view
        barChartView.descriptionText = ""
        
        // predefined colour templates available
        chartDataSet.colors = ChartColorTemplates.pastel()
        
        barChartView.xAxis.labelPosition = .Bottom
        
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
    
    //
    // taps on a bar or segment will run this function
    //
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value)")  // in \(types[entry.xIndex])")
    }
    
}
