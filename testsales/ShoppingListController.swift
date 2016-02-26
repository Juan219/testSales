//
//  ShoppingListController.swift
//  testSales
//
//  Created by MCS on 11/23/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class ShoppingListController: UITableViewController,ScannerViewControllerDelegate,RequesterHelperDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var alertController : UIAlertController! = UIAlertController()
    
    //var products = [PurchasedProduct]()
    var products = [Item]()
    var alreadyPresented = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cuponCellNIB = UINib(nibName: "CuponCell", bundle:nil)
        tableView.registerNib(cuponCellNIB, forCellReuseIdentifier: "cuponCell")
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Product Methods
    @IBAction func addProduct(sender: AnyObject) {
        let Scanner = self.storyboard?.instantiateViewControllerWithIdentifier("ScannerVC") as! ScannerViewController
        Scanner.delegate = self
        self.presentViewController(Scanner, animated: true, completion: nil)
    }
    
    func didScanProduct(product:PurchasedProduct)
    {
        self.products.append(product)
        self.alreadyPresented = [Bool](count: self.products.count, repeatedValue: false)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.products.count - 1, inSection: 0)], withRowAnimation: .Fade)
    }
    
    func requester(requester: RequesterHelper, didFindCupon cupon: Cupon) {
        self.products.append(cupon)
        self.alreadyPresented = [Bool](count: self.products.count, repeatedValue: false)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.products.count - 1, inSection: 0)], withRowAnimation: .Fade)
        showWarning("shopping list", text: "cupon added")
    }
    
    

    // MARK: - Table view Animation
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if alreadyPresented[indexPath.row] == false
        {
            cell.alpha = 0
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            })
            alreadyPresented[indexPath.row] = true
        }

    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item : ItemProtocol = self.products[indexPath.row] as! ItemProtocol
        
        let cell2 = item.cellDrawer().cellForTableview(tableView, at: indexPath)
        
        item.cellDrawer().drawCell(cell2, with: item)
        
        return cell2

    }
    
    @IBAction func addCupon(sender: AnyObject) {
        print("Addcupon")
        
        alertController = UIAlertController(title: "Cupon", message: "Write the number of your cupon", preferredStyle: .Alert)
        
        let addCuponAction : UIAlertAction = UIAlertAction(title: "Submit", style: .Default, handler: { (UIAlertAction) in
            print("Submit cupon")
            self.searchForCupon(self.alertController.textFields![0].text!)
        })
        let cancelCuponAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: { (UIAlertAction) in
            print("Cancel cupon")
        })
        alertController.addTextFieldWithConfigurationHandler(nil)
        alertController.addAction(addCuponAction)
        alertController.addAction(cancelCuponAction)
        
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showWarning(title:String,text:String)
    {
        let warningController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        
        let cancelCuponAction : UIAlertAction = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) in
            
        })
        
         warningController.addAction(cancelCuponAction)
        
        presentViewController(warningController, animated: true, completion: nil)
    }
    
    func searchForCupon(cuponId:String)
    {
        if cuponId != ""
        {
            alertController.removeFromParentViewController()
            alertController.dismissViewControllerAnimated(true, completion: nil)
            let requester : RequesterHelper = RequesterHelper.sharedInstance
            requester.delegate = self
            requester.searchCuponById(Int(cuponId)!, andStoreId: 0)
            
        }
    }

}
