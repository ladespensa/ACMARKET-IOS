//
//  PoliticasyavisodeprivacidadViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/14/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class PoliticasyavisodeprivacidadViewController: UIViewController , UIWebViewDelegate{

    @IBOutlet weak var WebKit: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Crea una constante llamada url que almacena el valor de una URL
        let url = NSURL(string: "https://acmarket.com.mx")
        
        //Crea una variable llamda request que hace una carga de la url contenida en url
        let request = NSURLRequest (url:url! as URL)
        
        //Cargamos la web en nuestro objeto web
        WebKit.loadRequest(request as URLRequest)
        
    }
    
    @IBAction func closepol(_ sender: Any) {
self.dismiss(animated: true, completion: nil)
    }
    

    
}
