import UIKit

class PedidosCell: UICollectionViewCell {
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var tienda: UILabel!
    @IBOutlet weak var direccionentrega: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var estatus: UILabel!
    
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var horario: UILabel!
    @IBOutlet weak var repartidor: UILabel!
    @IBOutlet weak var imagentienda: UIImageView!
     override func layoutSubviews() {
          self.contentView.layer.cornerRadius = 15.0
          self.contentView.layer.shadowRadius = 12

          self.contentView.layer.masksToBounds = true
    // cell rounded section
       self.layer.cornerRadius = 15.0
       self.layer.borderWidth = 5.0
       self.layer.borderColor = UIColor.clear.cgColor
       self.layer.masksToBounds = true
       
       // cell shadow section
       self.contentView.layer.cornerRadius = 15.0

       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowRadius = 6.0
       self.layer.shadowOpacity = 0.6
       self.layer.cornerRadius = 15.0
       self.layer.masksToBounds = false
          
      }
}
