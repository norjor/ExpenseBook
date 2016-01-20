//
//  ListViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 19/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalExpenses: UILabel!
    
    
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
            self.tableView.reloadData()
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

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // total expenses are counted only here
        
        MyGlobalVariables.expenseTotal = 0.0
        let expensesCount = MyGlobalVariables.myArrayOfExpenses.count
        
        // sum expenses to expenseTotal variable
        for index in 0..<expensesCount {
            MyGlobalVariables.expenseTotal += MyGlobalVariables.myArrayOfExpenses[index].expenseValue
        }
        
        totalExpenses.text = String(MyGlobalVariables.expenseTotal)
        totalExpenses.backgroundColor = UIColor.lightGrayColor()
        
        // re-load needed to update expense list in view
        self.tableView.reloadData()
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
        return MyGlobalVariables.myArrayOfExpenses.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListItemId", forIndexPath: indexPath) as! ListTableViewCell
        
        // Configure the cell...
        // build expense record
        let expense = String(format: "%@              %@                        %@", arguments: [
            MyGlobalVariables.myArrayOfExpenses[indexPath.row].date,
            String(format: "%6.2f", MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseValue),
            MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseType])
        
//        let text1 = MyGlobalVariables.myArrayOfExpenses[indexPath.row].date
//        let text2 = String(format: "%8.2f", MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseValue)
//        let text3 = MyGlobalVariables.myArrayOfExpenses[indexPath.row].expenseType
//        
//        let expense = String(format: "%-22s",(text1 as NSString).UTF8String) +
//            text2 +
//            String(format: "%25s",(text3 as NSString).UTF8String)
        
        
        // show expense record in cell's button title
        cell.expenseItemAsButtonTitle.setTitle(expense, forState: UIControlState.Normal)
        
        // this tag is used as index to point the expense in myArrayOfExpenses table
        // when 'removeExpenseOnButtonPress' button is pressed in order to remove the expense
        cell.expenseItemAsButtonTitle.tag = indexPath.row
        
        return cell
    }

}
