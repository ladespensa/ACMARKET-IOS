import MapKit
import CoreLocation
import UIKit
import Firebase
class ViewController: UIViewController, CLLocationManagerDelegate {
    var mostrarCoordendas: String!
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees = 19.4147
    var longitud : CLLocationDegrees =  -98.1423
    var uno:Bool = false

    @IBOutlet weak var ingespacio: NSLayoutConstraint!
    @IBOutlet weak var contraolvi: UIButton!
    
    @IBOutlet weak var registboton: UIButton!
    
var primero = false
        
        
    
    @IBOutlet weak var notien: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var imagenlogo: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var heigimagen: NSLayoutConstraint!
    @IBOutlet weak var buttoningresar: UIButton!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var registro:String = ""
    var pas:String = ""

    @IBOutlet weak var invitado: UIButton!
    @IBOutlet weak var content: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
            navigationController?.setNavigationBarHidden(true, animated: false)
    
       if isKeyPresentInUserDefaults(key: "pkuser") {
            let pk = UserDefaults.standard.string(forKey: "pkuser")!
                    if pk != ""{
                        if pk == "0"{
                            self.defaults.removeObject(forKey: "pkuser")
                                          self.defaults.removeObject( forKey: "telefono")
                                          self.defaults.removeObject( forKey: "nombre")
                                          self.defaults.removeObject(forKey: "apellidos")
                                          self.defaults.removeObject( forKey: "latitud")
                                          self.defaults.removeObject(forKey: "longitud")
                        }else{
                        usuario.text = UserDefaults.standard.string(forKey: "telefono")!
                        password.text = UserDefaults.standard.string(forKey: "password")!
                        notien.isHidden = true
                    password.isHidden = true
                    usuario.isHidden = true
                    content.isHidden = true
                    buttoningresar.isHidden = true
                    content.isHidden = true
                            invitado.isHidden = true
                    cargador.isHidden = false
                       contraolvi.isHidden = true
                       registboton.isHidden = true
                    cargador.startAnimating()
ing()
                        
        }
        }
        
        }
  
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        pantalla()
        cargador.isHidden = true
        buttoningresar.layer.cornerRadius = 10
        registboton.layer.cornerRadius = 10
        invitado.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
            if registro != ""{
                usuario.text = registro
                password.text = pas
                 self.validar()
                               self.ing()
            }
          if isKeyPresentInUserDefaults(key: "pkuser"){
       
        
    }

       Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
         if !self.isKeyPresentInUserDefaults(key: "tutorial") {
                              self.defaults.set("true", forKey: "tutorial")
                                  self.performSegue(withIdentifier: "tutorial", sender: self)
                                                     
                          }
        
       }

        
       
        
    
    }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if primero == false{
                primero = true
            if let location = locations.first {
                self.latitud = location.coordinate.latitude
                self.longitud = location.coordinate.longitude
                
            }
            }
        }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
     func mostrarAlerta2(title: String, message: String) {
          
              let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
              let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
                  (action) in
       
                self.validar()
                self.ing()
              }
               alertaGuia.addAction(guiaOk)
               present(alertaGuia, animated: true, completion: nil)
       }
    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
       
            case 1136:
                print("IPHONE 5 O SE")
                ingespacio.constant = 1
            case 1334:
                print("IPHONE 6 6S 7 8")
                self.heigimagen.constant = 150

            case 1920:
                print("IPHONE PLUS")
            case 2436:
                self.heigimagen.constant = 200
                print("IPHONE X XS")
            case 1792:
                self.heigimagen.constant = 220
                print("IPHONE XR")
            case 2688:
                self.heigimagen.constant = 250
                print("IPHONE XS MAX")
            default:
                self.heigimagen.constant = 250
                print("cualquier otro tamaño")
            }
        }else{
            self.heigimagen.constant = 400

            
        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
          
            if UIScreen.main.nativeBounds.height > 1135 {
                self.view.frame.origin.y = -tecladoUp.height + 200
                
            }
        }else{
            self.view.frame.origin.y = 0
        }
     
    }
    
    func validar(){
        
        guard let _ = password.text, password.text!.count != 0  else {
            mostrarAlerta(title: "Ingresa un telefono valido", message: "")
            return
        }
        guard let _ = usuario.text, usuario.text!.count != 0  else {
            mostrarAlerta(title: "Ingrasa la contraseña", message: "")
            return
        }
        
        
        
    }
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
    }
    
    
    @IBAction func ingresar(_ sender: Any) {

        checkLocationAuthorization()

   
    }
    func ing(){
    if usuario.text != "" && password.text != ""
    {
    self.cargador.isHidden = false
    self.cargador.startAnimating()
    self.buttoningresar.isEnabled = false
    let usu=usuario.text
    let pass=password.text
    
    //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
    let datos_a_enviar = ["TELEFONO": usu as Any,"PASSWORD":pass as Any] as NSMutableDictionary
    
    //ejecutamos la funció n arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
    let dataJsonUrlClass = JsonClass()
    dataJsonUrlClass.arrayFromJson(url2:"ClientesLogin",datos_enviados:datos_a_enviar){ (datos_recibidos) in
    
    DispatchQueue.main.async {//proceso principal
    
    if let dictionary = datos_recibidos as? [String: Any] {
    
    if let mensaje = dictionary["resultado"] {
        print(mensaje)
    let men = (mensaje) as! Int
    if men == 0 {
    self.cargador.isHidden = true
    self.buttoningresar.isEnabled = true
    self.mostrarAlerta(title: "Contraseña incorrecta", message: "")
    return
    }
    }
    if let dictionary = dictionary["cliente"] as? [String: Any] {
    
    self.cargador.isHidden = true
    self.buttoningresar.isEnabled = true
    self.defaults.set(dictionary["openid"], forKey: "openid")
        self.defaults.set(dictionary["password"], forKey: "password")

    self.defaults.set(dictionary["pk"], forKey: "pkuser")
    self.defaults.set(dictionary["telefono"], forKey: "telefono")
    self.defaults.set(dictionary["nombre"], forKey: "nombre")
        self.defaults.set(dictionary["foto"], forKey: "foto")
    self.defaults.set(dictionary["apellidos"], forKey: "apellidos")
        self.defaults.set(dictionary["correo"], forKey: "correo")
             self.defaults.set("Efectivo", forKey: "formadepago")

        self.actualiartoken()

    }
    else{
    self.cargador.isHidden = true
    self.buttoningresar.isEnabled = true
    
    }
    
    }
    
    }
    }
    }
    }
  
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(self.latitud)")!
        //21.228124
        let lon: Double = Double("\(self.longitud)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country as Any)
                    print(pm.locality as Any)
                    print(pm.subLocality as Any)
                    print(pm.thoroughfare as Any)
                    print(pm.postalCode as Any)
                    print(pm.subThoroughfare as Any)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    let t = pm.locality! + " "
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    self.defaults.set(t, forKey: "estado")
                    
                    self.defaults.set(addressString, forKey: "direccion")
                    self.defaults.set("\(String(describing: self.latitud))", forKey: "latitud")
                    self.defaults.set("\(String(describing: self.longitud))", forKey: "longitud")
                    self.performSegue(withIdentifier: "gohome", sender: self)
                    
                    print(addressString)
                    return
                }
        })
        return
    }
      func checkLocationAuthorization() {
             switch CLLocationManager.authorizationStatus() {
             case .authorizedWhenInUse:
print("ok")
             validar()
                ing()
             case .denied:
                 // Show alert instructing them how to turn on permissions
     mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "Entra a configuraciòn/acmarket y activa la ubicaciòn")

                 break
             case .notDetermined:
                 mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "")

             case .restricted:
                 // Show an alert letting them know what's up
                 print ("error")
                 break
             case .authorizedAlways:
                validar()
                ing()

                 break
         
             @unknown default:
