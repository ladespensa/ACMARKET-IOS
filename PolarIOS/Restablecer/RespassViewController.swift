//
//  RespassViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/27/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class RespassViewController: UIViewController {
    
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var tamañoimg: NSLayoutConstraint!
    @IBOutlet weak var pass2: UITextField!
    var telefono: String!
    var codigo: String!
    var pk: String!
    
    @IBOutlet weak var passconfirm: UITextField!
    @IBOutlet weak var pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    @IBAction func continuar(_ sender: Any) {
        
        if pass1.text == pass2.text {
            self.conti()
        }
        else{
            mostrarAlerta(title: "Las contraseñas no coinciden", message: "")
        }
    }
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
    }
    func conti(){
        
        
        let t = self.pass1.text
        let p = self.pk
        print(t)
        let datos_a_enviar = ["PK": p as Any,"PASSWORD": t as Any] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"CambiaPasswordCliente",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    print(dictionary)
                    if let dictionary = dictionary["cliente"] as? [String: Any] {
                        print(dictionary)
                        self.performSegue(withIdentifier: "iniciorest", sender: self)
                        
                        
                    }
                    
                    
                }
            }
        }
        
        
        
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
                self.tamañoimg.constant = 200
                print("IPHONE X XS")
            case 1792:
                self.tamañoimg.constant = 220
                print("IPHONE XR")
            case 2688:
                self.tamañoimg.constant = 250
                print("IPHONE XS MAX")
            default:
                self.tamañoimg.constant = 250
                print("cualquier otro tamaño")
            }
        }else{
            self.tamañoimg.constant = 400

            
        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height > 1135 {
                self.view.frame.origin.y = -tecladoUp.height + 150
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
}
