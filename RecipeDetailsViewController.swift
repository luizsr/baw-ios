//
//  ViewController.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/6/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ingredientsArray: [String] = [
        "turkey",
        "3/4 cup mayonnaise",
        "bread",
        "lettuce"
    ]
    
    @IBOutlet weak var tblIngredientsView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    //
    //        println("start segue:")
    //
    //        if segue.identifier == "TestPreview" {
    //            let vc = segue.destinationViewController as TestViewController
    //            self.navigationController.pushViewController(vc, animated: true)
    //        }
    //    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("cell selected:")
        //        self.performSegueWithIdentifier("TestPreview", sender: nil)
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        var rowData = self.ingredientsArray[indexPath.row]
        println("rowData \(indexPath.row): \(rowData)");
        
        cell.textLabel.text = rowData
    
        return cell
    }

}

