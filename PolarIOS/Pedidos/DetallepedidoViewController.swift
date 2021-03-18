//
//  DetallepedidoViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/27/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class DetallepedidoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tarifa: UILabel!
    let defaults = UserDefaults.standard

    @IBOutlet weak var CONSTRAIN: NSLayoutConstraint!
    @IBOutlet weak var subt: UILabel!
    
    @IBOutlet weak var comi: UILabel!
    
    var cantidadcarrito:String = ""
    var pkproductoagregado:[Any] = []
    var cantidadproductoagregado:[Any] = []
    var comentarioproducto:[Any] = []
    var imgenproducto:[Any] = []
    
    var primera:Bool = false
    var producto:[Any] = []
    @IBOutlet weak var bajo: NSLayoutConstraint!
    var detalles:[Any] = []
    var precio:[Any] = []
    var cantidad:[Any] = []
    var imgpedido:[Any] = []
    
    
    var pktienda:String = ""
    var tienda:String = ""
    var imagentienda:String = ""
    var id:String = ""

    var t:String = ""
  
    var ta:String   = ""
  
    var mp:String = ""
     
     var comt:String   = ""
      
      var subtot:String   = ""
    var pd:Bool = false
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        btn.layer.cornerRadius = 10
        btn.isEnabled = false
      super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        pantalla()
        
        if pd {
              obtenerincidenciaspasadas()
           
          }
          else{
              obtenerincidencias()
          }
        
    }
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)

        
          
          
      }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ok")
        
        
        return producto.count
        
        
        
        
    }
    
    
    @IBAction func carrito(_ sender: Any) {
        self.defaults.set(self.comentarioproducto, forKey: "comentarioproducto")
             self.defaults.set(self.imgenproducto, forKey: "imgenproducto")

             self.defaults.set(self.pkproductoagregado, forKey: "pkproductoagregado")
             self.defaults.set(self.cantidadproductoagregado, forKey: "cantidadproductoagregado")
        
             self.defaults.set(self.cantidadcarrito, forKey: "cantidadcarrito")
        
           self.performSegue(withIdentifier: "carrito", sender: self)

        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallepedidoCell") as! DetallepedidoCell
        
        
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
    
    
    
    func obtenerincidencias() {
           
           
           let pk =  UserDefaults.standard.string(forKey: "pkuser")!
           
           let datos_a_enviar = ["PK_CLIENTE":  pk ] as NSMutableDictionary
           
           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = JsonClass()
           dataJsonUrlClass.arrayFromJson(url2:"obtenerMisPedidos",datos_enviados:datos_a_enviar){ (datos_recibidos) in
      
               DispatchQueue.main.async {//proceso principal
                   if let dictionary = datos_recibidos as? [String: Any] {
                       if let array = dictionary["pedidos"] as? NSArray {
                            
                                                     
                    
                           for obj in array {
                               if let dict = obj as? NSDictionary {
                             let pkr = (dict.value(forKey: "pk") as! String)
                                if( self.id==pkr){
                                
                                   self.pktienda =  (dict.value(forKey: "pK_TIENDA") as! String)
                                  self.tienda = (dict.value(forKey: "tienda") as! String)
                                                             
                                  self.imagentienda = (dict.value(forKey: "imageN_TIENDA") as! String)
                    
                                   let array2 = dict.value(forKey: "lista") as! NSArray
                                var i = 0
                                   for obj2 in array2 {
                                    i = i + 1
                                       if let dict2 = obj2 as? NSDictionary {
                                           self.pkproductoagregado.append(dict2.value(forKey: "pK_PRODUCTO") as! String)
                                           
                                           self.cantidadproductoagregado.append(dict2.value(forKey: "cantidad") as! Int)
                                           
                                           self.comentarioproducto.append(dict2.value(forKey: "detalles") as Any)
                                           self.imgenproducto.append(dict2.value(forKey: "imagen") as Any)
                                           
                    
                                           print ("entro")
                                           print (array2)
                                           
                                       }
                                    
                                   }
                                self.cantidadcarrito = ("\(i)")
                                    self.btn.isEnabled = true

                                   
                                   
                                   
                               }
                               
                            }
                           }

                           
                           
                       }
                       
                       
                       
                   }
               }
               
           }
           
           
       }
    func obtenerincidenciaspasadas() {
         
         
         let pk =  UserDefaults.standard.string(forKey: "pkuser")!
         
         let datos_a_enviar = ["PK_CLIENTE":  pk ] as NSMutableDictionary
         
         //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
         let dataJsonUrlClass = JsonClass()
         dataJsonUrlClass.arrayFromJson(url2:"obtenerMisPedidosPasados",datos_enviados:datos_a_enviar){ (datos_recibidos) in
    
             DispatchQueue.main.async {//proceso principal
                 if let dictionary = datos_recibidos as? [String: Any] {
                     if let array = dictionary["pedidos"] as? NSArray {
                          
                                                   
                  
                         for obj in array {
                             if let dict = obj as? NSDictionary {
                           let pkr = (dict.value(forKey: "pk") as! String)
                              if( self.id==pkr){
                              
                                 self.pktienda =  (dict.value(forKey: "pK_TIENDA") as! String)
                                self.tienda = (dict.value(forKey: "tienda") as! String)
                                                           
                                self.imagentienda = (dict.value(forKey: "imageN_TIENDA") as! String)
                  
                                 let array2 = dict.value(forKey: "lista") as! NSArray
                              var i = 0
                                 for obj2 in array2 {
                                  i = i + 1
                                     if let dict2 = obj2 as? NSDictionary {
                                         self.pkproductoagregado.append(dict2.value(forKey: "pK_PRODUCTO") as! String)
                                         
                                         self.cantidadproductoagregado.append(dict2.value(forKey: "cantidad") as! Int)
                                         
                                         self.comentarioproducto.append(dict2.value(forKey: "detalles") as Any)
                                         self.imgenproducto.append(dict2.value(forKey: "imagen") as Any)
                                         
                  
                                         print ("entro")
                                         print (array2)
                                         
                                     }
                                  
                                 }
                              self.cantidadcarrito = ("\(i)")
                                self.btn.isEnabled = true

                                 
                                 
                                 
                             }
                             
                          }
                         }

                         
                         
                     }
                     
                     
                     
                 }
             }
             
         }
         
         
     }
}

