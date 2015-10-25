//
//  MenuTableViewCell.swift
//  userinterface
//
//  Created by Ping Developer on 10/24/15.
//  Copyright © 2015 Shashank Khanna. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var price: UILabel!
    @IBAction func orderButtonPressed(sender: AnyObject) {
        
        if let tapBlock = self.tapBlock {
            self.setQuantity()
            tapBlock()
            
        }
    }
    @IBOutlet weak var menuItemTitle: UILabel!
    
    @IBOutlet weak var itemQuantity: UITextField!
    
    @IBOutlet weak var orderOutlet: UIButton!
    
    var quantity: Int = 0
    
    var tapBlock: dispatch_block_t?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setQuantity() {
        print("first quantity: \(self.itemQuantity.text)")
        print(Int(self.itemQuantity.text!))
        
            
        self.quantity = Int(self.itemQuantity.text!)!
        print("third quantity: \(self.quantity)")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
