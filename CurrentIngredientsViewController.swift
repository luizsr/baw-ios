//
//  CurrentStockViewController.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//
import NotificationCenter
import UIKit

class CurrentIngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CheckboxDelegate {
    
    var currentIngredientsArray: NSMutableArray = []
    
    var queryItems: [FoodItem] = []
    
    func loadInitialData() {
        var item1 = FoodItem(name: "eggs")
        self.currentIngredientsArray.addObject(item1)
        
        var item2 = FoodItem(name: "bacon")
        self.currentIngredientsArray.addObject(item2)
        
        var item3 = FoodItem(name: "peanut butter")
        self.currentIngredientsArray.addObject(item3)
        
        var item4 = FoodItem(name: "bread")
        self.currentIngredientsArray.addObject(item4)
        
        var item5 = FoodItem(name: "turkey")
        self.currentIngredientsArray.addObject(item5)
        
        var item6 = FoodItem(name: "mayonnaise")
        self.currentIngredientsArray.addObject(item6)
        
        var item7 = FoodItem(name: "lettuce")
        self.currentIngredientsArray.addObject(item7)
    }
    
    @IBOutlet weak var tblCurrentStockView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCheck()
        loadInitialData()
    }
    
    func loadCheck() {
        let lCheckboxHeight: CGFloat = 62.0;
        var y = CGFloat(16)
        self.createCheckboxes(5, y: y)
        y = CGFloat(y + lCheckboxHeight + 15)
        println(y)
        self.createCheckboxes(2, y: y)
        
        y = CGFloat(y + lCheckboxHeight + 3)
        println(y)
        self.createCheckboxes(0, y: y)
        
        y = CGFloat(y + lCheckboxHeight + 8)
        println(y)
        self.createCheckboxes(1, y: y)
        
        y = CGFloat(y + lCheckboxHeight + 20)
        println(y)
        self.createCheckboxes(1, y: y)
        
        y = CGFloat(y + lCheckboxHeight + 40)
        println(y)
        self.createCheckboxes(1, y: y)
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
    
    
    func createCheckboxes(lNumberOfCheckboxes: Int, y: CGFloat) {
        let lCheckboxHeight: CGFloat = 62.0;
        var lFrame = CGRectMake(22, y, 52, lCheckboxHeight)
        for (var counter = 0; counter < lNumberOfCheckboxes; counter++) {
            // #3
            var lCheckbox = Checkbox(frame: lFrame, selected: false);
            lCheckbox.mDelegate = self;
            lCheckbox.tag = counter;
            
            self.view.addSubview(lCheckbox);
            // #4
            lFrame.origin.x += lFrame.size.width + 5;
        }
    }
    
    func didSelectCheckbox(state: Bool, identifier: Int) {
        println("checkbox has state \(state)");
//        createCheckboxes
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
    
//    func configureListItemCell(itemCell: CheckBoxCell, usingColor color: List.Color, item: ListItem) {
////        itemCell.checkBox.tintColor = color.colorValue
//        itemCell.checkBox.isChecked = item.isComplete
//        itemCell.checkBox.hidden = false
//        
//        itemCell.label.text = item.text
//        itemCell.label.textColor = UIColor.whiteColor()
//        
//        // Configure a completed list item cell.
//        if item.isComplete {
//            itemCell.label.textColor = UIColor.lightGrayColor()
//        }
//    }
    
}

