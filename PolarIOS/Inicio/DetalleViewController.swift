//
//  DetalleViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/25/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    
    @IBOutlet weak var descri: UITextView!
    @IBOutlet weak var carritobo: UIButton!
    @IBOutlet weak var hd: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var heigtaltura: NSLayoutConstraint!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagendetalle: UIImageView!
    var tituloproducto:String = ""
    @IBOutlet weak var comentarioadiciona: UITextField!
    var img2:String = ""
    var pkproducto:String = ""
    var prec:String  = ""
    var descrip:String  = ""

    var cantidaddeproducto = 1
    var cantidadcarrito = 0
    var productocomentario:[String] = []
    var imgenproducto:[String] = []
    var pkproductoagregado:[String] = []
    var cantidadproductoagregado:[Any] = []
    
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var bajo: NSLayoutConstraint!
    @IBOutlet weak var imagentamaño: NSLayoutConstraint!

    @IBOutlet weak var agregarbtn: UIButton!
    @IBOutlet weak var carrito: UILabel!
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)

      }
    override func viewDidLoad() {
        super.viewDidLoad()
        agregarbtn.layer.cornerRadius = 10
        carritobo.setTitle("\(0)",for: .normal)

    cantidad.text = "1"
  
        titulo.text = tituloproducto
        let dou = Double(prec)!
        let b:String = String(format:"%.2f", dou)

        precio.text = "$ \(b)"
        descri.text = descrip
    if let url = NSURL(string: img2){
            if let data = NSData(contentsOf: url as URL){
                imagendetalle.image = UIImage(data: data as Data)
                
            }}
        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
            cantidadcarrito = UserDefaults.standard.integer(forKey: "cantidadcarrito")
           carritobo.setTitle("\(cantidadcarrito)",for: .normal)

            pkproductoagregado = UserDefaults.standard.array(forKey: "pkproductoagregado")! as! [String]
            cantidadproductoagregado = UserDefaults.standard.array(forKey: "cantidadproductoagregado")!
            productocomentario = UserDefaults.standard.array(forKey: "comentarioproducto")! as! [String]
            imgenproducto = UserDefaults.standard.array(forKey: "imgenproducto")! as! [String]

            
        }
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
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
           self.heigtaltura.constant = 170

                print("IPHONE 6 6S 7 8")
                self.hd.constant = 70

            case 1920:
                print("IPHONE PLUS")
                self.heigtaltura.constant = 250
                self.hd.constant = 80

            case 2436:
                print("IPHONE X XS")
                self.heigtaltura.constant = 250
                self.hd.constant = 100

            case 1792:
                print("IPHONE XR")
                self.heigtaltura.constant = 250
                self.hd.constant = 120

            case 2688:
                print("IPHONE XS MAX")
                self.heigtaltura.constant = 250
                self.hd.constant = 120

            default:
                print("cualquier otro tamaño")
                self.heigtaltura.constant = 250
                self.hd.constant = 70

            }
        }else{
            self.heigtaltura.constant = 350
                     self.hd.constant = 100
        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height > 1135 {
                self.view.frame.origin.y = -tecladoUp.height + 60
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }
    @IBAction func menos(_ sender: Any) {
        if cantidaddeproducto > 1{
            cantidaddeproducto = cantidaddeproducto - 1
            cantidad.text = "\(cantidaddeproducto)"
        }
    }
    
    @IBAction func mas(_ sender: Any) {
        cantidaddeproducto = cantidaddeproducto + 1
        
        cantidad.text =  "\(cantidaddeproducto)"
        
    }
    @IBAction func agregar(_ sender: Any) {
        let searchValue = pkproducto
        let coment = comentarioadiciona.text!
        var prueba:Bool = false
        var currentIndex = 0
        
        for name in self.pkproductoagregado
        {
            if name == searchValue {
                let t = self.cantidadproductoagregado[currentIndex] as! Int
                var temp:Int = 0
                temp = temp + t
                temp = temp + cantidaddeproducto
                print("Found \(name) for index \(currentIndex)")
                self.cantidadproductoagregado[currentIndex]=(temp)
                self.productocomentario[currentIndex] = coment
                
                prueba = true
                break
            }
            
            currentIndex += 1
        }
        if !prueba {
            self.pkproductoagregado.append(pkproducto)
            self.cantidadproductoagregado.append(cantidaddeproducto)
            self.productocomentario.append(coment)
            self.imgenproducto.append(self.img2)
        }
        self.defaults.set(self.productocomentario, forKey: "comentarioproducto")
        self.defaults.set(self.imgenproducto, forKey: "imgenproducto")

        self.defaults.set(self.pkproductoagregado, forKey: "pkproductoagregado")
        self.defaults.set(self.cantidadproductoagregado, forKey: "cantidadproductoagregado")
        self.cantidadcarrito = self.cantidadcarrito + self.cantidaddeproducto
        self.defaults.set(self.cantidadcarrito, forKey: "cantidadcarrito")
        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
              carritobo.setTitle("\(cantidadcarrito)",for: .normal)
            
        }
        if cantidaddeproducto == 1{
          mostrarAlerta2(title: "\(cantidaddeproducto) producto agregado", message: "¿Quieres ir al carrito?")
        }else{
             mostrarAlerta2(title: "\(cantidaddeproducto) productos agregados", message: "¿Quieres ir al carrito?")
        }
           
    }
    
    
    
    func mostrarAlerta2(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "SI", style: .default) {
            (action) in
            
            self.performSegue(withIdentifier: "carrito", sender: self
                
                
            )

            
        }
        let cancelar = UIAlertAction(title: "NO", style: .default) {
                 (action) in
              
                     self.performSegue(withIdentifier: "cat", sender: self
                                   
                                   
                               )
                 

                 
             }
        alertaGuia.addAction(guiaOk)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)

        
    }
}
