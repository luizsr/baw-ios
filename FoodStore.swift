//
//  FoodStore.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//

class FoodStore {
    class var sharedInstance: FoodStore {
    struct Static {
        static let instance = FoodStore()
        }
        return Static.instance
    }
    
    var foodItems: [FoodItem] = []
    
    func add(task: FoodItem) {
        foodItems.append(task)
    }
    
    func replace(task: FoodItem, atIndex index: Int) {
        foodItems[index] = task
    }
    
    func get(index: Int) -> FoodItem {
        return foodItems[index]
    }
    
    func getAll() -> [FoodItem] {
        return foodItems
    }
}
