

import UIKit

class ImagesCVCell: UICollectionViewCell {
    
    let gradient = CAGradientLayer()

    @IBOutlet weak var imgTitleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let cornerRadius: CGFloat = 5.0
        img.layer.cornerRadius = cornerRadius
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        img.layer.masksToBounds = true
        

    }

}

