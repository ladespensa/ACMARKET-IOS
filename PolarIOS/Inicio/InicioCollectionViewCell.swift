//
//  InicioCollectionViewCell.swift
//  Polar
//
//  Created by Oscar San juan on 3/25/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class InicioCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imagenpromo: UIImageView!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var producto: UILabel!
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

