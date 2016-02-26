//
//  PurchasedProduct.swift
//  testSales
//
//  Created by MCS on 11/24/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class PurchasedProduct: Product {
    var quantity : Int!
    var taxa : Float!
    
    
    init(qty:Int!,tx:Float!,product:Product)
    {
        self.quantity = qty
        self.taxa = tx
        
        super.init(product: product)
        
    }
    
//    func purchaseProductWithProduct(product:Product) -> PurchasedProduct
//    {
//        let pp : PurchasedProduct = PurchasedProduct()
//        
//        pp.name = product.name
//        
//        return pp
//        
//    }
}
