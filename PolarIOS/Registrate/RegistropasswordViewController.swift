//
//  RegistropasswordViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/24/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class RegistropasswordViewController: UIViewController {
    var telefono: String!
    var codigo: String!
    var pk: String!
    
    @IBOutlet weak var buttontel: UIButton!
    @IBOutlet weak var tamañoimg: NSLayoutConstraint!
    @IBOutlet weak var passconfirm: UITextField!
    @IBOutlet weak var pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttontel.layer.cornerRadius = 10
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        
    }
    @IBAction func continuar(_ sender: Any) {
        if passconfirm.text == pass.text {
            self.performSegue(withIdentifier: "go", sender: self)
            
        }
        else{
            mostrarAlerta(title: "Las contraseñas no coinciden", message: "")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            let destino = segue.destination as! RegistropersonalViewController
            destino.telefono = telefono
            destino.codigo = codigo
            destino.pass = pass.text
            destino.pk = self.pk
            
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
            if UIScreen.main.nativeBounds.height > 1130 {
               self.view.frame.origin.y = -tecladoUp.height + 250
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
    }
    
}
