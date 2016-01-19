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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
