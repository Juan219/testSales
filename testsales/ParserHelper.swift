//
//  ParserHelper.swift
//  testSales
//
//  Created by MCS on 11/23/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

protocol ParserHelperDelegate
{
    func parser(parser:ParserHelper, didParseStore   store:Store)
    func parser(parser:ParserHelper, didParseProduct product:Product)
    func parser(parser:ParserHelper, didParseCupon   cupon:Cupon)
    
    //func parser(parser:ParserHelper, didParseSpecificCupon   cupon:Cupon, WithId identifier:Int)
    
}

class ParserHelper: NSObject {
    
    static let sharedInstance = ParserHelper()
    var delegate : ParserHelperDelegate! = nil
    
    func parseArrayToStores(arrayObjects:[NSDictionary]) //-> [Store]
    {
        //var stores:[Store] = [Store]()
        
        for storeDic in arrayObjects
        {
            let store = Store()
            store.identifier = storeDic.valueForKey("identifier") as! Int
            store.name       = storeDic.valueForKey("name") as! String
            store.img        = storeDic.valueForKey("img") as! String
            self.delegate .parser(self, didParseStore: store)
            //stores.append(store)
            
        }
        
        //return stores
    }
    
    func parseArrayToProducts(arrayObjects:[NSDictionary]) //-> [Product]
    {
        //var products = [Product]()
        
        for productDic in arrayObjects
        {
            let product = Product()
            product.identifier = productDic.valueForKey("identifier") as! Int
            product.name       = productDic.valueForKey("name") as! String
            product.storeId    = productDic.valueForKey("storeId") as! Int
            product.price      = productDic.valueForKey("price") as! Double
            self.delegate .parser(self, didParseProduct: product)
            //products.append(product)
            
        }
        
        //return products
    }
    
    func parseArrayToCupons(arrayObjects:[NSDictionary]) //-> [Cupon]
    {
        //var cupons = [Cupon]()
        
        for cuponDic in arrayObjects
        {
            let cupon = Cupon()
            cupon.identifier = cuponDic.valueForKey("identifier") as! Int
            cupon.name       = cuponDic.valueForKey("name") as! String
            cupon.productId    = cuponDic.valueForKey("productId") as! Int
            cupon.amount      = cuponDic.valueForKey("amount") as! Double
            self.delegate.parser(self, didParseCupon: cupon)
            //cupons.append(cupon)
            
        }
        
        //return cupons
    }
    
    func parseSpecificObjectToProduct(productDic:NSDictionary) -> Product
    {
        let product = Product()
        product.identifier = productDic.valueForKey("identifier") as! Int
        product.name       = productDic.valueForKey("name") as! String
        product.storeId    = productDic.valueForKey("storeId") as! Int
        product.price      = productDic.valueForKey("price") as! Double
        product.image      = productDic.valueForKey("img") as! String
        
        return product
    }
    
    func parseSpecificObjectToCupon(cuponDic:NSDictionary) -> Cupon
    {
        let cupon = Cupon()
         cupon.identifier = cuponDic.valueForKey("identifier") as! Int
         cupon.productId  = cuponDic.valueForKey("productId") as! Int
         cupon.amount     = cuponDic.valueForKey("amount") as! Double
         cupon.name       = cuponDic.valueForKey("name") as! String
        
        return cupon
    }
    
}
