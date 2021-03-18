//
//  carritoViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/26/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//
import Kingfisher

import CoreLocation
import UIKit
class carritoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var codigodescuento=""
    
    @IBOutlet weak var btndescuento: UIButton!
    @IBOutlet weak var cont: NSLayoutConstraint!
    var porcentajedescuento = "0"
    var cantidad = 0

    var error  = ""
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var comisiontext: UILabel!
    @IBOutlet weak var pedirbtn: UIButton!
    @IBOutlet weak var btncarrito: UIButton!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    @IBOutlet weak var carritobutton: UIBarButtonItem!
    var pkproductoagregado:[Any] = []
    var cantidadproductoagregado:[Any] = []
    var producto:[Any] = []
    var uno:Bool = false
    var tarjeta:Bool = false
    var cantidadcarrito = 0
    @IBOutlet weak var formadepago: UIButton!
    var misdirecciones:[String] = []
    var mislatitudes:[String] = []
    var mislongitudes:[String] = []
    
    var precio:[Any] = []
    var imgenproducto:[Any] = []
    var tarifa1:[Double] = []
    var ntarifa1:[String] = []
    var pktarifa:[String] = []
    var idt:Int = 0
    var com:Double = 0.0
    var pk_tarifa:String = ""
    
    let defaults = UserDefaults.standard
    var primera:Bool = false
    var locacion:Bool = false
    var elija:Bool = false

    var sub:Double = 0.0
    
    var factor:Double = 0.0
    var comisions:Double = 0.0
    var tot:Double = 0.0
    var sumatoria:Double = 0.0
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tarifatext: UILabel!
    @IBOutlet weak var g: UISegmentedControl!
    var tarifa:Double = 0.0
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
     navigationController?.setNavigationBarHidden(true, animated: false)

            let cantidad = UserDefaults.standard.integer(forKey: "cantidadMisPedidos")
           //if(cantidad == 0){
        let sihay = UserDefaults.standard.string(forKey:  "descuentoseleccionado")!

            if(sihay != ""){
               self.codigodescuento = sihay
                       
                       descuento()
               }
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pedirbtn.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        
        table.delegate = self
        table.dataSource = self
        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
            pkproductoagregado = UserDefaults.standard.array(forKey: "pkproductoagregado")!
            cantidadproductoagregado = UserDefaults.standard.array(forKey: "cantidadproductoagregado")!
            imgenproducto = UserDefaults.standard.array(forKey: "imgenproducto")!
            cantidadcarrito = UserDefaults.standard.integer(forKey: "cantidadcarrito")
            btncarrito.setTitle("\(cantidadcarrito)",for: .normal)
        }
            let datos = UserDefaults.standard.string(forKey: "formadepago")
                  formadepago.setTitle(datos, for: .normal)
       
      
             
                if datos == "Efectivo"{
                    elija=true

                    self.comisiontext.isHidden = true
                    
                }
                if datos == "Terminal"{
                    self.comisiontext.isHidden = true
                    elija=true

                }
                if datos != "Efectivo" &&  datos != "Terminal"{
                    tarjeta = true
                    elija=true

                    self.comisiontext.isHidden = false
                }
            
        
        if datos == ""{
                         self.comisiontext.isHidden = true
                         formadepago.setTitle("Elija un forma de pago", for: .normal)
                         elija=false

                     }
        tarifas()
        latlog()
   
    cantidad = UserDefaults.standard.integer(forKey: "cantidadMisPedidos")
