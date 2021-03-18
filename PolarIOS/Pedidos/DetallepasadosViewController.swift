//
//  DetallepasadosViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/13/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class DetallepasadosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tarifa: UILabel!
    
    @IBOutlet weak var CONSTRAIN: NSLayoutConstraint!
    @IBOutlet weak var subt: UILabel!
    
    @IBOutlet weak var comi: UILabel!
    
    var primera:Bool = false
    var producto:[Any] = []
    @IBOutlet weak var bajo: NSLayoutConstraint!
    var detalles:[Any] = []
    var precio:[Any] = []
    var cantidad:[Any] = []
    var imgpedido:[Any] = []

    var t:String = ""
    
    var ta:String   = ""
  
    var mp:String = ""
     
     var comt:String   = ""
      
      var subtot:String   = ""
    var pd:Bool = false

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        pantalla()
        
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ok")
        
        
        return producto.count
        
        
        
        
    }
    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                
                print("IPHONE 5 O SE")
            case 1334:
                print("IPHONE 6 6S 7 8")
            case 1920:
                print("IPHONE PLUS")
            case 2436:
                //   self.img.constant = 200
                print("IPHONE X XS")
            case 1792:
                // self.heigimagen.constant = 220
                print("IPHONE XR")
            case 2688:
                //self.heigimagen.constant = 250
                print("IPHONE XS MAX")
            default:
                print("cualquier otro tamaño")
            }
        }
    }
    
    @IBAction func regreso(_ sender: Any) {
        
           self.tabBarController?.selectedIndex = 1
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("hola")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetallepasadosCell
        
        
        let i = indexPath.item
        print(i)
        var dato:Int = indexPath.item
        cell.titulo.text = self.producto[dato] as? String
        if let url = NSURL(string: self.imgpedido [indexPath.item] as! String){
                        if let data = NSData(contentsOf: url as URL){
                            cell.imgped.image = UIImage(data: data as Data)
                            
                        }}
        let tot = (self.precio  [dato]) as! Double
        
        let b:String = String(format:"%.2f", tot)
        let preciotemp = b
        let precio1 = Float(preciotemp)!
        dato = (cantidad[i] as? Int)!
        cell.cant.text = "\(dato)"
        let result = precio1 * Float(dato)
        let b2:String = String(format:"%.2f", result)
        cell.tot.text="$ \(b2)"
        total.text = t
        tarifa.text = ta
        self.subt.text = subtot
        
        if mp == "T" {
            self.comi.text = comt
        }else{
            self.comi.isHidden = true
            CONSTRAIN.constant = -20

        }
     
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
}

