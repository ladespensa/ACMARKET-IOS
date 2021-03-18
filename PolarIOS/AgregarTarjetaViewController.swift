//
//  AgregarTarjetaViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/1/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit
import Openpay

class AgregarTarjetaViewController: UIViewController{
    
    @IBOutlet weak var tfTitular: UITextField!
    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfExpireDate: UITextField!
    @IBOutlet weak var tfCVV: UITextField!
    
    @IBOutlet weak var tfCountry: UITextField!
    static let MERCHANT_ID = "m4tzxvoqsrbwdwueceeq"             // Generated in Openpay account registration
    static let API_KEY = "pk_c4959aea8ebb4d4f94d9255a46c0eca1"  // Generated in Openpay account registration
    var openpay: Openpay!
    var sessionID: String!
    var tokenID: String!
    override func viewDidLoad() {
        super.viewDidLoad()
    openpay = Openpay(withMerchantId: TarjetapagoViewController.MERCHANT_ID, andApiKey: TarjetapagoViewController.API_KEY, isProductionMode: false, isDebug: true)
    
    }
    
    
    
    
}
