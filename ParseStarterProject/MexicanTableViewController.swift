import UIKit
import Parse
import Bolts

class MexicanTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var quantity: UITextField!
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        var nameOfTheDish = MexicanMenuArray[indexPath.row]
    //
    //    }
    
    //var menuItems = ["Noodles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queryForMexicanMenu()
        
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
        return MexicanMenuArray.count
    }
    
    func buttonClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MexMenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.menuItemTitle.text = MexicanMenuArray[indexPath.row]
        cell.price.text = "$"+String(MexicanItemsPrice[indexPath.row])
 //       cell.orderOutlet.tag = indexPath.row
  //      cell.orderOutlet.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.tapBlock = {
            print("Button tapped \(self.MexicanMenuArray[indexPath.row])")
            var order = PFObject(className:"orders")
            var counter = 0
            var numberQuery = PFQuery(className: "orders")
            order["ItemName"] = self.MexicanMenuArray[indexPath.row]
            order["quantity"] = cell.quantity
            order["price"] = self.MexicanItemsPrice[indexPath.row]
            order["IDNumber"] = 0
            var err: NSErrorPointer = nil
            counter = numberQuery.countObjects(err)
            order["orderNumber"] = counter + 1
            order.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("order save successful")
                    
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
    
    var MexicanMenuObjectCount: Int = 0
    var MexicanMenuArray: [String] = []
    var MexicanItemsPrice: [Int] = []
    
    func queryForMexicanMenu() {
        var query = PFQuery(className: "MenuMexican")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if objects == nil {
                    self.MexicanMenuObjectCount = 0
                    self.MexicanMenuArray = []
                    self.MexicanItemsPrice = []
                }
                else {
                    for eachObject in objects! {
                        self.MexicanMenuObjectCount = (objects?.count)!
                        self.MexicanMenuArray.append(eachObject["ItemName"] as! String)
                        self.MexicanItemsPrice.append(eachObject["Price"] as! Int)
                    }
                    
                }
                self.tableView.reloadData()
            }
        }
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
