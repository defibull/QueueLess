//
//  FTTableViewController.swift
//  userinterface
//
//  Created by Ping Developer on 10/24/15.
//  Copyright © 2015 Shashank Khanna. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FTTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var quantity: UITextField!
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var nameOfTheDish = AsianMenuArray[indexPath.row]
//        
//    }
    
    //var menuItems = ["Noodles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queryForAsianMenu()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AsianMenuArray.count
    }
    
    func buttonClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
    }
    
    var finalPaymentAmount = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.menuItemTitle.text = AsianMenuArray[indexPath.row]
        cell.price.text = "$"+String(AsianItemsPrice[indexPath.row])
        cell.orderOutlet.tag = indexPath.row
        cell.orderOutlet.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.tapBlock = {
            print("Button tapped \(self.AsianMenuArray[indexPath.row])")
            var order = PFObject(className:"orders")
            var counter = 0
            var numberQuery = PFQuery(className: "orders")
            order["ItemName"] = self.AsianMenuArray[indexPath.row]
            order["quantity"] = cell.quantity
            order["price"] = self.AsianItemsPrice[indexPath.row]
            self.finalPaymentAmount = Int(self.AsianItemsPrice[indexPath.row] * cell.quantity)
            order["IDNumber"] = 0
            var err: NSErrorPointer = nil
            counter = numberQuery.countObjects(err)
            order["orderNumber"] = counter + 1
            order.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("order save successful")
                    self.performSegueWithIdentifier("toPayment", sender: self)
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                    print("order save NOT successful \(error?.description)")
                }
            }
        }
    
        
  // cell.menuItemTitle!.text = "Hope this works"
        

        // Configure the cell...

        return cell
    }
    
    var AsianMenuObjectCount: Int = 0
    var AsianMenuArray: [String] = []
    var AsianItemsPrice: [Int] = []
    
    func queryForAsianMenu() {
        var query = PFQuery(className: "MenuAsian")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if objects == nil {
                    self.AsianMenuObjectCount = 0
                    self.AsianMenuArray = []
                    self.AsianItemsPrice = []
                }
                else {
                    for eachObject in objects! {
                        self.AsianMenuObjectCount = (objects?.count)!
                        self.AsianMenuArray.append(eachObject["ItemName"] as! String)
                        self.AsianItemsPrice.append(eachObject["Price"] as! Int)
                    }
                    
                }
                self.tableView.reloadData()
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var paymentScene = segue.destinationViewController as! PaymentsViewController
        paymentScene.price = self.finalPaymentAmount
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
