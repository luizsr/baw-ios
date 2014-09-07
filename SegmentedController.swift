//
//  SegmentedController.swift
//  Scraps
//
//  Created by Jeffrey Morales on 9/7/14.
//  Copyright (c) 2014 Jeff. All rights reserved.
//

import UIKit

var listCurrentVC: ListCurrentIngredientsVC?
var currentIngredientsViewController: CurrentIngredientsViewController?
var cardViewController: CardViewController?

class SegmentedController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentedControl.selectedSegmentIndex = 0;
        listCurrentVC = self.storyboard.instantiateViewControllerWithIdentifier("ListCurrentIngredientsVC") as? ListCurrentIngredientsVC
        
        currentIngredientsViewController = self.storyboard.instantiateViewControllerWithIdentifier("CurrentIngredientsViewController") as? CurrentIngredientsViewController
        listView()
        
        cardViewController = self.storyboard.instantiateViewControllerWithIdentifier("CardViewController") as? CardViewController
        queryRecipes()
    }
    
    func listView() {
        segmentView.addSubview(listCurrentVC!.view)
    }
    @IBOutlet weak var segmentView: UIView!
    
    func visualView() {
        segmentView.addSubview(currentIngredientsViewController!.view)
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            listView()
        case 1:
            visualView()
        default:
            break
        }
    }

    @IBAction func actionBtn(sender : UIBarButtonItem) {
        var action : UIAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        action.addAction(UIAlertAction(title: "Use Selected Scraps Only", style: UIAlertActionStyle.Default, handler: { alertAction in
            println("Selected only CLICKED")
            self.presentViewController(cardViewController, animated: true, completion: nil)
        }))
        
        action.addAction(UIAlertAction(title: "Use All Scraps", style: UIAlertActionStyle.Default, handler: { alertAction in
            println("All Scraps CLICKED")
            self.presentViewController(cardViewController, animated: true, completion: nil)
        }))
        
        action.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {alertAction in
            println("Cancel CLICKED")
        }))
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    var yummlyAPI = "http://api.yummly.com/v1/api/recipes?_app_id=8d6823cf&_app_key=6e187f794a99e07faa3a8c3e9aa91087"
    
    func queryRecipes() {
        var url : String = yummlyAPI + "&allowedIngredient[]=turkey&allowedIngredient[]=bread"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
            
            if (jsonResult != nil) {
                // process jsonResult
                self.buildUpRecipeObj(jsonResult)
            } else {
                // couldn't load JSON, look at error
                println("else... ;P")
            }
        })
    }
    
    func buildUpRecipeObj(jsonResult: NSDictionary!) {
        var error:NSError? = nil
        if let matches = jsonResult["matches"] as? NSArray {
            for obj:AnyObject in matches {
                let memberDictionary = obj as NSDictionary
                
                var recipeName = memberDictionary["recipeName"] as String
                var ingredients = memberDictionary["ingredients"] as? [String]
                var imageUrl = memberDictionary["smallImageUrls"] as NSArray
                
//                println(matches[0])
//                println(recipeName)
//                println(ingredients!)
                var newUrl = parseSize(imageUrl[0])
//                println(newUrl)
                
                let member = Member(rName: recipeName, rImageName: newUrl, rIngredients: ingredients)
                cardViewController!.members.append(member)
            }
        }
    }
    
    func parseSize(imageUrl: AnyObject) -> String {
        var parsedUrl = imageUrl.componentsSeparatedByString("=")
        var str = parsedUrl[0] as String
        var newUrl = str + "=s320"
        return newUrl
    }
}
