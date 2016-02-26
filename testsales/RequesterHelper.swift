//
//  RequesterHelper.swift
//  testSales
//
//  Created by MCS on 11/17/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

@objc protocol RequesterHelperDelegate
{
    
   optional func requester(requester:RequesterHelper, didFindStore   store:Store)
   optional func requester(requester:RequesterHelper, didFindProduct product:Product)
   optional func requester(requester:RequesterHelper, didFindCupon   cupon:Cupon)
   optional func requester(requester:RequesterHelper, didFindProduct   product:Product ,WithId id:Int)
    
   optional func requester(requester:RequesterHelper, didFinishDownloadImage image:UIImage , withId identifier:String)
    
}

class RequesterHelper: NSObject,ParserHelperDelegate {
    
    static let sharedInstance = RequesterHelper()
    private let connectedToInternet : Bool! = Bool()
    
    private let parser = ParserHelper()
    var delegate : RequesterHelperDelegate! = nil
    
    func downloadImage(urlString : String, withId identifier:String)
    {
        
        if (hasConnectivity() == true)
        {
        
            if urlString != ""
            {
                let urlImage = NSURL(string: urlString)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                    let imageData : NSData! = NSData(contentsOfURL: urlImage!)
                    dispatch_sync(dispatch_get_main_queue(), {
                        let image = UIImage(data: imageData)
                        self.delegate.requester!(self, didFinishDownloadImage: image!, withId: identifier)
                    })
                    
                })
            }
        }
    }
    
     func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().hashValue
        return networkStatus != 0
    }
    
    func searchProductById(productId:Int, andStore storeId:Int)
    {
        let productsFile : String = "Products"
        parser.delegate = self
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            for product in self.readFile(productsFile) as! [NSDictionary]
            {
                if product.valueForKey("identifier") as! Int == productId
                {
                    let productFinded = self.parser.parseSpecificObjectToProduct(product)
                    self.delegate.requester!(self, didFindProduct:productFinded , WithId: productFinded.identifier)
                }
            }
            
            
        })
        
    }
    
    func searchCuponById(cuponId:Int, andStoreId:Int)
    {
        let cuponsFile : String = "Cupons"
        parser.delegate = self
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            for cupon in self.readFile(cuponsFile) as! [NSDictionary]
            {
                if cupon.valueForKey("identifier") as! Int == cuponId
                {
                    let cuponFinded = self.parser.parseSpecificObjectToCupon(cupon)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate.requester!(self, didFindCupon: cuponFinded)
                    })
                    
                }
            }
            
        })
    }
    
    func loadStores() //-> [Store]
    {
        let storesFile : String = "Stores"
        parser.delegate = self
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            self.parser.parseArrayToStores(self.readFile(storesFile) as! [NSDictionary])
            })
        
    }
    
    func loadCupons() //-> [Cupon]!
    {
        let cuponsFile : String = "Cupons"
        parser.delegate = self
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            self.parser.parseArrayToCupons(self.readFile(cuponsFile) as! [NSDictionary])
        })
        
    }
    
    func loadProducts() //-> [Product]!
    {
        let productsFile : String = "Products"
        parser.delegate = self
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            self.parser.parseArrayToProducts(self.readFile(productsFile) as! [NSDictionary])
        })
        
    }
    
    func readFile(file:String) -> [AnyObject]!
    {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                do{
                    if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    {
                        if let objects : NSArray = jsonResult[file] as? NSArray
                        {
                            return objects as [AnyObject]
                        }
                        
                    }
                }
                catch
                {
                    print("Imposible to read file \(error)")
                }
                
            }
        }
        return nil
    }
    
    func parser(parser: ParserHelper, didParseCupon cupon: Cupon) {
         dispatch_async(dispatch_get_main_queue(), {
        self.delegate.requester!(self, didFindCupon: cupon)
        })
    }
    
    func parser(parser: ParserHelper, didParseProduct product: Product) {
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate.requester!(self, didFindProduct: product)
        })
    }
    
    func parser(parser: ParserHelper, didParseStore store: Store) {
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate.requester!(self, didFindStore: store)
        })
    }
    
    func saveInCache(object:AnyObject,key:String)
    {
        
    }
}
