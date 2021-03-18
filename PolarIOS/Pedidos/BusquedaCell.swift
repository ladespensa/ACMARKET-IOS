import UIKit
class BusquedaCell: UICollectionViewCell {

    @IBOutlet weak var imgbus: UIImageView!
    @IBOutlet weak var descripc: UILabel!
    @IBOutlet weak var precio: UILabel!
    
    @IBOutlet weak var nombretienda: UILabel!
    @IBOutlet weak var titulo: UILabel!
    override func layoutSubviews() {
          self.contentView.layer.shadowRadius = 12

          self.contentView.layer.masksToBounds = true
    // cell rounded section
       self.layer.borderWidth = 5.0
       self.layer.borderColor = UIColor.clear.cgColor
       self.layer.masksToBounds = true
       
       // cell shadow section

       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowRadius = 6.0
       self.layer.shadowOpacity = 0.6
       self.layer.masksToBounds = false
          
      }
}


import Foundation
