//
//  Product.swift
//  testSales
//
//  Created by MCS on 11/23/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class Product: Item {

    var image      = String()
    var storeId    = Int()
    var price      = Double()
    
    override init() {
        super.init()
    }
    
    init(product:Product)
    {
        self.image = product.image
        self.storeId = product.storeId
        self.price = product.price
        
        super.init(idtf: product.identifier, nm: product.name)
    }

}
