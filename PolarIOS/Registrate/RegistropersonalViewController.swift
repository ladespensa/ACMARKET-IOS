
import UIKit

class RegistropersonalViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var fecha: UITextField!
    @IBOutlet weak var genero: UITextField!
    @IBOutlet weak var tamañoimg: NSLayoutConstraint!
    @IBOutlet weak var g: UISegmentedControl!
    @IBOutlet weak var correo: UITextField!
    var telefono: String!
    var pass: String!
    var codigo: String!
    var tgenero: String!
    @IBOutlet weak var buttonregistrar: UIButton!
    var pk: String!
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantalla()
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.locale = Locale(identifier: "es_MX")
        datePicker?.addTarget(self, action: #selector(RegistropersonalViewController.dateChange(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegistropersonalViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        fecha.inputView = datePicker
        self.tgenero = g.titleForSegment(at: g.selectedSegmentIndex)
        
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChange(datePicker: UIDatePicker){
        let dateformat = DateFormatter()
        
        dateformat.dateFormat = "yyyy-MM-dd"
        fecha.text = dateformat.string(from: datePicker.date)
        view.endEditing(true)
    }
    @IBAction func godireccion(_ sender: Any) {
        self.buttonregistrar.isEnabled = false
        guard let _ = nombre.text, nombre.text!.count != 0  else {
                   mostrarAlerta(title: "Ingresa un nombre", message: "")
            self.buttonregistrar.isEnabled = true

                   return
               }
               guard let _ = apellido.text, apellido.text!.count != 0  else {
                   mostrarAlerta(title: "Ingrasa un apellido", message: "")
                self.buttonregistrar.isEnabled = true

                   return
               }
               guard let _ = fecha.text, fecha.text!.count != 0  else {
                   mostrarAlerta(title: "Ingrasa tu fecha de nacimiento", message: "")
                self.buttonregistrar.isEnabled = true

                   return
               }
               guard let _ = correo.text, correo.text!.count != 0  else {
                   mostrarAlerta(title: "Ingrasa un correo", message: "")
                self.buttonregistrar.isEnabled = true

                   return
               }
               if isValidEmail(emailID: correo.text!) == false {
                   mostrarAlerta(title: "Ingresa un correo valido", message: "")
                self.buttonregistrar.isEnabled = true

                   return
               }
        let nombr = self.nombre.text!
        let apellid = self.apellido.text!
        let gener = self.tgenero
        let fech = self.fecha.text!
        let corre = self.correo.text!
        let pkk = self.pk
        let pa = self.pass
        print(corre)
        let datos_a_enviar = ["PK": pkk as Any,"PASSWORD": pa as Any,"NOMBRE": nombr as Any,"APELLIDOS": apellid as Any,"GENERO": gener as Any,"FECHA_NACIMIENTO": fech as Any,"CORREO": corre as Any] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"completaInformacion",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let dictionary = dictionary["cliente"] as? [String: Any] {
                        print(dictionary)
                        
                        self.performSegue(withIdentifier: "go", sender: self)
                        
                        
                    }
                    
                    
                }
            }
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            let destino = segue.destination as! ViewController
            destino.registro = self.telefono
            destino.pas = self.pass

            
        }
    }
    
    @IBAction func genero(_ sender: Any) {
        self.tgenero = g.titleForSegment(at: g.selectedSegmentIndex)
        
        
    }
    
    func validar(){
        
       
        
        
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
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
    
    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                print("IPHONE 5 O SE")
                self.tamañoimg.constant = 90

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
            self.view.frame.origin.y = -tecladoUp.height + 50
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
}
