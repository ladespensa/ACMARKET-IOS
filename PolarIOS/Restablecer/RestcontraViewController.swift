
import UIKit

class RestcontraViewController: UIViewController {
    
    @IBOutlet weak var telefono: UITextField!
    var pk:String = ""
    var codigo:String = ""
    
    @IBOutlet weak var tamañoimg: NSLayoutConstraint!
    @IBOutlet weak var celtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        
    }
    
    
    @IBAction func go(_ sender: Any) {
        if telefono.text != ""
        {
            guard let _ = telefono.text, telefono.text!.count == 10  else {
                              mostrarAlerta(title: "Ingresa un numero valido", message: "")
                              return
                          }
            var tel:String = ""
            tel = telefono.text!
            //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
            let datos_a_enviar = ["TELEFONO": tel as Any] as NSMutableDictionary
            
            //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
            let dataJsonUrlClass = JsonClass()
            dataJsonUrlClass.arrayFromJson(url2:"SendSMSPolar",datos_enviados:datos_a_enviar){ (datos_recibidos) in
                
                DispatchQueue.main.async {//proceso principal
                    
                    if let dictionary = datos_recibidos as? [String: Any] {
                        print(dictionary)
                        if let dictionary = dictionary["cliente"] as? [String: Any] {
                            if let array = dictionary["pk"] {
                                print (array)
                                let array = dictionary["pk"]
                                self.pk = array as! String
                                self.codigo = dictionary["codigo"] as! String
                                self.performSegue(withIdentifier: "goconco", sender: self)
                                
                            }
                            
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goconco" {
            let destino = segue.destination as! RestcodigoViewController
            destino.telefono = "\(telefono.text!)"
            let t:String = "\(self.pk)"
            let o:String = "\(self.codigo)"

            destino.pk = t
            destino.codigorecibido = o
            
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
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
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
