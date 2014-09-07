//
//  FoodItem.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//

import UIKit

class FoodItem: NSObject {
    var itemName: NSString = ""
    var completed: Bool = false
    var creationDate: NSDate = NSDate()
    
    init(name:String)  {
        self.itemName = name
    }
}
