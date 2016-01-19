//
//  ListTableViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 25/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // outlet for re-loading expense list
    @IBOutlet var reloadExpenseList: UITableView!
    
    //
    // removeExpenseOnButtonPress function lets you remove expense in alert controller view
    // - function is triggered by pressing wished 'expense' button
    //
    @IBAction func removeExpenseOnButtonPress(sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to remove expense?", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add Yes-button to remove expense type
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            MyGlobalVariables.myArrayOfExpenses.removeAtIndex(sender.tag)
            
            // reload removes expense from view
            self.reloadExpenseList.reloadData()
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
        
        // total expenses are counted only here
        
        MyGlobalVariables.expenseTotal = 0.0
        let expensesCount = MyGlobalVariables.myArrayOfExpenses.count
        
        // sum expenses to expenseTotal variable
        for index in 0..<expensesCount {
            MyGlobalVariables.expenseTotal += MyGlobalVariables.myArrayOfExpenses[index].expenseValue
        }
        
        // re-load needed to update expense list in view
        self.reloadExpenseList.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobalVariables.myArrayOfExpenses.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExpenseItemCellId", forIndexPath: indexPath) as! ListTableViewCell
        
        // Configure the cell...
//        if indexPath.row == 0 {
//            // show total expense in first cell's button title
//            let totalExpense = String(format: "Total epenses:    %@", arguments: [
//                String(MyGlobalVariables.expenseTotal)])
//            
//            cell.expenseNameAsButtonTitle.setTitle(totalExpense, forState: UIControlState.Normal)
//        }
//        else {
            // collect expense record
            let expense = String(format: "%@     %@     %@", arguments: [
                MyGlobalVariables.myArrayOfExpenses[indexPath.row].date,
                String(MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseValue),
                MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseType])
            
            // show expense record in cell's button title
            cell.expenseNameAsButtonTitle.setTitle(expense, forState: UIControlState.Normal)
            
            // this tag is used as index to point the expense in myArrayOfExpenses table
            // when 'removeExpenseOnButtonPress' button is pressed in order to remove the expense
            cell.expenseNameAsButtonTitle.tag = indexPath.row
       // }
        return cell
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Expenses"
//    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // total expense is displayed in footer cell
        let headerCell = tableView.dequeueReusableCellWithIdentifier("ListHeaderCellId") as! ListHeaderTableViewCell
        headerCell.expenseTotalLabel.text = String(MyGlobalVariables.expenseTotal)
        headerCell.backgroundColor = UIColor.lightGrayColor()
        
        return headerCell
    }

}
