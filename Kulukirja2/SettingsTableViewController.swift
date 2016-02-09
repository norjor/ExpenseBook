//
//  SettingsTableViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 30/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // outlet for re-loading expense list
    @IBOutlet var expensesReload: UITableView!
    
    // outlet for re-loading type list
    @IBOutlet var typesReload: UITableView!
    
    //
    // removeAllTypes function makes you confirm that you really want to remove all expense types
    // - function is triggered by 'Remove all types' button
    //
    @IBAction func removeAllTypes()
    {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to remove all types?", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add Yes-button to remove all expense types
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            MyGlobalVariables.myTypes.removeAll()
            
            // reload empties types from view
            self.typesReload.reloadData()
        }
        
        alertController.addAction(OKAction)
        
        // add No-button to cancel action
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            // do nothing
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    
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
        
        // Add button for adding new type to myTypes array
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
        
        // this prevents some odd textfield related warning prints - specific to 6s simulator
        alertController.view.setNeedsLayout()
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //
    // manageTypeOnButtonPress function lets you rename or remove expense type in alert controller view
    // - function is triggered by pressing wished 'type' button
    //
    @IBAction func manageTypeOnButtonPress(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Change type", message: "Note: Doesn't change existing expenses", preferredStyle:UIAlertControllerStyle.Alert)
        
        let rename = UIAlertAction(title: "Rename type", style: .Default) { (action) in
            self.doRename(sender)
        }
        alertController.addAction(rename)
        
        let remove = UIAlertAction(title: "Remove type", style: .Default) { (action) in
            self.verifyRemove(sender)
        }
        alertController.addAction(remove)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //
    // do expense type rename
    //
    func doRename(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Remove type", message: "", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add text field for new type
        alertController.addTextFieldWithConfigurationHandler { (myTextField) in
            myTextField.placeholder = "< \(MyGlobalVariables.myTypes[sender.tag]) >"
            myTextField.keyboardType = .NamePhonePad
        }
        
        let rename = UIAlertAction(title: "Rename", style: .Default) { (action) in
            let newTypeTextField = alertController.textFields!.first! as UITextField
            if newTypeTextField.text?.isEmpty == false {
                MyGlobalVariables.myTypes[sender.tag] = newTypeTextField.text!
                
                // reload removes type from view
                self.typesReload.reloadData()
            }
        }
        alertController.addAction(rename)
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // do nothing
        }
        alertController.addAction(cancel)
        
        // this prevents some odd textfield related warning prints - specific to 6s simulator
        alertController.view.setNeedsLayout()
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //
    // verify expense type remove by yes or no button
    //
    func verifyRemove(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Are you sure?", message: "", preferredStyle:UIAlertControllerStyle.Alert)
        
        let yes = UIAlertAction(title: "yes", style: .Default) { (action) in
                MyGlobalVariables.myTypes.removeAtIndex(sender.tag)
            
                // reload removes type from view
                self.typesReload.reloadData()
        }
        alertController.addAction(yes)
        
        let nope = UIAlertAction(title: "no", style: .Cancel) { (action) in
            // do nothing
        }
        alertController.addAction(nope)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // re-load needed to update expense list
        self.expensesReload.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("SettingHeaderCellId") as! SettingsHeaderTableViewCell
        headerCell.backgroundColor = UIColor.lightGrayColor()
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCellWithIdentifier("SettingsFooterCellId") as! SettingsFooterTableViewCell
        footerCell.backgroundColor = UIColor.lightGrayColor()
        
        return footerCell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobalVariables.myTypes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsTypeCellId", forIndexPath: indexPath) as! SettingsTableViewCell

        // Configure the cell...
        // Button in cell is configured by expense type
        let expenseType = MyGlobalVariables.myTypes[indexPath.row]

        cell.typeNameAsButtonTitle.setTitle(expenseType, forState: UIControlState.Normal)
        
        // this tag is used as index to get type name from myTypes table later
        // when type button is pressed in order to remove current type
        cell.typeNameAsButtonTitle.tag = indexPath.row
        
        return cell
    }

}
