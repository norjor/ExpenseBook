//
//  Utilities.swift
//  Kulukirja2
//
//  Created by Koulutus on 25/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class Utilities {

    //
    // function generates a unique string of given length
    //
    func randomStringWithLength (len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return String(randomString)
    }

    //
    // function for current date
    //  date format given as argument e.g. "dd MM yyyy"
    //
    func getCurrentDate(dateFormat : String) -> String {
        
        // get the current date
        let currentDate = NSDate()
        
        // initialize the date formatter and set the date format
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        
        // get the date String from the date object
        return formatter.stringFromDate(currentDate)
    }
    
    //
    // Change month of given date by positive or negative value
    //  e.g. to previous month by changeByValue = -1
    //
    func changeMonth (date : String, changeByValue : Int) -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM yyyy"
        let oldDate = formatter.dateFromString(date)
        let calendar = NSCalendar.currentCalendar()
        let newDate = calendar.dateByAddingUnit(.Month, value: changeByValue, toDate: oldDate!, options: [])
        
        return formatter.stringFromDate(newDate!)
    }
    
    //
    // function for filtering expense items according to monthAndYearSelection
    //
    func isMonthAndYearSame (expense : ExpenseClass) -> Bool {
        
        let expenseDate = expense.date
        
        // pick year and month out of filter date "MM yyyy"
        let month = MyGlobalVariables.monthAndYearSelection.substringWithRange(Range<String.Index>(start: MyGlobalVariables.monthAndYearSelection.startIndex, end: MyGlobalVariables.monthAndYearSelection.startIndex.advancedBy(3)))
        
        let year = MyGlobalVariables.monthAndYearSelection.substringWithRange(Range<String.Index>(start: MyGlobalVariables.monthAndYearSelection.endIndex.advancedBy(-4), end: MyGlobalVariables.monthAndYearSelection.endIndex))
        
        // are year and month in expense date?
        if (expenseDate.rangeOfString(month) != nil) && (expenseDate.rangeOfString(year) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    //
    // function for showing/removing "No expenses" text from view
    //
    func showNoExpenses(myView : UIView) {
        // show 'No expenses' text if there are no expenses
        if MyGlobalVariables.filteredArrayOfExpenses.isEmpty {
            
            let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            label.center = CGPointMake(myView.bounds.width/2, myView.bounds.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "No expenses"
            label.tag = 1000
            myView.addSubview(label)
        }
        else {
            for subView in myView.subviews {
                if subView.tag == 1000 {
                    subView.removeFromSuperview()
                }
            }
        }
    }

}
