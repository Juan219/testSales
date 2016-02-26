//
//  CuponViewController.swift
//  testSales
//
//  Created by MCS on 11/16/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class CuponViewController: UITableViewController,RequesterHelperDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var cupons : [Cupon]! = [Cupon]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let requester = RequesterHelper.sharedInstance
        requester.delegate = self
        
        requester.loadCupons()
        
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
    
    // MARK: - Requester delegate Methods
    func requester(requester: RequesterHelper, didFindCupon cupon: Cupon) {
        cupons.append(cupon)
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cupons.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
//        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
//        cell.textLabel?.text = cupons[indexPath.row].name
//        cell.detailTextLabel?.text = "\(cupons[indexPath.row].amount)"
        
        let item : ItemProtocol = self.cupons[indexPath.row] as ItemProtocol
        
        let cell2 = item.cellDrawer().cellForTableview(tableView, at: indexPath)
        
        item.cellDrawer().drawCell(cell2, with: item)
        
        return cell2
        

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
