//
//  PoliticasyavisodeprivacidadViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/14/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class EncuestaViewController: UIViewController , UIWebViewDelegate{

    @IBOutlet weak var WebKit: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
       let datos = UserDefaults.standard.string(forKey: "faltaCalificacion")!
        let pk = UserDefaults.standard.string(forKey: "pkuser")!

        //Crea una constante llamada url que almacena el valor de una URL
        let url = NSURL(string: "https://www.acmarket.com.mx/CUESTIONARIO.php?id_user=" + pk + "&id_pedido=" + datos )
        
        //Crea una variable llamda request que hace una carga de la url contenida en url
        let request = NSURLRequest (url:url! as URL)
        
        //Cargamos la web en nuestro objeto web
        WebKit.loadRequest(request as URLRequest)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)

          
          
      }
    
}
