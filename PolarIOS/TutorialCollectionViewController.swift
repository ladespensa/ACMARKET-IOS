//
//  TutorialCollectionViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 10/06/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TutorialCollectionViewController: UIViewController , UIWebViewDelegate{
    var tuto:Bool = false
    
    @IBOutlet weak var main: UINavigationBar!

    
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)

             
             
         }
   @IBOutlet weak var WebKit: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
         //Crea una constante llamada url que almacena el valor de una URL
            let url = NSURL(string: "https://acmarket.com.mx/tutorial.html")
            
            //Crea una variable llamda request que hace una carga de la url contenida en url
            let request = NSURLRequest (url:url! as URL)
            
            //Cargamos la web en nuestro objeto web
            WebKit.loadRequest(request as URLRequest)
            
        }
        
    @IBAction func close(_ sender: Any) {
        
        if (tuto){
            
        }else{
        self.dismiss(animated: true, completion: nil)
        }
    }
    
}
