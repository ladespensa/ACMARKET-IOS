

import UIKit

class CarritoCell: UITableViewCell {
    
    @IBOutlet weak var cantidad: UILabel!
    @IBOutlet weak var suma: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var borrar: UIButton!
    @IBOutlet weak var imgproducto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
