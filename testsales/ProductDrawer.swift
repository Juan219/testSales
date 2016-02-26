//
//  ProductDrawer.swift
//  testSales
//
//  Created by MCS on 11/30/15.
//  Copyright © 2015 balderas.juan. All rights reserved.



class ProductDrawer: NSObject , ItemDrawerProtocol,RequesterHelperDelegate {
    
    let requester : RequesterHelper = RequesterHelper()
    var table : UITableView = UITableView()
    var castedCell : ProductCell!
    var activity : UIActivityIndicatorView!
    
    func cellForTableview(tableview: UITableView, at IndexPath: NSIndexPath) -> UITableViewCell {
        table = tableview
        return tableview.dequeueReusableCellWithIdentifier("productCell", forIndexPath:IndexPath )
        
    }
    
    func drawCell(cell: UITableViewCell, with Item:ItemProtocol?) -> UITableViewCell {
        
        castedCell = cell as! ProductCell
        let product : PurchasedProduct = Item as! PurchasedProduct
        
        requester.delegate = self
        requester.downloadImage(product.image, withId: "\(product.identifier)")
        
        castedCell.labelProductName.text        =  product.name
        castedCell.labelProductPrice.text       =  "\(product.price)"
        castedCell.labelProductQuantity.text    =  "\(product.quantity)"
        castedCell.labelProductSubtotal.text    =  "\(Double(product.quantity) * product.price)"
        //castedCell.cellIndexPath = table.indexPathForCell(cell)!

        castedCell.imageProduct.image = UIImage(named: "blank")
        
        activity = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activity.center = castedCell.imageProduct.center
        activity.startAnimating()
        activity.activityIndicatorViewStyle = .WhiteLarge
        castedCell.addSubview(activity)
        
        return castedCell
    }
    
    func requester(requester: RequesterHelper, didFinishDownloadImage image: UIImage, withId identifier: String) {
        castedCell.imageProduct.image = image
        activity.stopAnimating()
    }
    
}
