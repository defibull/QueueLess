//
//  PaymentsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ping Developer on 10/25/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    var price: Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://tonite.co/payment.php?price="+String(price))
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
