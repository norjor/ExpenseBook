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
    
    // instance of utility class for accessing some utility functions
    var myUtilities = Utilities()
    
    // chart selection between Pie and Bar, Pie as default
    var selectedChart = "Pie"

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var ChartSegmentedControl: UISegmentedControl!
    
    // Segmented control to select between Pie and Bar chart view
    @IBAction func ChangeChart(sender: UISegmentedControl) {
        
        switch ChartSegmentedControl.selectedSegmentIndex {
        case 0:
            // draw Pie chart
            selectedChart = "Pie"
            filterAndDrawChart(selectedChart)
        case 1:
            // draw Bar chart
            selectedChart = "Bar"
            filterAndDrawChart(selectedChart)
        default:
            break
        }
    }
    
    // Shows current/selected month (and year)
    @IBOutlet weak var MonthButton: UIButton!
    
    // Shift to previous month
    @IBAction func PrevButton(sender: UIButton) {
        MyGlobalVariables.monthAndYearSelection = myUtilities.changeMonth(MonthButton.titleForState(.Normal)!, changeByValue: -1)
        filterAndDrawChart(selectedChart)
    }
    
    // Shift to next month
    @IBAction func NextButton(sender: UIButton) {
        MyGlobalVariables.monthAndYearSelection = myUtilities.changeMonth(MonthButton.titleForState(.Normal)!, changeByValue: 1)
        filterAndDrawChart(selectedChart)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Future option... ChartViewDelegate protocal provides tapping actions on charts,
        // see chartValueSelected() below
        pieChartView.delegate = self
        barChartView.delegate = self
        
        self.MonthButton.backgroundColor = UIColor.blackColor()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // draw Pie chart as default
        filterAndDrawChart(selectedChart)
        
        // highlight Pie segment in segmented control
        ChartSegmentedControl.selectedSegmentIndex = 0
    }
    
    //
    // filter expenses and draw a chart of given type
    //
    func filterAndDrawChart(chart : String) {
        
        // show selected month and year
        MonthButton.setTitle(MyGlobalVariables.monthAndYearSelection, forState: UIControlState.Normal)
        
        // filter from all expenses according to month and year
        MyGlobalVariables.filteredArrayOfExpenses =  MyGlobalVariables.myArrayOfExpenses.filter(myUtilities.isMonthAndYearSame)
        
        // hide chart views if no expenses
        if MyGlobalVariables.filteredArrayOfExpenses.isEmpty {
            pieChartView.hidden = true
            barChartView.hidden = true
        }
        else {
            drawChart(chart)
        }
        
        // show 'No expenses' text if there are no expenses
        myUtilities.showNoExpenses(self.view)
    }
    
    //
    // draw chart of given type
    //
    func drawChart(chart : String) {
        
        // expenses by expense types
        var expensesByType = [String : Double]()
        var types : [String] = []
        var typeSums : [Double] = []
    
        // sum expenses for each type into dictionary
        for item in MyGlobalVariables.filteredArrayOfExpenses {
            
            if let totalSum = expensesByType[item.expenseType] {
                expensesByType[item.expenseType] = totalSum + Double(item.expenseValue)
            } else {
                expensesByType[item.expenseType] = Double(item.expenseValue)
            }
        }
        
        // fill expense type and sum arrays from dictionary
        for (type, value) in expensesByType {
            types.append(type)
            typeSums.append(value)
        }
        
        if chart == "Pie" {
            // draw charts of given types and sums
            setPieChart(types, values: typeSums)
            
            barChartView.hidden = true
            pieChartView.hidden = false
            pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)

        }
        else {
            setBarChart(types, values: typeSums)
            
            pieChartView.hidden = true
            barChartView.hidden = false
            barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        }
    }
    
    //
    // Function for drawing Pie chart
    //  arrays of expense types and sums by types as arguments
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
        
        //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
    
    //
    // taps on a bar or segment will run this function
    //
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value)")  // in \(types[entry.xIndex])")
    }
    
}
