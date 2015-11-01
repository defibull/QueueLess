//
//  NavViewController.swift
//  userinterface
//
//  Created by Ping Developer on 10/24/15.
//  Copyright © 2015 Shashank Khanna. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if ((self.navigationController?.navigationItem) != nil)
        {
            print("title being set")
            self.navigationController?.navigationItem.title = "Home"
           
        }
        
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
