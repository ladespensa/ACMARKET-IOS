//
//  PedidosViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/27/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class PedidosViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var traling: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var menuVisible = false
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var id:[Any] = []
    var tienda:[Any] = []
    var direccion:[Any] = []
    var total:[Any] = []
    var pk:[Any] = []
    var estatus:[Any] = []
    var fecha:[String] = []
    var pedidos:Bool = false
    var imgtienda:[Any] = []
    var detallese:[Any] = []
    var horario:[Any] = []
    
    var mp:[Any] = []
    var ct:[Any] = []
    var subtotal:[Any] = []
    
    var ide:String = ""

    var productoe:[Any] = []
    var repartidor:[Any] = []
    var precioe:[Any] = []
    var cantidade:[Any] = []
    var producto:[Any] = []
    var detalles:[Any] = []
    var precio:[Any] = []
    var cantidad:[Any] = []
    var tarifa:[Any] = []
    var img:[Any] = []
    var imge:[Any] = []


    
    var ta:String = ""
    var t:String = ""
    var metp:String = ""
    var comt:String = ""
    var subtot:String = ""
    var tar:String = ""
    
    @IBOutlet weak var imagenusuario: UIImageView!
    @IBOutlet weak var nombreuser: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segment.selectedSegmentIndex = 0
       leading.constant = 0
                  traling.constant = 0
          navigationController?.isToolbarHidden = true
        tabBarController?.hidesBottomBarWhenPushed = false
        cargador.startAnimating()
              let nombr = UserDefaults.standard.string(forKey: "nombre")!
              let apellido = UserDefaults.standard.string(forKey: "apellidos")!
              nombreuser.text = "\(nombr) \(apellido)"
              let fot =  UserDefaults.standard.string(forKey: "foto")!
              if fot.count > 100
              {
                  let dataDecoded : Data = Data(base64Encoded: fot, options: .ignoreUnknownCharacters)!
                  let decodedimage = UIImage(data: dataDecoded)
                  imagenusuario.image = decodedimage
                  imagenusuario.layer.borderWidth = 1
                  imagenusuario.layer.masksToBounds = false
                  imagenusuario.layer.borderColor = UIColor.black.cgColor
                  imagenusuario.layer.cornerRadius = imagenusuario.frame.height/2
                  imagenusuario.clipsToBounds = true
              }
              
              
              obtenerincidencias()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.id.count > 0 {
            
            
            return id.count
            
        }else{
            return 0
            
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
    }
    
    @IBAction func salir(_ sender: Any) {
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        self.performSegue(withIdentifier: "inicio", sender: self)
    }
    
    @IBAction func estatus(_ sender: Any) {
        cargador.isHidden = false
        
        if segment.selectedSegmentIndex == 1 {
            obtenerincidenciaspasadas()
            pedidos = true
        }
        else{
            obtenerincidencias()
            pedidos = false
        }
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PedidosCell
        
        cell.id.text = "No. Pedido: \((self.id  [indexPath.item] as! String))"
        cell.estatus.text = "Pedido: \((self.estatus  [indexPath.item] as! String))"
        cell.repartidor.text = "Entregado por: \((self.repartidor  [indexPath.item] as! String))"
        cell.tienda.text = "\((self.tienda  [indexPath.item] as! String))"
        cell.horario.text = "\((self.horario  [indexPath.item] as! String))"
        cell.fecha.text = (self.fecha  [indexPath.item] )
        
           let url = URL(string: self.imgtienda[indexPath.item] as! String)
             cell.imagentienda.kf.setImage(with: url)
             
                
            
        //cell.tienda.text = "\((self.tienda  [indexPath.item] as! String))"
        cell.direccionentrega.text = " \((self.direccion  [indexPath.item] as! String))"
        let tot = (self.total  [indexPath.item]) as! Double
        let b:String = String(format:"%.2f", tot)
        cell.total.text =  "Total: $ \(b)"
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productoe.removeAll()
        self.precioe.removeAll()
        self.imge.removeAll()
        self.cantidade.removeAll()
        self.ide.removeAll()


        
        let idt = self.id[indexPath.item] as! String
        
        var i = 0
        for obtener in self.pk{
            
            let pk = self.pk[i] as! String
            if idt == pk
            {
                print (obtener)
                self.productoe.append(producto[i])
                //self.detallese.append(detalles[i])
                self.precioe.append(precio[i])
                self.cantidade.append(cantidad[i])
                self.imge.append(img[i])
                self.ide = idt

            }
            i = i + 1
        }
        
        let dato: Int = indexPath.item
        let m:String = mp[dato] as! String
        let c:String = String(format:"%.2f", ct[dato] as! Double)
        let s:String = String(format:"%.2f", subtotal[dato] as! Double)
        let t:String = String(format:"%.2f", tarifa[dato] as! Double)
        
        self.metp = m
        self.comt = "Comisiòn: \(c)"
        self.subtot = "Subtotal: \(s)"
        self.tar = "Tarifa: \(t)"
        
        let b:String = String(format:"%.2f", total[dato] as! Double)
        self.t =  " Total: $ \(b)"
        let d:String = String(format:"%.2f", tarifa[dato] as! Double)
        self.ta =  "Tarifa: $ \(d)"
        self.performSegue(withIdentifier: "godetallepedido", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "godetallepedido" {
            let detalle = segue.destination as! DetallepedidoViewController
            
            
            detalle.imgpedido = self.imge
            detalle.producto = self.productoe
            detalle.detalles = self.detalles
            detalle.precio = self.precioe
            detalle.cantidad = self.cantidade
            detalle.t = self.t
            detalle.ta = self.ta
            detalle.id = self.ide
            detalle.pd = self.pedidos

            detalle.mp = self.metp
            detalle.comt = self.comt
            detalle.subtot = self.subtot
            
            
            
        }
    }
    func obtenerincidencias() {
        
        
        let pk =  UserDefaults.standard.string(forKey: "pkuser")!
        
        let datos_a_enviar = ["PK_CLIENTE":  pk ] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"obtenerMisPedidos",datos_enviados:datos_a_enviar){ (datos_recibidos) in
   
            DispatchQueue.main.async {//proceso principal
                self.cargador.isHidden = true
                if let dictionary = datos_recibidos as? [String: Any] {
                    if let array = dictionary["pedidos"] as? NSArray {
                        self.tienda.removeAll()
                        self.id.removeAll()
                           self.tarifa.removeAll()
                           self.estatus.removeAll()
                           self.direccion.removeAll()
                           self.total.removeAll()
                           self.horario.removeAll()
                           self.mp.removeAll()
                           self.subtot.removeAll()
                           self.ct.removeAll()
                           self.fecha.removeAll()
                           self.repartidor.removeAll()
                           self.imgtienda.removeAll()
                           self.pk.removeAll()
                           self.producto.removeAll()
                           self.precio.removeAll()
                           self.img.removeAll()
                           self.cantidad.removeAll()
                        self.subtotal.removeAll()

                                                  
                                                  
                                                  
                        self.defaults.removeObject(forKey: "producto")
                        self.defaults.removeObject( forKey: "precio")
                        self.defaults.removeObject(forKey: "cantidad")
                        var a = 0
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                
                                self.tienda.append(dict.value(forKey: "tienda") as! String)
                                self.id.append(dict.value(forKey: "pk") as! String)
                                self.tarifa.append(dict.value(forKey: "envio") as Any)
                                self.estatus.append(dict.value(forKey: "estatus") as Any)
                                let temporal = dict.value(forKey: "estatus") as! String
                                if temporal == "Nuevo" {
                                    a = a + 1
                                }
                                self.direccion.append(dict.value(forKey: "direccion") as! String)
                                self.total.append(dict.value(forKey: "total") as Any)
                            self.horario.append(dict.value(forKey: "fechA_ENTREGA") as! String)
                                
                                self.mp.append(dict.value(forKey: "metodO_PAGO") as! String)
                                self.subtotal.append(dict.value(forKey: "subtotal") as Any)
                                self.ct.append(dict.value(forKey: "comisioN_TARJETA") as Any)
                                self.fecha.append(dict.value(forKey: "fechA_C") as! String)
                                
                                
                                self.repartidor.append(dict.value(forKey: "repartidor") as! String)
                                self.imgtienda.append(dict.value(forKey: "imageN_TIENDA") as! String)

                          
                                let array2 = dict.value(forKey: "lista") as! NSArray
                                for obj2 in array2 {
                                    if let dict2 = obj2 as? NSDictionary {
                                        self.pk.append(dict2.value(forKey: "pK_PEDIDO") as! String)
                                        
                                        self.producto.append(dict2.value(forKey: "producto") as! String)
                                        
                                        self.precio.append(dict2.value(forKey: "precio") as Any)
                                        self.img.append(dict2.value(forKey: "imagen") as Any)
                                        
                                        self.cantidad.append(dict2.value(forKey: "cantidad") as Any)
                                        print ("entro")
                                        print (array2)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        self.collection.reloadData()
                        UIApplication.shared.applicationIconBadgeNumber = a
                        
                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        
    }
    
    @IBAction func go(_ sender: Any) {
        if !menuVisible {
            leading.constant = 250
            menuVisible = true
        } else {
            leading.constant = 0
            traling.constant = 0
            menuVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
        
    }
    @IBAction func perfil(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 4
        
    }
    
    @IBAction func pedidos(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 1
        
        
    }
    
    @IBAction func histp(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func notificaciones(_ sender: Any) {
    }
    @IBAction func invitar(_ sender: Any) {
        if UIDevice().userInterfaceIdiom == .phone {
            //  Converted to Swift 5.2 by Swiftify v5.2.18840 - https://objectivec2swift.com/
            let textToShare = UserDefaults.standard.string(forKey: "link")!
            
            let objectsToShare = [textToShare]
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            
            present(activityVC, animated: true)
            
        }else{
            
            
            
        }
        
    }
    
    @IBAction func ayuda(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 3
        
    }

    @IBAction func cerrar(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        self.performSegue(withIdentifier: "inicio", sender: self)
    }
    
    func obtenerincidenciaspasadas() {
        
        
        let pk =  UserDefaults.standard.string(forKey: "pkuser")!
        
        let datos_a_enviar = ["PK_CLIENTE":  pk ] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"obtenerMisPedidosPasados",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                self.cargador.isHidden = true
                if let dictionary = datos_recibidos as? [String: Any] {
                    self.tienda.removeAll()
                    self.tarifa.removeAll()
                    self.estatus.removeAll()
                    self.id.removeAll()

                    self.direccion.removeAll()
                    self.total.removeAll()
                    self.horario.removeAll()
                    self.mp.removeAll()
                    self.subtot.removeAll()
                    self.ct.removeAll()
                    self.fecha.removeAll()
                    self.repartidor.removeAll()
                    self.imgtienda.removeAll()
                    self.pk.removeAll()
                    self.producto.removeAll()
                    self.precio.removeAll()
                    self.img.removeAll()
                    self.cantidad.removeAll()
                    self.subtotal.removeAll()

                    if let array = dictionary["pedidos"] as? NSArray {
                        self.defaults.removeObject(forKey: "producto")
                        self.defaults.removeObject( forKey: "precio")
                        self.defaults.removeObject(forKey: "cantidad")
                        var a = 0
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                
                                self.tienda.append(dict.value(forKey: "tienda") as! String)
                                self.id.append(dict.value(forKey: "pk") as! String)
                                self.tarifa.append(dict.value(forKey: "envio") as Any)
                                self.estatus.append(dict.value(forKey: "estatus") as Any)
                                let temporal = dict.value(forKey: "estatus") as! String
                                if temporal == "Nuevo" {
                                    a = a + 1
                                }
                                self.direccion.append(dict.value(forKey: "direccion") as! String)
                                self.total.append(dict.value(forKey: "total") as Any)
                                self.horario.append(dict.value(forKey: "fechA_C") as! String)
                                
                                self.mp.append(dict.value(forKey: "metodO_PAGO") as! String)
                                self.subtotal.append(dict.value(forKey: "subtotal") as Any)
                                self.ct.append(dict.value(forKey: "comisioN_TARJETA") as Any)
                                self.fecha.append(dict.value(forKey: "fechA_C") as! String)
                                
                                self.repartidor.append(dict.value(forKey: "repartidor") as! String)
                                                         self.imgtienda.append(dict.value(forKey: "imageN_TIENDA") as! String)

                                let array2 = dict.value(forKey: "lista") as! NSArray
                                for obj2 in array2 {
                                    if let dict2 = obj2 as? NSDictionary {
                                        self.pk.append(dict2.value(forKey: "pK_PEDIDO") as! String)
                                        
                                        self.producto.append(dict2.value(forKey: "producto") as! String)
                                        
                                        self.precio.append(dict2.value(forKey: "precio") as Any)
                                        self.img.append(dict2.value(forKey: "imagen") as Any)
                                        
                                        self.cantidad.append(dict2.value(forKey: "cantidad") as Any)
                                        print ("entro")
                                        print (array2)
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        self.collection.reloadData()
                        
                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        
    }
    
}

