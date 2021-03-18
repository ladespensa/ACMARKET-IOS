

import UIKit

class DetallepasadosCell: UITableViewCell {
    
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var cant: UILabel!
    @IBOutlet weak var tot: UILabel!
    @IBOutlet weak var imgped: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
