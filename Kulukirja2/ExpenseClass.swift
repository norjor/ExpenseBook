//
//  ExpenseClass.swift
//  Kulukirja2
//
//  Created by Koulutus on 27/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

// ExpenseClass is defined for expense record
// Class inherits NSCoding and decoding/coding methods are implemented
// in order to serialize data for file read/write.

class ExpenseClass: NSObject, NSCoding {
    var date : String!
    var expenseValue : Float!
    var expenseType : String!

    
    init (date:String, expenseValue:Float, expenseType:String) {
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
        self.date = decoder.decodeObjectForKey("date") as! String
        self.expenseValue = decoder.decodeFloatForKey("expenseValue")
        self.expenseType = decoder.decodeObjectForKey("expenseType") as! String
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeFloat(self.expenseValue, forKey: "expenseValue")
        coder.encodeObject(self.expenseType, forKey: "expenseType")
    }
}