//    if(cantidad == 0){
        if(false){

        self.codigodescuento = "PRIMERO"
                
                descuento()
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ok")
        if self.primera {
            if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
                self.defaults.set(self.precio, forKey: "preciosproductos")
                
                return cantidadproductoagregado.count
            }
            else{
                self.subtotal.text = "Subtotal: $ \(String(format:"%.2f", 0.0))"
                self.tarifatext.text = "Costo de envio: $ \(String(format:"%.2f", 0.0))"
                self.total.text = "Total: $ \(String(format:"%.2f", 0.0))"
                return 0
            }
        }else{
            self.subtotal.text = "Subtotal: $ \(String(format:"%.2f", 0.0))"
            self.tarifatext.text = "Costo de envio: $ \(String(format:"%.2f", 0.0))"
            self.total.text = "Total: $ \(String(format:"%.2f", 0.0))"
            return 0
        }
        
        
    }
    
    @IBAction func gometodo(_ sender: Any) {
        self.defaults.set("false", forKey: "nuevatarjeta")
        self.defaults.set("carrito", forKey: "dondepago")
        performSegue(withIdentifier: "metodo", sender:sender)
        self.defaults.set(codigodescuento, forKey: "descuentoseleccionado")

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
    
    @IBAction func cambiotarifa(_ sender: Any) {
        var suma = 0.0
        let value = self.g.titleForSegment(at: g.selectedSegmentIndex)
        if value == self.ntarifa1[0] {
            self.defaults.set("0", forKey: "tarifaselect")

            tarifa = tarifa1[0]
            self.pk_tarifa = self.pktarifa[0]
            let intt = Double(self.porcentajedescuento)
                       if self.porcentajedescuento != "0"{
                                         self.tarifa = self.tarifa - self.tarifa * Double((intt!/100))
                       }
            if tarjeta == true{
                self.com = ((self.tot + tarifa) * self.factor) + self.comisions
                self.comisiontext.text = "Comsiòn: $\(String(format:"%.2f", com))"
            }
        }
        else {
            self.defaults.set("1", forKey: "tarifaselect")

            self.pk_tarifa = self.pktarifa[1]
            
            tarifa = tarifa1[1]
            let intt = Double(self.porcentajedescuento)
            if self.porcentajedescuento != "0"{
                              self.tarifa = self.tarifa - self.tarifa * Double((intt!/100))
            }
            if tarjeta == true{
                
                self.com = ((self.tot + tarifa) * self.factor) + self.comisions
                self.comisiontext.text = "Comsiòn: $\(String(format:"%.2f", com))"
            }
        }
        if tarjeta == true{
            
            self.comisiontext.text = "Comisiòn: $ \(String(format:"%.2f", com))"
            suma = tarifa + self.tot + self.com
        }
        else{
            
            suma = tarifa + self.tot
            
        }
        self.tarifatext.text = "Tarifa: $ \(String(format:"%.2f", tarifa))"
        
        self.total.text = "Total: $ \(String(format:"%.2f", suma))"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell") as! CarritoCell
        let i = indexPath.item
        var dato:Int = 0
        let preciotemp = precio[indexPath.item] as! String
        let precio1 = Float(preciotemp)!
        let url = URL(string: self.imgenproducto[indexPath.item] as! String)
        cell.imgproducto.kf.setImage(with: url)
        
        // call the subscribeTapped method when tapped
        cell.borrar.tag = indexPath.row
        cell.borrar.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
        cell.desc.text = self.producto[indexPath.item] as? String
        
        dato = (cantidadproductoagregado[i] as? Int)!
        cell.cantidad.text = "\(dato)"
        let result = precio1 * Float(dato)
        sumatoria = sumatoria + Double(result)
        let b2:String = String(format:"%.2f", result)
        cell.suma.text="$ \(b2)"
        
        
        
        
        return cell
    }
    
    @IBAction func accionar(_ sender: Any) {
        alert()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("You selected cell #\(indexPath.item)!")
        
        
        
    }
    
    @objc func subscribeTapped(_ sender: UIButton){
        // use the tag of button as index
        self.idt = sender.tag
        mostrarAlerta2(title: "Quitar este producto de tu carrito", message: "", id: self.idt)
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func mostrarAlerta2(title: String, message: String,id: Int) {
        
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
            self.pkproductoagregado.remove(at: id)
            let cant = self.cantidadproductoagregado[id] as! Int
            self.cantidadproductoagregado.remove(at: id)
            self.producto.remove(at: id)
            self.precio.remove(at: id)
            self.imgenproducto.remove(at: id)
            self.cantidadcarrito = self.cantidadcarrito - (1 * cant)
            self.btncarrito.setTitle("\(self.cantidadcarrito)",for: .normal)
          
            self.defaults.set(self.pkproductoagregado, forKey: "pkproductoagregado")
            self.defaults.set(self.cantidadproductoagregado, forKey: "cantidadproductoagregado")
            self.defaults.set(self.imgenproducto, forKey: "imgenproducto")
            self.defaults.set(self.cantidadcarrito, forKey: "cantidadcarrito")

            
            
            if self.cantidadcarrito == 0{
                self.defaults.removeObject(forKey: "cantidadcarrito")
            }else{
                self.defaults.set(self.cantidadcarrito, forKey: "cantidadcarrito")
            }
            self.tot = 0.0
            self.sumatoria = 0.0
            
            self.info()
            
            
            
            
            
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alertaGuia.addAction(guiaOk)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
        
    }
    func info() {
        var lugares:[Any] = [ ]
        for datos in pkproductoagregado{
            
            
            print(datos)
            
            lugares.append(
                
                [
                    "pk":datos
                ]
            )
        }
        let datos_a_enviar = [
            
            
            "productosList":lugares
            
            
            ] as NSMutableDictionary
        print(lugares)
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass2 = JsonClass2()
        dataJsonUrlClass2.arrayFromJson(url2:"ProductosListDetalle1",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                var subtotal = 0.0
                if let dictionary = datos_recibidos as? [String: Any] {
                    self.total.text = "0"
                    print (dictionary)
                    if let mensaje = dictionary["factor"] {
                        print(mensaje)
                        self.factor = (mensaje) as! Double
                    }
                    if let mensaje2 = dictionary["suma"] {
                        print(mensaje2)
                        self.comisions = (mensaje2) as! Double
                    }
                    if let array = dictionary["productos"] as? NSArray {
                        var i = 0
                        self.sumatoria = 0.0
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                
                                self.producto.append(dict.value(forKey: "producto") as! String)
                                self.precio.append(dict.value(forKey: "precio") as! String)
                                var canti = 0.0
                                let cant =  self.cantidadproductoagregado[i] as! Int
                                canti = Double(cant)
                                var  p = (Double(self.precio[i] as! String))
                                p = p! * Double(canti)
                                subtotal = p! + subtotal
                                
                                i = i + 1
                                
                            }
                            var sumatt = 0.0
                            self.subtotal.text = ("Subtotal: $ \(String(format:"%.2f", subtotal))")
                            self.tot = subtotal
                            self.sub = subtotal
                            self.tarifatext.text = "Tarifa $ \(String(format:"%.2f", self.tarifa))"
                            if self.tarjeta == false{
                                sumatt = (self.sub + self.tarifa)
                                self.cont.constant = -20
                            }else{
                                self.com = ((self.tarifa +  self.tot ) * self.factor )
                                sumatt = ((self.tarifa +  self.tot ) * self.factor ) + (self.sub + self.tarifa)
                                self.uno = true
                                sumatt = sumatt + self.comisions
                                self.com = self.com + self.comisions
                                self.comisiontext.text = "Comision $ \(String(format:"%.2f", self.com))"
                            }
                            
                            self.total.text = "Total $ \(String(format:"%.2f", sumatt))"
                            
                        }
                        print(self.producto)
                        self.primera = true
                        self.cargador.isHidden = true
                        self.table.reloadData()
                        if self.isKeyPresentInUserDefaults(key: "tarifaselect"){
                            let t = self.defaults.string(forKey: "tarifaselect")
                           if ( t == "1") {
                            self.g.selectedSegmentIndex = 1
                            var suma = 0.0
                            let value = self.g.titleForSegment(at: self.g.selectedSegmentIndex)
                                   if value == self.ntarifa1[0] {
                                    self.tarifa = self.tarifa1[0]
                                       self.pk_tarifa = self.pktarifa[0]
                                       let intt = Double(self.porcentajedescuento)
                                                  if self.porcentajedescuento != "0"{
                                                                    self.tarifa =  self.tarifa * Double((intt!/100))
                                                  }
                                    if self.tarjeta == true{
                                        self.com = ((self.tot + self.tarifa) * self.factor) + self.comisions
                                        self.comisiontext.text = "Comsiòn: $\(String(format:"%.2f", self.com))"
                                       }
                                   }
                                   else {
                                       self.pk_tarifa = self.pktarifa[1]
                                       
                                    self.tarifa = self.tarifa1[1]
                                       let intt = Double(self.porcentajedescuento)
                                       if self.porcentajedescuento != "0"{
                                                         self.tarifa =  self.tarifa * Double((intt!/100))
                                       }
                                    if self.tarjeta == true{
                                           
                                        self.com = ((self.tot + self.tarifa) * self.factor) + self.comisions
                                        self.comisiontext.text = "Comsiòn: $\(String(format:"%.2f", self.com))"
                                       }
                                   }
                            if self.tarjeta == true{
                                       
                                self.comisiontext.text = "Comisiòn: $ \(String(format:"%.2f", self.com))"
                                suma = self.tarifa + self.tot + self.com
                                   }
                                   else{
                                       
                                suma = self.tarifa + self.tot
                                       
                                   }
                            self.tarifatext.text = "Tarifa: $ \(String(format:"%.2f", self.tarifa))"
                                   
                                   self.total.text = "Total: $ \(String(format:"%.2f", suma))"
                            
                            
                            }
                        }
                    }
                    
                    
                    
                    
                }
            }
            // if(self.cantidad == 0)
            if(false)
            {
                                self.codigodescuento = "PRIMERO"
                                        
                                self.descuento()
                                }
        }
    }
    func tarifas() {
   
        
        let datos_a_enviar = ["TELEFONO": "" as Any] as NSMutableDictionary
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"CostosEnviosList",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["costos"] as? NSArray {
                        
                        
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                self.tarifa1.append(dict.value(forKey: "costo") as! Double)
                                
                                self.ntarifa1.append(dict.value(forKey: "descripcion") as! String)
                                self.pktarifa.append(dict.value(forKey: "pk") as! String)
                                
                            }
                            
                        }
                        
                        self.tarifa = self.tarifa1[0]
                        self.pk_tarifa = self.pktarifa[0]
                        self.g.setTitle((self.ntarifa1[0] ), forSegmentAt: 0)
                        self.g.setTitle((self.ntarifa1[1] ), forSegmentAt: 1)
                        self.info()
                    }
                }
            }
            
        }
    }
    
    
    func latlog() {
        let pkuser = UserDefaults.standard.string(forKey: "pkuser")
        
        let datos_a_enviar = ["PK_CLIENTE": pkuser as Any] as NSMutableDictionary
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"ObtenerDireccionesByPkCliente",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["direcciones"] as? NSArray {
                        
                        
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                self.misdirecciones.append(dict.value(forKey: "direccion") as! String)
                                self.mislatitudes.append(dict.value(forKey: "latitud") as! String)
                                self.mislongitudes.append(dict.value(forKey: "longitud") as! String)
                                
                            }
                        }
                        self.defaults.set(self.misdirecciones, forKey: "misdirecciones")
                        self.defaults.set(self.mislatitudes, forKey: "mislatitudes")
                        self.defaults.set(self.mislongitudes, forKey: "mislongitudes")
                        
                        
                        
                        
                        
                        
                    }
                   // if(self.cantidad == 0){
                        if(false){

                        
                        self.codigodescuento = "PRIMERO"
                                
                        self.descuento()
                        }
                }
            }
            
        }
    }
    
    
    @IBAction func continuar(_ sender: Any) {
        if elija==true{
        if producto.count > 0 {
            var tt = 0.0
            var co = 0.0
            
            if tarjeta == true {
                tt = self.sub + self.tarifa + self.com
                co = self.com
                
                
            }else{
                tt = self.sub + self.tarifa + self.com
            }
            
            
            print(tt)
            print(co)
            self.defaults.set(self.codigodescuento, forKey: "codigodescuento")
                    self.defaults.set(self.porcentajedescuento, forKey: "porcentajedescuento")
            
            self.defaults.set(self.tarifa, forKey: "tar")
            self.defaults.set(self.tarifa, forKey: "enviot")
            self.defaults.set(self.sub, forKey: "subtotalt")
            self.defaults.set( String(format: "%.2f", co) , forKey: "comisiont")
            self.defaults.set( String(format: "%.2f", tt) , forKey: "totalt")
            self.defaults.set(self.pk_tarifa, forKey: "pk_tarifa")
            
            
            
            checkLocationAuthorization()
            }
        else{
            mostrarAlerta3(title: "Seleccione una forma de pago", message: "")
            }
        }
    }
    func mostrarAlerta2(title: String, message: String) {
        
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
            self.defaults.set("", forKey: "descuentoseleccionado")

            self.performSegue(withIdentifier: "gomap", sender: self)
            

            
        }
        alertaGuia.addAction(guiaOk)
        present(alertaGuia, animated: true, completion: nil)
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            self.defaults.set("", forKey: "descuentoseleccionado")

            self.performSegue(withIdentifier: "gomap", sender: self)
            
        case .denied:
            // Show alert instructing them how to turn on permissions
            mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "Para terminar tu compra entra a configuraciòn/ACMARKET y activa la ubicaciòn")
            
            break
        case .notDetermined:
            mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "")
            
        case .restricted:
            // Show an alert letting them know what's up
            print ("error")
            break
        case .authorizedAlways:
            self.defaults.set("", forKey: "descuentoseleccionado")

            self.performSegue(withIdentifier: "gomap", sender: self)
            break
            
            
        @unknown default:
            print("")
        }
    }
    
    func descuento() {
        let pk =  UserDefaults.standard.string(forKey: "pkuser")!
        
        let datos_a_enviar = ["CODIGO": codigodescuento as Any,"PK_CLIENTE": pk as Any] as NSMutableDictionary
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"BuscarCodigoDescuento",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    if let mensaje = dictionary["resultado"] {
                        print(mensaje)
                        let men = (mensaje) as! Int
                        if men == 0 {
                            self.cargador.isHidden = true
                            self.defaults.set("", forKey: "descuentoseleccionado")

                            if let mensaj = dictionary["mensaje"] {
                                self.mostrarAlerta(title: mensaj as! String, message: "")
                            }

                            return
                        }
                    }
                    
                     if let dictio = dictionary["codigo"] as? [String: Any] {
                       
                
                        self.porcentajedescuento = dictio["pocentajE_DESCUENTO"] as! String
                            
                        self.btndescuento.setTitle(self.codigodescuento+" "+self.porcentajedescuento+"%  DE DESCUENTO EN ENVIO", for: .normal)
                        self.btndescuento.isEnabled = false
                        var sumatt = 0.0
                        print(self.porcentajedescuento)
                        let intt = Double(self.porcentajedescuento)
                        self.tarifa =  self.tarifa - self.tarifa * Double((intt!/100))
                        self.tarifatext.text = "Tarifa $ \(String(format:"%.2f", self.tarifa))"
                        if self.tarjeta == false{
                             sumatt = (self.sub + self.tarifa)
                            self.cont.constant = -20
                        }else{
                            self.com = ((self.tarifa +  self.tot ) * self.factor )
                            sumatt = ((self.tarifa +  self.tot ) * self.factor ) + (self.sub + self.tarifa)
                            self.uno = true
                            sumatt = sumatt + self.comisions
                            self.com = self.com + self.comisions
                            self.comisiontext.text = "Comision $ \(String(format:"%.2f", self.com))"
                        }
                        
                        self.total.text = "Total $ \(String(format:"%.2f", sumatt))"
                        
                        
                        
                        
                        
                    }
                }
           
            }
            
        }
    }
    func mostrarAlerta(title: String, message: String) {
        
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
            
            
            
        }
        alertaGuia.addAction(guiaOk)
        present(alertaGuia, animated: true, completion: nil)
        
        
    }
    func mostrarAlerta3(title: String, message: String) {
          
          let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
              (action) in
             
              
              
              
          }
          alertaGuia.addAction(guiaOk)
          present(alertaGuia, animated: true, completion: nil)
      }
    func alert(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Ingresa tu codigo de descuento", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.keyboardType = .namePhonePad
            
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert?.textFields![0].text!
            print(textField!)
            self.codigodescuento = textField!
            
            self.descuento()

        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}
