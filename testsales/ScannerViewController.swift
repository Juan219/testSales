
import UIKit

protocol ScannerViewControllerDelegate
{
    func didScanProduct(product:PurchasedProduct)
}

class ScannerViewController: UIViewController,RequesterHelperDelegate {
    let requester = RequesterHelper.sharedInstance
    
    @IBOutlet weak var productId: UITextField!
    
    var delegate : ScannerViewControllerDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func scanProduct(sender: AnyObject) {
        requester.delegate = self
        let identifier: Int = Int(self.productId.text!)!
        requester.searchProductById(identifier, andStore: 0)
    }

    func requester(requester: RequesterHelper, didFindProduct product: Product, WithId id: Int) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let scannedProduct :PurchasedProduct = PurchasedProduct.init(qty: 1, tx: 0.0, product: product)
            
            scannedProduct.quantity = 1
            scannedProduct.taxa = 0.0
            self.delegate .didScanProduct(scannedProduct)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
