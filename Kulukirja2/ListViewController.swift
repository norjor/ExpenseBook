//
//  ListViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 19/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    var myUtilities = Utilities()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalExpenses: UILabel!
    
    @IBOutlet weak var MonthButton: UIButton!
    
    @IBAction func PrevButton(sender: UIButton) {
        MyGlobalVariables.monthAndYearSelection = myUtilities.changeMonth(MonthButton.titleForState(.Normal)!, changeByValue: -1)
        updateFilteredExpenses()
    }
    
    @IBAction func NextButton(sender: UIButton) {
        MyGlobalVariables.monthAndYearSelection = myUtilities.changeMonth(MonthButton.titleForState(.Normal)!, changeByValue: 1)
        updateFilteredExpenses()
    }
    
    //
    // function for filtering expenses according to monthAndYearSelection
    //  also total expenses are counted and viewed
    //
    func updateFilteredExpenses() {
        
        // show selected month and year
        MonthButton.setTitle(MyGlobalVariables.monthAndYearSelection, forState: UIControlState.Normal)
        
        // filter from all expenses according to month and year
        MyGlobalVariables.filteredArrayOfExpenses =  MyGlobalVariables.myArrayOfExpenses.filter(myUtilities.isMonthAndYearSame)
    
        
        // total expenses of filtered expenses
        MyGlobalVariables.expenseTotal = 0.0
        
        // add expenses to expenseTotal variable
        for index in 0..<MyGlobalVariables.filteredArrayOfExpenses.count {
            MyGlobalVariables.expenseTotal += MyGlobalVariables.filteredArrayOfExpenses[index].expenseValue
        }
        
        totalExpenses.text = String(MyGlobalVariables.expenseTotal)
        
        // re-load needed to update expense list in view
        self.tableView.reloadData()
        
        // show 'No expenses' text if there are no expenses
        myUtilities.showNoExpenses(self.view)
    }
    
    
    //
    // removeExpenseOnButtonPress function lets you remove expense in 
    // alert controller view
    // - function is triggered by pressing wished 'expense' button
    //
    @IBAction func removeExpenseOnButtonPress(sender: UIButton) {
        
        // find out the array index of all_expenses_array,
        // remove and add item is done only to that array
        var expenseIndex = 0
        while expenseIndex<MyGlobalVariables.myArrayOfExpenses.count {
            
            if MyGlobalVariables.myArrayOfExpenses[expenseIndex].uniqueKey == sender.accessibilityIdentifier {
                break
            }
            expenseIndex++
        }
        
        let date = MyGlobalVariables.myArrayOfExpenses[expenseIndex].date + "  "
        let value = String(MyGlobalVariables.myArrayOfExpenses[expenseIndex].expenseValue) + "  "
        let type = MyGlobalVariables.myArrayOfExpenses[expenseIndex].expenseType
        
        let alertController = UIAlertController(title: "Are you sure you want to remove expense?", message: date+value+type, preferredStyle:UIAlertControllerStyle.Alert)
        
        // add Yes-button to remove expense type
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            MyGlobalVariables.myArrayOfExpenses.removeAtIndex(expenseIndex)
            
            //update view
            self.updateFilteredExpenses()
        }
        
        alertController.addAction(OKAction)
        
        // add No-button to cancel action
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            // do nothing
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // update filtered expenses to view
        updateFilteredExpenses()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobalVariables.filteredArrayOfExpenses.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListItemId", forIndexPath: indexPath) as! ListTableViewCell
        
        // Configure the cell...
        
//        let text1 = MyGlobalVariables.myArrayOfExpenses[indexPath.row].date
//        let text2 = String(format: "%8.2f", MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseValue)
//        let text3 = MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseType
//        
//        let expense = String(format: "%-22s",(text1 as NSString).UTF8String) +
//            text2 +
//            String(format: "%25s",(text3 as NSString).UTF8String)
        
        
        var date = MyGlobalVariables.filteredArrayOfExpenses[indexPath.row].date
        let dateLen = date.characters.count
        let datePadding : Array<Character> = Array(count: 16 - dateLen, repeatedValue: " ")
        date = date + String(datePadding)
        
        let expenseValue = String(format: "%8.2f", MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseValue)
        
        var expenseType = MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseType
        let expenseTypeLen = expenseType.characters.count
        let typePadding : Array<Character> = Array(count: 20 - expenseTypeLen, repeatedValue: " ")
        expenseType = String(typePadding) + expenseType

        let expense = date + expenseValue + expenseType
        
        // show expense record in cell's button title
        cell.expenseItemAsButtonTitle.setTitle(expense, forState: UIControlState.Normal)
        
        // this tag is used as index to point the expense in myArrayOfExpenses table
        // when 'removeExpenseOnButtonPress' button is pressed in order to remove the expense
        cell.expenseItemAsButtonTitle.accessibilityIdentifier = MyGlobalVariables.filteredArrayOfExpenses[indexPath.row].uniqueKey
        
        return cell
    }
}