print("ok")             }
         }
         
    func  obtener() {
        mostrarCoordendas = "Lat: \(latitud), Long: \(longitud) "
        print(mostrarCoordendas as Any)
        
    }
    
    func actualiartoken() {
       
          guard let token = Messaging.messaging().fcmToken else { return  }
           print("TOKEN", "")
           let us =  UserDefaults.standard.string(forKey: "pkuser")!
           
        let datos_a_enviar = ["PK": us  as Any,"TOKEN": token as Any,"PLATAFORMA":"IOS"] as NSMutableDictionary
           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = JsonClass()
           dataJsonUrlClass.arrayFromJson(url2:"CambiaToken",datos_enviados:datos_a_enviar){ (datos_recibidos) in
               
               DispatchQueue.main.async {//proceso principal
                   print("token actualizado")
                   self.defaults.set("", forKey: "estado")
                              
                              self.defaults.set("", forKey: "direccion")
                              self.defaults.set("", forKey: "latitud")
                              self.defaults.set("", forKey: "longitud")
                              self.performSegue(withIdentifier: "gohome", sender: self)
                   
               }
               
           }
        
        
    }
    
    
    @IBAction func INVITADO(_ sender: Any) {
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        
        self.defaults.set(0, forKey: "openid")
              self.defaults.set("0", forKey: "password")

          self.defaults.set("0", forKey: "pkuser")
          self.defaults.set("ACMarket", forKey: "telefono")
          self.defaults.set("ACMarket INVITADO", forKey: "nombre")
              self.defaults.set("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", forKey: "foto")
          self.defaults.set("", forKey: "apellidos")
              self.defaults.set("", forKey: "correo")
                   self.defaults.set("Efectivo", forKey: "formadepago")

        self.defaults.set("", forKey: "direccion")
                             self.defaults.set("", forKey: "latitud")
                             self.defaults.set("", forKey: "longitud")
                             self.performSegue(withIdentifier: "gohome", sender: self)
    }
    
    
    
}

