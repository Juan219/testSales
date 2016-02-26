//
//  AccountViewController.swift
//  testSales
//
//  Created by MCS on 11/16/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate,RequesterHelperDelegate {



    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var twitterProfileImg: UIImageView!
    @IBOutlet weak var facebookProfileImg: UIImageView!
    @IBOutlet weak var storesPicker: UIPickerView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let requester = RequesterHelper.sharedInstance
    
    private var stores = [Store]()
    
    
    override func viewWillAppear(animated: Bool) {
        requester.delegate = self
        requester.loadStores()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
        
        self.facebookProfileImg.layer.cornerRadius = self.facebookProfileImg.frame.size.width / 2
        self.facebookProfileImg.clipsToBounds = true
        
        self.twitterProfileImg.layer.cornerRadius = self.twitterProfileImg.frame.size.width / 2
        self.twitterProfileImg.clipsToBounds = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UIPickerViewMethods
     func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
     func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //change the image of the selected store
        self.requester.downloadImage(stores[row].img, withId: "\(stores[row].identifier)")
    }
    
    //MARK: - RequesterMethodsDelegate
    func requester(requester: RequesterHelper, didFindStore store: Store) {
        stores.append(store)
        self.requester.downloadImage(stores[0].img, withId: "\(stores[0].identifier)")
        storesPicker.reloadAllComponents()
    }
    
    func requester(requester: RequesterHelper, didFinishDownloadImage image: UIImage, withId identifier: String) {
        self.storeImage.image = image
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    @IBOutlet weak var lblusrGoogle: UILabel!
    @IBOutlet weak var lblGoogleName: UILabel!
    @IBOutlet weak var pswGoogle: UITextField!
    @IBOutlet weak var usrGoogle: UITextField!
    @IBOutlet weak var googleStackView: UIStackView!
    @IBOutlet weak var googleImage: UIImageView!
    
    
    
    @IBAction func loginGooglePressed(sender: AnyObject) {
        print(sender.superview!!.description)
        print("")
        animateLoginSucessfull((sender.superview as? UIStackView)!)
//        let activity : UIActivityIndicatorView = UIActivityIndicatorView(frame: googleImage.bounds)
//        activity.activityIndicatorViewStyle = .WhiteLarge
//        googleImage.image = nil
//        googleImage.addSubview(activity)
//        
//        activity.color = UIColor.redColor()
//        
//        activity.hidden = false
//        
//        UIView.animateWithDuration(1.5, animations: {
//            self.pswGoogle.frame.size.width = 0
//            self.usrGoogle.frame.size.width = 0
//            activity.startAnimating()
//            
//            },
//            completion: { finished in
//                self.lblusrGoogle.hidden = false
//                self.lblGoogleName.hidden = false
//                self.pswGoogle.hidden = true
//                self.usrGoogle.hidden = true
//                activity.stopAnimating()
//            })
    }
    
    func animateLoginSucessfull(stack : UIStackView)
    {
        let activity : UIActivityIndicatorView = UIActivityIndicatorView(frame: googleImage.bounds)
        activity.activityIndicatorViewStyle = .WhiteLarge
        
        activity.color = UIColor.redColor()
        
        UIView.animateWithDuration(1.0, animations:
            {
                activity.startAnimating()
            for view in stack.subviews as [UIView] {
                
                if let text = view as? UITextField {
                    text.frame.size.width = 0
                }
            }
            
            
            }, completion: { finished in
          
                for view in stack.subviews as [UIView] {
                    if let text = view as? UITextField {
                        text.hidden = true
                    }
                    
                    if let label = view as? UILabel {
                        label.hidden = false
                    }
                }
                activity.stopAnimating()
                
        })
        
    }
}
