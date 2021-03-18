import UIKit

class PasadosCell: UICollectionViewCell {
    
    
    @IBOutlet weak var tienda: UILabel!

    @IBOutlet weak var backg: UIImageView!
    @IBOutlet weak var TITULO: UILabel!
    @IBOutlet weak var imagentienda: UIImageView!
     override func layoutSubviews() {
          self.contentView.layer.shadowRadius = 12

          self.contentView.layer.masksToBounds = true
    // cell rounded section
       self.layer.borderWidth = 5.0
       self.layer.borderColor = UIColor.clear.cgColor
       self.layer.masksToBounds = true
       
       // cell shadow section
        
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOpacity = 0.6
          
      }
}
