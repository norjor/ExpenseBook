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
//        
//        // add Yes-button for importing expenses
//        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
//            
//            let urlString = "http://jono56.arkku.net/expenses.json"
//            let url = NSURL(string: urlString)
//
//            let request = NSURLRequest(URL: url!)
//            
//            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//            let session = NSURLSession(configuration: config)
//            
//            let dataTask = session.dataTaskWithRequest(request) {
//                (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
//                
//                guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
//                    else {
//                        print("error: not a valid http response")
//                        return
//                }
//                // It must be now parsed according to rules if response is OK (200)
//                print(httpResponse.statusCode)
//                if (httpResponse.statusCode == 200)
//                {
//                    // The JSON is be parsed out here and its contents used
//                    do {
//                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
//                        
//                            for expense in jsonResult {
//                                
//                                let uniqId = expense["uniqueKey"] as! String
//                                let date = expense["date"] as! String
//                                let value: Float = (expense["expenseValue"] as! NSString).floatValue
//                                let type = expense["expenseType"] as! String
//                                
//                                let expenseRecord = ExpenseClass(uniqueKey: uniqId,
//                                    date: date,
//                                    expenseValue: value,
//                                    expenseType: type)
//                                
//                                // new record is inserted into expense array as first element
//                                MyGlobalVariables.myArrayOfExpenses.insert(expenseRecord, atIndex: 0)
//                            }
//                    } catch {print("jsonResult: jsonData serialzation failed \(error)")}
//                
//                    
//                    //dispatch_async(dispatch_get_main_queue()) {} // tarvitaanko ja mihin ?????
//
//                }
//                else {
//                    print("Error in HTTP Response")
//                }
//                
//            }
//            // start actual asynchronous task
//            dataTask.resume()
//        }
        
//        alertController.addAction(OKAction)
        
        // add No-button to cancel action
        let cancelAction = UIAlertAction(title: "No implementation yet", style: .Cancel) { (action) in
            // do nothing
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

//    @IBAction func importFromJson(sender: UIButton) {
//        
//        let alertController = UIAlertController(title: title, message: "Are you sure you want to import expenses.json?", preferredStyle:UIAlertControllerStyle.Alert)
//        
//        // add Yes-button to remove all expenses
//        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
//            
//            if let path = NSBundle.mainBundle().pathForResource("expenses", ofType: "json") {
//                
//                do {
//                    let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
//                    
//                    do {
//                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                        
//                        if let expenses = jsonResult["expense"] as? [NSDictionary] {
//                            
//                            for expense in expenses {
//                                
//                                let uniqId = expense["uniqueKey"] as! String
//                                let date = expense["date"] as! String
//                                let value: Float = (expense["expenseValue"] as! NSString).floatValue
//                                let type = expense["expenseType"] as! String
//                                
//                                let expenseRecord = ExpenseClass(uniqueKey: uniqId,
//                                    date: date,
//                                    expenseValue: value,
//                                    expenseType: type)
//                                
//                                // new record is inserted into expense array as first element
//                                MyGlobalVariables.myArrayOfExpenses.insert(expenseRecord, atIndex: 0)
//                            }
//                        }
//                    } catch {print("jsonResult: jsonData serialzation failed \(error)")}
//                } catch {print("jsonData: file fetch to NSData failed \(error)")}
//            }
//        }
//        
//        alertController.addAction(OKAction)
//        
//        // add No-button to cancel action
//        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
//            // do nothing
//        }
//        
//        alertController.addAction(cancelAction)
//        
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
