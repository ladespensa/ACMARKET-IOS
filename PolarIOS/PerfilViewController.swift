//
//  PerfilViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/3/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//
import UIKit

class PerfilViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var imageTaken: UIImage? = nil
    var pathImage: NSURL? = nil
    @IBOutlet weak var modificar: UIButton!
    let defaults = UserDefaults.standard
    var miControladorImagen: UIImagePickerController!
    var strBase64:String    = ""
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var ancho: NSLayoutConstraint!
    @IBOutlet weak var espacioimagen: NSLayoutConstraint!
    @IBOutlet weak var altoimagen: NSLayoutConstraint!
    @IBOutlet weak var anchoimagen: NSLayoutConstraint!
    
    @IBOutlet weak var lead: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tamaimg: NSLayoutConstraint!
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var center: NSLayoutConstraint!
    var pkusuario:String = ""
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var imagenusuario: UIImageView!
      @IBOutlet weak var nombreuser: UILabel!
    @IBOutlet weak var traling: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    var menuVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        pkusuario = UserDefaults.standard.string(forKey: "pkuser")!

       btn1.layer.cornerRadius = 10
              btn2.layer.cornerRadius = 10
        cargador.isHidden = true
        cargador.startAnimating()

pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
      }
    
    @IBAction func takePhoto(_ sender: Any) {
        if pkusuario != "0"{
        //COMPROBAMOS SI EL DISPOSITIVO TIENE CÁMARA
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
          miControladorImagen =  UIImagePickerController()
            miControladorImagen.delegate = self
            miControladorImagen.sourceType = .camera
          
            present(miControladorImagen, animated: true, completion: nil)
          }else{
              
              print("No hay cámara")
              
          }
        
        }
        else{
           self.alerta(title: "Inicia sesion o registrate", message: "Para continuar disfrutando de los beneficios de LA DESPENSA.")

           
        }
        
    }
   func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = info[.originalImage] as? UIImage
        image = self.resizeImage(image: image!, targetSize: CGSize(width: 200.0, height: 200.0))
        imageView.image = image
    
        picker.dismiss(animated: true, completion: nil)
        
        let imageData:NSData = image!.pngData()! as NSData
        self.strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    @IBAction func cerrarsesion(_ sender: Any) {
        self.defaults.removeObject(forKey: "pkuser")
             self.defaults.removeObject( forKey: "telefono")
             self.defaults.removeObject( forKey: "nombre")
             self.defaults.removeObject(forKey: "apellidos")
             self.defaults.removeObject( forKey: "latitud")
             self.defaults.removeObject(forKey: "longitud")
             self.performSegue(withIdentifier: "inicio", sender: self)
    }
    
    
    
    
    @IBAction func abrir(_ sender: Any) {
          self.defaults.set("inicio", forKey: "dondepago")
        
        let defaults = UserDefaults.standard
        defaults.set("false", forKey: "nuevatarjeta")
        performSegue(withIdentifier: "metodo", sender:sender)

    }
    
    @IBAction func Guardar(_ sender: Any) {
        if pkusuario != "0"{
                  guardar()

              }
              else{
                  self.alerta(title: "Inicia sesion o registrate", message: "Para continuar disfrutando de los beneficios de LA DESPENSA.")

                 
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
              ancho.constant = 70

                tamaimg.constant = 70
            case 1334:
                print("IPHONE 6 6S 7 8")
           

            case 1920:
                print("IPHONE PLUS")
            case 2436:
                ancho.constant = 200

                self.tamaimg.constant = 200
                print("IPHONE X XS")
            case 1792:
                ancho.constant = 200

                self.tamaimg.constant = 200
                print("IPHONE XR")
            case 2688:
                ancho.constant = 200

                self.tamaimg.constant = 200
                print("IPHONE XS MAX")
            default:
       
                print("cualquier otro tamaño")
            }
            
        }
        else{
            self.tamaimg.constant = 250

            self.ancho.constant = 250

        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height > 1135 {
                self.view.frame.origin.y = -tecladoUp.height + 80
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
     func guardar() {
        self.validar()
        cargador.isHidden = false
        modificar.isEnabled = false
                    let corre = correo.text
                    let nombr = nombre.text
                    let apellid = apellidos.text
                    
                    
           let us =  UserDefaults.standard.string(forKey: "pkuser")!
           
                    let datos_a_enviar = ["PK": us  as Any,"FOTO": self.strBase64 as Any,"NOMBRE": nombr as Any,"APELLIDOS":apellid as Any,"CORREO": corre as Any] as NSMutableDictionary
           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = JsonClass()
           dataJsonUrlClass.arrayFromJson(url2:"actualizaDatosPerfilCliente",datos_enviados:datos_a_enviar){ (datos_recibidos) in
               
               DispatchQueue.main.async {//proceso principal
                self.cargador.isHidden = true
                self.modificar.isEnabled = true
                if let dictionary = datos_recibidos as? [String: Any] {
                
                if let mensaje = dictionary["resultado"] {
                print(mensaje)
                let men = (mensaje) as! Int
                if men == 0 {
                    self.mostrarAlerta(title: "Intenta mas tarde", message: "")
                    }
                else{
                    self.mostrarAlerta(title: "Informaciòn actualizada", message: "")
                    self.defaults.set(self.strBase64, forKey: "foto")
                    self.defaults.set(nombr, forKey: "nombre")
                    self.defaults.set(apellid, forKey: "apellidos")
                    self.defaults.set(corre, forKey: "correo")

                    }
                    
                    }
               }
               
           }
        }
    
    }
    func validar(){
           
           guard let _ = nombre.text, nombre.text!.count != 0  else {
               return
           }
           guard let _ = apellidos.text, apellidos.text!.count != 0  else {
               return
           }
           guard let _ = correo.text, correo.text!.count != 0  else {
               return
           }
         
           if isValidEmail(emailID: correo.text!) == false {
               mostrarAlerta(title: "Ingresa un correo valido", message: "")
           }
           
           
       }
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
        
    }
 func alerta(title: String, message: String) {
 
     let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
     let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
         (action) in
      self.performSegue(withIdentifier: "goregistro", sender: self)

     }
     alertaGuia.addAction(guiaOk)
     present(alertaGuia, animated: true, completion: nil)
    
     
 }
    
    @IBAction func cancelar(_ sender: Any) {
 
                let fot =  UserDefaults.standard.string(forKey: "foto")!
                if fot.count > 100
        {
            let dataDecoded : Data = Data(base64Encoded: fot, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            
            imageView.image = decodedimage
            imagenusuario.image = decodedimage
         imagenusuario.layer.borderWidth = 1
          imagenusuario.layer.masksToBounds = false
          imagenusuario.layer.borderColor = UIColor.black.cgColor
          imagenusuario.layer.cornerRadius = imagenusuario.frame.height/2
          imagenusuario.clipsToBounds = true
            imageView.layer.borderWidth = 1
                    imageView.layer.masksToBounds = false
                    imageView.layer.borderColor = UIColor.black.cgColor
                    imageView.layer.cornerRadius = imageView.frame.height/2
                    imageView.clipsToBounds = true
                }
            let nombr = UserDefaults.standard.string(forKey: "nombre")!
                        let apellido = UserDefaults.standard.string(forKey: "apellidos")!
                         apellidos.text = apellido

                nombre.text = nombr
                correo.text = UserDefaults.standard.string(forKey: "correo")!
                telefono.text = UserDefaults.standard.string(forKey: "telefono")!
                    nombreuser.text = "\(nombr) \(apellido)"
              lead.constant = 0

                               leading.constant = 0
                               traling.constant = 0
        self.tabBarController?.selectedIndex = 0

    }
    @IBAction func go(_ sender: Any) {
             if !menuVisible {
                     //  leading.constant = 250
                lead.constant = 250
            center.constant = center.constant + 250

                       menuVisible = true
                   } else {
                lead.constant = 0
     center.constant = 0
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
             self.tabBarController?.selectedIndex = 4
            lead.constant = 0

                             leading.constant = 0
                             traling.constant = 0
                             menuVisible = false
         }
         
         @IBAction func pedidos(_ sender: Any) {
             self.tabBarController?.selectedIndex = 1
            lead.constant = 0

                             leading.constant = 0
                             traling.constant = 0
                             menuVisible = false
             
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
    
    @IBAction func histpe(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
             lead.constant = 0

                              leading.constant = 0
                              traling.constant = 0
                              menuVisible = false
    }
    
         @IBAction func ayuda(_ sender: Any) {
             self.tabBarController?.selectedIndex = 3
            lead.constant = 0

                             leading.constant = 0
                             traling.constant = 0
                             menuVisible = false
         }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                  lead.constant = 0
            lead.constant = 0
       center.constant = 0
                         leading.constant = 0
                         traling.constant = 0
          navigationController?.isToolbarHidden = true
        tabBarController?.hidesBottomBarWhenPushed = false
                let fot =  UserDefaults.standard.string(forKey: "foto")!
                if fot.count > 100
        {
            let dataDecoded : Data = Data(base64Encoded: fot, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            
            imageView.image = decodedimage
            imagenusuario.image = decodedimage
         imagenusuario.layer.borderWidth = 1
          imagenusuario.layer.masksToBounds = false
          imagenusuario.layer.borderColor = UIColor.black.cgColor
          imagenusuario.layer.cornerRadius = imagenusuario.frame.height/2
          imagenusuario.clipsToBounds = true
                    imageView.layer.masksToBounds = false
                 
                    imageView.layer.cornerRadius = imageView.frame.height/2
                    imageView.clipsToBounds = true
                }
                
            let nombr = UserDefaults.standard.string(forKey: "nombre")!
                        let apellido = UserDefaults.standard.string(forKey: "apellidos")!
                         apellidos.text = apellido

                nombre.text = nombr
                correo.text = UserDefaults.standard.string(forKey: "correo")!
                telefono.text = UserDefaults.standard.string(forKey: "telefono")!
                    nombreuser.text = "\(nombr) \(apellido)"
    }
 
         @IBAction func cerrar(_ sender: Any) {
            lead.constant = 0

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
    
}

