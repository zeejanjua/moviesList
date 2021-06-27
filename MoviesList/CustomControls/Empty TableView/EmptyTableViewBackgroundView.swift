

import UIKit

class EmptyTableViewBackgroundView: UIView {

    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var noResultLabel: UILabel!
    
    
    class func instanceFromNib() -> EmptyTableViewBackgroundView {
        return UINib(nibName: "EmptyTableViewBackgroundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyTableViewBackgroundView
    }

}
