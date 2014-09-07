//
//  RecipeItem.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//

import UIKit

class RecipeItem: NSObject {
    var recipeName: NSString = ""
    var recipeDirection: [String] = []
//    var imageView: UIImage
    
    
    init(name:String, directions:[String])  {
        self.recipeName = name
//        self.imageView = image
        self.recipeDirection = directions
    }
}
