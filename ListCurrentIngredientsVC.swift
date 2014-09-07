//
//  ListCurrentIngredientsVC.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//
import NotificationCenter
import UIKit

class ListCurrentIngredientsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentIngredientsArray: NSMutableArray = []
    
    var queryItems: [FoodItem] = []
    
    func loadInitialData() {
        var item1 = FoodItem(name: "Eggs")
        self.currentIngredientsArray.addObject(item1)
        
        var item2 = FoodItem(name: "Cheese")
        self.currentIngredientsArray.addObject(item2)
        
        var item3 = FoodItem(name: "Bacon")
        self.currentIngredientsArray.addObject(item3)
        
        var item4 = FoodItem(name: "Milk")
        self.currentIngredientsArray.addObject(item4)
        
        var item5 = FoodItem(name: "OJ")
        self.currentIngredientsArray.addObject(item5)
        
        var item6 = FoodItem(name: "Yogurt")
        self.currentIngredientsArray.addObject(item6)
        
        var item7 = FoodItem(name: "Turkey")
        self.currentIngredientsArray.addObject(item7)
        
        var item8 = FoodItem(name: "Ketchup")
        self.currentIngredientsArray.addObject(item8)
        
        var item9 = FoodItem(name: "Apple")
        self.currentIngredientsArray.addObject(item9)
        
        var item10 = FoodItem(name: "Lettuce")
        self.currentIngredientsArray.addObject(item10)
    }
    
    @IBOutlet weak var tblCurrentStockView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("prepareForSegue")
        //        queryRecipes()
    }
    
    func queryRecipes() {
        var url : String = ""
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
            
            if (jsonResult != nil) {
                // process jsonResult
            } else {
                // couldn't load JSON, look at error
            }
            
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return currentIngredientsArray.count
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("cell selected:")
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem:FoodItem = self.currentIngredientsArray.objectAtIndex(indexPath.row) as FoodItem
        tappedItem.completed = !tappedItem.completed
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        var tappedItem:FoodItem = self.currentIngredientsArray.objectAtIndex(indexPath.row) as FoodItem
//        println("rowData \(indexPath.row): \(tappedItem.itemName)");
        
        cell.textLabel.text = tappedItem.itemName
        
        if tappedItem.completed {
            cell.accessoryType = .Checkmark
            FoodStore.sharedInstance.add(tappedItem)
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
}

