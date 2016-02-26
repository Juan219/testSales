//
//  CuponDrawer.swift
//  testSales
//
//  Created by MCS on 11/30/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//



class CuponDrawer: NSObject,ItemDrawerProtocol {
    
    func cellForTableview(tableview: UITableView, at IndexPath: NSIndexPath) -> UITableViewCell {
        
        return tableview.dequeueReusableCellWithIdentifier("cuponCell", forIndexPath:IndexPath )
    }
    
    func drawCell( cell: UITableViewCell, with Item: ItemProtocol?) -> UITableViewCell {
        
        let castedCell : CuponCell = cell as! CuponCell
        let cupon : Cupon = Item as! Cupon
        
        castedCell.labelIdentifier.text = "\(cupon.identifier)"
        castedCell.labelCuponName.text = cupon.name
        castedCell.labelCuponAmount.text = "\(cupon.amount)"
        
        castedCell.heightAnchor.constraintLessThanOrEqualToAnchor(cell.heightAnchor)
        
        return castedCell
    }
}
