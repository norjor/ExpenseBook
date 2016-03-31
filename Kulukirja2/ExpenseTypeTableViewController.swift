//
//  ExpenseTypeTableViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 24/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

class ExpenseTypeTableViewController: UITableViewController {
    
    // MARK: Properties
    
    // outlet for re-loading type list
    @IBOutlet var typesReload: UITableView!
        
    //
    // addNewTypeButton function lets you give new expense type in alert controller view
    // - function is triggered by 'Add new type' button
    //
    @IBAction func addNewTypeButton(sender: UIButton) {
        
        let alertController = UIAlertController(title: title, message: "Add new type", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add text field for new type
        alertController.addTextFieldWithConfigurationHandler { (myTextField) in
            myTextField.placeholder = "<new type>"
            myTextField.keyboardType = .NamePhonePad
        }
        
        // Add button - action to add new type to myTypes array
        let okAction = UIAlertAction(title: "Add", style: .Default) { (action) in
            let newTypeTextField = alertController.textFields!.first! as UITextField
            if newTypeTextField.text?.isEmpty == false {
                MyGlobalVariables.myTypes.append(newTypeTextField.text!)
            }
            
            // reload updates new type in view
            self.typesReload.reloadData()
        }
        
        alertController.addAction(okAction)
        
        // Cancel button for interrupt
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // do nothing
        }
        
        alertController.addAction(cancelAction)
        
        // this prevents some odd warning prints - relates to 6s simulator
        alertController.view.setNeedsLayout()
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return MyGlobalVariables.myTypes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TypeCellId"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseTypeTableViewCell

        // Configure the cell...
        // Button in cell is configured by expense type
        
        let expenseType = MyGlobalVariables.myTypes[indexPath.row]
        cell.typeNameButton.setTitle(expenseType, forState: UIControlState.Normal)
        
        // this tag is used as index to get type name from myTypes table later
        // when type button is pressed and segue to AddExpenseViewController starts
        cell.typeNameButton.tag = indexPath.row
        
        cell.typeNameButton.backgroundColor = UIColor.blackColor()

        return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select type of expense"
    }
    
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCellWithIdentifier("TypeFooterCellId") as! ExpenseTypeFooterTableViewCell
        //footerCell.backgroundColor = UIColor.lightGrayColor()
        
        return footerCell
    }
    
    // MARK: - Navigation
    
    // type button is pressed, expense type is sent to AddExpenseViewController
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:  AnyObject?) {
        if (segue.identifier == "BackToAddExpense") {
            let target = segue.destinationViewController as! AddExpenseViewController
            target.dataFromExpenseTypeTabViewcontroller = MyGlobalVariables.myTypes[Int(sender!.tag)]
        }
    }

}
