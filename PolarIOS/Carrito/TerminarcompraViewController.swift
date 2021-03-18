//
//  TerminarcompraViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/27/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit
//import  Openpay
class TerminarcompraViewController: UIViewController {
    
    @IBOutlet weak var tarjetabtn: UIButton!
    let defaults = UserDefaults.standard
    var entregaproducto: String!

    @IBOutlet weak var efebtn: UIButton!
    @IBOutlet weak var cargador: UIProgressView!
    //var openpay: Openpay!
    var sessionID: String!
    var tokenID: String!
    var cvv: String!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var pagar: UIButton!
    
    @IBOutlet weak var direc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      cargador.transform = cargador.transform.scaledBy(x: 1, y: 10)

        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        let datos = UserDefaults.standard.string(forKey: "formadepago")!
    
        if datos == "Efectivo"  ||  datos == "Terminal"{
            pagar.isHidden = true
            var randomNumber = 0.0

         Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            randomNumber = randomNumber + 1
                print("Number: \(randomNumber)")
            let temp = randomNumber / 5
            self.cargador.progress = Float(temp)
                if randomNumber == 5 {
                    timer.invalidate()

                    self.realizarpedidoefectivo()

            }
            }
           
        }
        if datos != "Efectivo" || datos != "Terminal"{
            self.cargador.progress =    1.0

        }
        
    }
    
    func alert(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Ingresa tu CVV", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.keyboardType = .numberPad
            
            
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert?.textFields![0].text!
            print(textField!)
            self.cvv = textField!
            self.realizarpedido()
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
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
                print("IPHONE X XS")
            case 1792:
                print("IPHONE XR")
            case 2688:
                print("IPHONE XS MAX")
            default:
                print("cualquier otro tamaño")
            }
        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height > 1900 {
                self.view.frame.origin.y = -tecladoUp.height
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func termianr(_ sender: Any) {
        //openpay.createDeviceSessionId(successFunction: successSessionID, failureFunction: failSessionID)
        
    }
    func realizarpedido() {
        let fechaentrega = UserDefaults.standard.string(forKey: "fechafinalentrega")!
  
        let codigodescuento = UserDefaults.standard.string(forKey: "codigodescuento")!
             let descuentocodigo = UserDefaults.standard.string(forKey: "porcentajedescuento")!
        let direccomp = UserDefaults.standard.string(forKey: "direccion")!
        let idtar = UserDefaults.standard.string(forKey: "idtar")!
        let lugardeentrega = UserDefaults.standard.string(forKey: "lugardeentrega")!

        let openid = UserDefaults.standard.string(forKey: "openid")!
        
        let deviceseisionid = UserDefaults.standard.string(forKey: "deviceseisionid")!
        
        let replaced = deviceseisionid.replacingOccurrences(of: "ios-", with: "")
        
        var lugares:[Any] = [ ]
        let pkuser = UserDefaults.standard.string(forKey: "pkuser")!
        let latitud = UserDefaults.standard.double(forKey: "latitud")
        let tar = UserDefaults.standard.double(forKey: "tar")
        let descc = Double(descuentocodigo)!

        let envio = UserDefaults.standard.double(forKey: "enviot")
        let subtotal = UserDefaults.standard.double(forKey: "subtotalt")
        let comision = UserDefaults.standard.double(forKey: "comisiont")
        let total = UserDefaults.standard.double(forKey: "totalt")
        
        let la:String = "\(latitud)"

        let longitud = UserDefaults.standard.double(forKey: "longitud")
        let lo:String = "\(longitud)"

        let  pkproductoagregado = UserDefaults.standard.array(forKey: "pkproductoagregado")! as! [String]
        let  cantidadproductoagregado = UserDefaults.standard.array(forKey: "cantidadproductoagregado")!
            let TIENDAPK = UserDefaults.standard.string(forKey: "tpktienda")!
        let  productocomentario = UserDefaults.standard.array(forKey: "comentarioproducto")! as! [String]
        let  preciop = UserDefaults.standard.array(forKey: "preciosproductos")! as! [String]
        var i = 0
        let pk_tarifa = UserDefaults.standard.integer(forKey: "pk_tarifa")
           let pktarifa = "\(pk_tarifa)"
        for datos in pkproductoagregado{
            var det = ""
            var cant = 0.0
            var pkprod = ""
            var prec = 0.0
            det = productocomentario[i]
            cant =  cantidadproductoagregado[i] as! Double
            pkprod = pkproductoagregado[i]
            prec = Double(preciop[i])!
            
            i = i + 1
            lugares.append(
                
                [
                    "PK_PRODUCTO":pkprod,
                    "PRECIO":prec,
                    "CANTIDAD":cant,
                    "DETALLES":det                         ]
            )
            print(datos)
            
        }
        
        
        
        
        let datos_a_enviar = [
            "CODIGO_DESCUENTO":codigodescuento,
             "DESCUENTO":descc,
             "FECHA_ENTREGA":fechaentrega,
            "PK_POLIGONO":lugardeentrega,
            "PK_CLIENTE":pkuser,
            "DIRECCION":direccomp,
            "LATITUD":la,
            "ENVIO":envio,
            "SUBTOTAL":subtotal,
            "LONGITUD":lo,
            "COMISION_TARJETA":comision,
            "TOTAL":total,
            "PK_COSTO_ENVIO":pktarifa,
            "METODO_PAGO":"T",
            "PK_TIENDA":TIENDAPK,
            "SOURCE_ID":idtar,
            "DEVICE_SESSION_ID":replaced,
            "COSTUMER_ID":openid,
            "PRECIO_ENTREGA":tar,
            "LISTA":lugares
            
            
            ] as NSMutableDictionary
        
        print(datos_a_enviar)
        let dataJsonUrlClass2 = JsonClass2()
        dataJsonUrlClass2.arrayFromJson(url2:"AgregarPedido",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    print (dictionary)
                    if let mensaje = dictionary["resultado"] {
                        print(mensaje)
                        let men = (mensaje) as! Int
                        if men == 0 {
                            self.cargador.isHidden = true
                            self.pagar.isEnabled = true
                            if let mensaj = dictionary["mensaje"] {
                                self.mostrarAlerta(title: mensaj as! String, message: "")
                            }
                            
                            return
                        }
                    }
                  if let entrega = dictionary["entrega"] {
                                      
                                                                  print(entrega)
                                     self.entregaproducto = (entrega as! String)
                                                                    
                                                                     }
                                 self.defaults.removeObject(forKey:"pkproductoagregado")
                                 self.defaults.removeObject(forKey:"cantidadproductoagregado")
                                 self.defaults.removeObject(forKey:"cantidadcarrito")
                                 self.defaults.removeObject(forKey:"comentarioproducto")
                                 self.send10SecsNotification()

                                 self.performSegue(withIdentifier: "goterminar", sender: self)
                    
                }
            }
        }
    }
    
    
    @IBAction func tarjeta(_ sender: Any) {
        pagar.isEnabled = false
        alert()
        
    }
    func realizarpedidoefectivo() {
        let direccomp = UserDefaults.standard.string(forKey: "direccion")!
        let lugardeentrega = UserDefaults.standard.string(forKey: "lugardeentrega")!
        let fechaentrega = UserDefaults.standard.string(forKey: "fechafinalentrega")!
        let codigodescuento = UserDefaults.standard.string(forKey: "codigodescuento")!
        let descuentocodigo = UserDefaults.standard.string(forKey: "porcentajedescuento")!
        let descc = Int(descuentocodigo) 
        var lugares:[Any] = [ ]
        let pkuser = UserDefaults.standard.string(forKey: "pkuser")!
        let latitud = UserDefaults.standard.double(forKey: "latitud")
        let tar = UserDefaults.standard.double(forKey: "tar")
        let pk_tarifa = UserDefaults.standard.integer(forKey: "pk_tarifa")
        let pktarifa = "\(pk_tarifa)"
print(pk_tarifa)
        let TIENDAPK = UserDefaults.standard.string(forKey: "pktienda")!

        let la:String = "\(latitud)"
        
        let longitud = UserDefaults.standard.double(forKey: "longitud")
        let lo:String = "\(longitud)"
        let  pkproductoagregado = UserDefaults.standard.array(forKey: "pkproductoagregado")! as! [String]
        let  cantidadproductoagregado = UserDefaults.standard.array(forKey: "cantidadproductoagregado")!
        let  productocomentario = UserDefaults.standard.array(forKey: "comentarioproducto")! as! [String]
        let  preciop = UserDefaults.standard.array(forKey: "preciosproductos")! as! [String]
        let envio = UserDefaults.standard.double(forKey: "enviot")
        let subtotal = UserDefaults.standard.double(forKey: "subtotalt")
        let total = UserDefaults.standard.double(forKey: "totalt")
        var i = 0
        for datos in pkproductoagregado{
            var det = ""
            var cant = 0.0
            var pkprod = ""
            var prec = 0.0
            det = productocomentario[i]
            cant =  cantidadproductoagregado[i] as! Double
            pkprod = pkproductoagregado[i]
            prec = Double(preciop[i])!
            
            i = i + 1
            lugares.append(
                
                [
                    "PK_PRODUCTO":pkprod,
                    "PRECIO":prec,
                    "CANTIDAD":cant,
                    "DETALLES":det                         ]
            )
            print(datos)
            
        }
          let formadepago = UserDefaults.standard.string(forKey: "formadepago")
        var pag = ""
        if formadepago == "Efectivo"{
            pag = "E"
        }
        else{
            pag = "C"
        }
        print(pag)
        
        let datos_a_enviar = [
            "CODIGO_DESCUENTO":codigodescuento,
            "DESCUENTO":descc,
            "FECHA_ENTREGA":fechaentrega,
            "PK_POLIGONO":lugardeentrega,
               "PK_CLIENTE":pkuser,
              "DIRECCION":direccomp,
              "LATITUD":la,
            "PK_COSTO_ENVIO":pktarifa,
              "ENVIO":envio,
              "SUBTOTAL":subtotal,
              "LONGITUD":lo,
              "COMISION_TARJETA":0,
              "TOTAL":total,
              "METODO_PAGO":pag,
              "PK_TIENDA":TIENDAPK,
              "SOURCE_ID":"EFECTIVO",
              "DEVICE_SESSION_ID":"EFECTIVO",
              "COSTUMER_ID":"EFECTIVO",
              "PRECIO_ENTREGA":tar,
              "LISTA":lugares
            
            
            ] as NSMutableDictionary
        
        print(datos_a_enviar)
        let dataJsonUrlClass2 = JsonClass2()
        dataJsonUrlClass2.arrayFromJson(url2:"AgregarPedido",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                self.pagar.isEnabled = true
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    print (dictionary)
                   if let mensaje = dictionary["resultado"] {
                                         print(mensaje)
                                         let men = (mensaje) as! Int
                                         if men == 0 {
                                             self.cargador.isHidden = true
                                             self.pagar.isEnabled = true
                                             if let mensaj = dictionary["mensaje"] {
                                                 self.mostrarAlerta(title: mensaj as! String, message: "")
                                             }
                                             
                                             return
                                         }
                                     }
                      if let entrega = dictionary["entrega"] {
                         
                                                     print(entrega)
                        self.entregaproducto = (entrega as! String)
                                                       
                                                        }
                    self.defaults.removeObject(forKey:"pkproductoagregado")
                    self.defaults.removeObject(forKey:"cantidadproductoagregado")
                    self.defaults.removeObject(forKey:"cantidadcarrito")
                    self.defaults.removeObject(forKey:"comentarioproducto")
                    self.send10SecsNotification()

                    self.performSegue(withIdentifier: "goterminar", sender: self)
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
    }
    
    func send10SecsNotification(){
     
       // 1. Creamos el Trigger de la Notificación
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
     
       // 2. Creamos el contenido de la Notificación
       let content = UNMutableNotificationContent()
       content.title = "ACMarket"
       content.subtitle = "Te entregaremos el día:"
        content.body = self.entregaproducto
      content.sound = UNNotificationSound.default
     
       // 3. Creamos la Request
       let request = UNNotificationRequest(identifier: "ZeldaNotification", content: content, trigger: trigger)
     
       // 4. Añadimos la Request al Centro de Notificaciones
       UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
       UNUserNotificationCenter.current().add(request) {(error) in
          if let error = error {
             print("Se ha producido un error: \(error)")
          }
       }
    }
}

