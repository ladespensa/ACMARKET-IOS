//
//  RestcodigoViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/27/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class RestcodigoViewController: UIViewController {
    
    @IBOutlet weak var codigo: UITextField!
    var pk: String!
    var codigorecibido: String!
    
    var telefono: String!
    
    @IBOutlet weak var tamañoimg: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print(self.telefono as Any)
        print (codigorecibido as Any)
        print (pk as Any)

    }
    
    
    @IBAction func continuar(_ sender: Any) {
       let c = codigorecibido
        let t:String = codigo.text!
        print(t)
        print(c as Any)
        if c == t
        {        self.performSegue(withIdentifier: "goconfirmar", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goconfirmar" {
            let p:String = self.pk
print(p)
            let destino = segue.destination as! RespassViewController
            destino.telefono = telefono
            destino.codigo = codigo.text
            destino.pk = p
            
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
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height > 1135 {
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
}
