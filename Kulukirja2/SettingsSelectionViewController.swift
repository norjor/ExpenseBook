//
//  SettingsSelectionViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 03/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class SettingsSelectionViewController: UIViewController {

    //
    // removeAllExpenses function makes you confirm that you really want to remove all expenses
    // - function is triggered by 'Remove all expenses' button
    //
    @IBAction func removeAllExpenses()
    {
        let alertController = UIAlertController(title: title, message: "Are you sure you want to remove all expenses?", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add Yes-button to remove all expenses
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            MyGlobalVariables.myArrayOfExpenses.removeAll()
        }
        
        alertController.addAction(OKAction)
        
        // add No-button to cancel action
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            // do nothing
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func importFromJson(sender: UIButton) {
        
        let alertController = UIAlertController(title: title, message: "Are you sure you want to import expenses.json?", preferredStyle:UIAlertControllerStyle.Alert)
        
        // add Yes-button to remove all expenses
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            
            if let path = NSBundle.mainBundle().pathForResource("expenses", ofType: "json") {
                
                do {
                    let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    
                    do {
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        if let expenses = jsonResult["expense"] as? [NSDictionary] {
                            
                            for expense in expenses {
                                
                                let uniqId = expense["uniqueKey"] as! String
                                let date = expense["date"] as! String
                                let value: Float = (expense["expenseValue"] as! NSString).floatValue
                                let type = expense["expenseType"] as! String
                                
                                let expenseRecord = ExpenseClass(uniqueKey: uniqId,
                                    date: date,
                                    expenseValue: value,
                                    expenseType: type)
                                
                                // new record is inserted into expense array as first element
                                MyGlobalVariables.myArrayOfExpenses.insert(expenseRecord, atIndex: 0)
                            }
                        }
                    } catch {print("jsonResult: jsonData serialzation failed \(error)")}
                } catch {print("jsonData: file fetch to NSData failed \(error)")}
            }
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
        
        
//        
//        var arr: [[String:String]] = [[:]]
//        var dic: [String:String] = [:]
//        
//        do {
//            
//            dic["test1"] = "31.1.16"
//            dic["value"] = "11.10"
//            dic["type"] = "ruoka"
//            
//            arr.append(dic)
//            
//            let jsonData = try NSJSONSerialization.dataWithJSONObject(arr, options: NSJSONWritingOptions.PrettyPrinted)
//            let str = String(data: jsonData, encoding: NSUTF8StringEncoding)
//            
//            print(str)
//            
//            let filePath = documentsDirectory().stringByAppendingPathComponent("expenses2.json")
//            
//            // save myArrayOfExpenses to file
//            NSKeyedArchiver.archiveRootObject(dic, toFile: filePath)
//            
//            print(filePath)
//            
//            
//        } catch let error as NSError {
//            print(error)
//        }
        
        
        
    }
    
    func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        
        return documentDirectory
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
