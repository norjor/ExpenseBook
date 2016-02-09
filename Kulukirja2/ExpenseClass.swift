//
//  ExpenseClass.swift
//  Kulukirja2
//
//  Created by Koulutus on 27/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

// ExpenseClass is defined for expense record
// Class implements NSCoding protocol.

class ExpenseClass: NSObject, NSCoding {
    var uniqueKey : String!
    var date : String!
    var expenseValue : Float!
    var expenseType : String!

    
    init (uniqueKey:String, date:String, expenseValue:Float, expenseType:String) {
        self.uniqueKey = uniqueKey
        self.date = date
        self.expenseValue = expenseValue
        self.expenseType = expenseType
    }
    
    override init() {
        super.init()
    }
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.uniqueKey = decoder.decodeObjectForKey("uniqueKey") as! String
        self.date = decoder.decodeObjectForKey("date") as! String
        self.expenseValue = decoder.decodeFloatForKey("expenseValue")
        self.expenseType = decoder.decodeObjectForKey("expenseType") as! String
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.uniqueKey, forKey: "uniqueKey")
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeFloat(self.expenseValue, forKey: "expenseValue")
        coder.encodeObject(self.expenseType, forKey: "expenseType")
    }
}

