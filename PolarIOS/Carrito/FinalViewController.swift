//
//  FinalViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/2/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var fechaentrega: UILabel!
    @IBOutlet weak var acepbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        acepbtn.layer.cornerRadius = 10
        let d = UserDefaults.standard.string(forKey: "fechafinalentrega")!
        fechaentrega.text =  d
        
        
        
    }
  

}
