//
//  CategoriaCell.swift
//  Polar
//
//  Created by Oscar San juan on 3/25/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class MetodosCell: UITableViewCell {
    
    @IBOutlet weak var tarjeta: UILabel!
    
    @IBOutlet weak var imagentarjeta: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
