//
//  Item.swift
//  testSales
//
//  Created by MCS on 11/29/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class Item: NSObject {
    var identifier = Int()
    var name       = String()
    
    override init() {
        
    }
    
    init(idtf:Int,nm:String) {
        self.identifier = idtf
        self.name = nm
    }
}
