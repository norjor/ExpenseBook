//
//  AddExpenseViewController.swift
//  Kulukirja2
//
//  Created by Koulutus on 24/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

struct MyGlobalVariables {
    
    // user given expense value
    static var expenseValue : Float = 0.0
    
    // mutable array for expense types, some pre-defined given, file backup
    static var myTypes = ["Ruoka", "Vaatteet", "Sähkö", "Vesi"]
    
    // array of expense records, file backup
    static var myArrayOfExpenses = [ExpenseClass]()
    
    // total sum of expenses
    static var expenseTotal : Float = 0.0
    
}


class AddExpenseViewController: UIViewController {

    // MARK: Properties
    
    // expense type received from ExpenseTypeTabViewcontroller
    var dataFromExpenseTypeTabViewcontroller : String?
    
    // user given expense value
    @IBOutlet weak var NumberField: UITextField!
    
    // number buttons pressed
    @IBAction func Button_0(sender: UIButton) {
        if updateExpenseValue("0") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_1(sender: UIButton) {
        if updateExpenseValue("1") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_2(sender: UIButton) {
        if updateExpenseValue("2") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!        }
    }
    
    @IBAction func Button_3(sender: UIButton) {
        if updateExpenseValue("3") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_4(sender: UIButton) {
        if updateExpenseValue("4") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_5(sender: UIButton) {
        if updateExpenseValue("5") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_6(sender: UIButton) {
        if updateExpenseValue("6") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!        }
    }
    
    @IBAction func Button_7(sender: UIButton) {
        if updateExpenseValue("7") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_8(sender: UIButton) {
        if updateExpenseValue("8") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_9(sender: UIButton) {
        if updateExpenseValue("9") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_Point(sender: UIButton) {
        if updateExpenseValue(".") == true {
            MyGlobalVariables.expenseValue = Float(NumberField.text!)!
        }
    }
    
    @IBAction func Button_Clear(sender: UIButton) {
        NumberField.text = "0"
        MyGlobalVariables.expenseValue = 0.0
    }
    
    
    //
    // function to add new number to expense value
    //     - returns false to not change value, returns true to accept change
    //
    func updateExpenseValue(newNumber : String) -> Bool {
        
        // this will be the updated value string
        let newString = NumberField.text! + newNumber
        
        let array = Array(newString.characters)
        var pointCount = 0   // count the decimal separators
        var unitCount = 0    // count of units
        var decimalCount = 0 // count of decimals
        
        for character in array { //counting loop
            if character == "." {
                pointCount++
            } else {
                if pointCount == 0 {
                    unitCount++
                } else {
                    decimalCount++
                }
            }
        }
        // units maximum : 6 digits
        if unitCount > 6 {
            print("max value exceeded")
            return false
        }
        // decimal maximum : 2 digits
        if decimalCount > 2 {
            print("max decimals exceeded")
            return false
        }
        // separators maximum : 1 digit
        if pointCount > 1 {
            print("decimal separators exceeded")
            return false
        }
        
        switch newNumber {
            
        case "0","1","2","3","4","5","6","7","8","9":
            if array[0] == "0" && array[1] != "." {
                NumberField.text = newNumber  // remove leading zero
            }
            else {
                NumberField.text = newString
            }
            break
        case ".":
            NumberField.text = newString
            break
        default:
            print("updateExpenseValue: unknown character")
            return false
        }
        return true
    }
    

    //
    // function for current date, used in expense record
    //
    func timeStamp() -> String {
        // get the current date and time
        let currentDateTime = NSDate()
        
        // initialize the date formatter and set the style
        let formatter = NSDateFormatter()
        //formatter.timeStyle = NSDateFormatterStyle.ShortStyle  //time could be added also
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        // get the date time String from the date object
        return formatter.stringFromDate(currentDateTime)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // expense record is created (date,value,type), when we return from 
        // ExpenseTypeTableViewController

        if (dataFromExpenseTypeTabViewcontroller != nil) {
            
            let expenseRecord = ExpenseClass(date: timeStamp(),
                                             expenseValue: MyGlobalVariables.expenseValue,
                                             expenseType: dataFromExpenseTypeTabViewcontroller!)
            
            // new record is inserted into expense array as first element
            MyGlobalVariables.myArrayOfExpenses.insert(expenseRecord, atIndex: 0)

//            let form = String(format: "add  %@\t%7.2f\t%@ ", expenseRecord.date, expenseRecord.expenseValue, expenseRecord.expenseType)
//            print(form)
        }
     }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
