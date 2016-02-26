//
//  CuponCell.swift
//  testSales
//
//  Created by MCS on 11/30/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class CuponCell: UITableViewCell {
    
    @IBOutlet weak var labelIdentifier: UILabel!
    @IBOutlet weak var labelCuponName: UILabel!
    @IBOutlet weak var labelCuponAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
