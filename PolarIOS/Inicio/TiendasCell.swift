
import UIKit

class TiendasCell: UICollectionViewCell {
    
    
    @IBOutlet weak var horari: UILabel!
    @IBOutlet weak var nombretienda: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    override func layoutSubviews() {
            self.contentView.layer.cornerRadius = 15.0
            self.contentView.layer.shadowRadius = 12

            self.contentView.layer.masksToBounds = true
      // cell rounded section
         self.layer.cornerRadius = 15.0
         self.layer.borderWidth = 5.0
         self.layer.borderColor = UIColor.clear.cgColor
         self.layer.masksToBounds = true
          _ = UICollectionViewFlowLayout()

         // cell shadow section
         self.contentView.layer.cornerRadius = 15.0

         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowRadius = 6.0
         self.layer.shadowOpacity = 0.6
         self.layer.cornerRadius = 15.0
         self.layer.masksToBounds = false
            
        }

}
