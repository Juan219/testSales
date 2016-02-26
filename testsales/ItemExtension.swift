//
//  ProductExtension.swift
//  testSales
//
//  Created by MCS on 11/30/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import Foundation

@objc protocol ItemDrawerProtocol
{
    func cellForTableview(tableview:UITableView, at IndexPath:NSIndexPath) -> UITableViewCell
    func drawCell(cell:UITableViewCell, with Item:ItemProtocol?) -> UITableViewCell
}

@objc protocol ItemProtocol
{
    func cellDrawer() -> ItemDrawerProtocol
}

extension Product : ItemProtocol
{
    func cellDrawer() -> ItemDrawerProtocol
    {
        let drawer = ProductDrawer()
        
        return drawer
    }
}

extension Cupon : ItemProtocol
{
    func cellDrawer() -> ItemDrawerProtocol
    {
        let drawer = CuponDrawer()
        
        return drawer
    }
}