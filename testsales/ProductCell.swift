
import UIKit

@objc protocol ProductCellDelegate
{
    func didChangeQuantity()
}

class ProductCell: UITableViewCell {

    
    var delegate : ProductCellDelegate!
    
    var cellIndexPath : NSIndexPath = NSIndexPath()
    
    @IBOutlet weak var labelProductSubtotal: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet var labelProductName: UILabel! = UILabel()
    @IBOutlet weak var labelProductQuantity: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var stepperQuantity: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeQuantity(sender: UIStepper) {
        
    }

}
