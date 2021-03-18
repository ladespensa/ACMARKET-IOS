
import UIKit

class MetodosdepagoViewController: UIViewController,  UITableViewDelegate,UITableViewDataSource{
    var idtoken:String = ""
    var deviceseisionid:String = ""
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var mas: UIButton!
    var tarjeta:[String] = []
    var imgtar:[String] = []
    var idtar:[String] = []
    var tipoimg:[String] = []
    var uno: Bool = false
    var pkusuario:String = ""
    @IBOutlet weak var tabla: UITableView!
  var primera: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           pkusuario = UserDefaults.standard.string(forKey: "pkuser")!
        if primera == false {
            primera = true
          if isKeyPresentInUserDefaults(key: "idtoken"){
             if isKeyPresentInUserDefaults(key: "nuevatarjeta"){
         let nuevatarjeta = UserDefaults.standard.string(forKey: "nuevatarjeta")!
            if nuevatarjeta == "true"{
                 deviceseisionid = UserDefaults.standard.string(forKey: "deviceseisionid")!
                 idtoken = UserDefaults.standard.string(forKey: "idtoken")!
                print(deviceseisionid)

                print(idtoken)
                defaults.set("false", forKey: "nuevatarjeta")
                agregartarjeta()
            }
                else{
                    consulta()

                }
            } else{
                               consulta()
                           }

            
          } else{
                             consulta()
            
                         }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func regresar(_ sender: Any) {
        if isKeyPresentInUserDefaults(key: "dondepago"){
              
                  let temporal = UserDefaults.standard.string(forKey: "dondepago")!
            if temporal == "carrito"{
                performSegue(withIdentifier: "carrito", sender: sender)
            }else{
                performSegue(withIdentifier: "inicio", sender: sender)

            }
         
              }
              
    }
    
    @IBAction func agregartar(_ sender: Any) {
        if pkusuario != "0"{
            self.performSegue(withIdentifier: "agregar", sender: self)

        }
    
                   else{
           self.alerta(title: "Inicia sesion o registrate", message: "Para continuar disfrutando de los beneficios de LA DESPENSA.")
                   }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.item)
    self.defaults.set(String(idtar[indexPath.item]), forKey: "idtar")
    self.defaults.set(String(tarjeta[indexPath.item]), forKey: "formadepago")
    self.defaults.set(tipoimg[indexPath.item], forKey: "imgformadepago")
  //  self.mostrarAlerta(title: "\(tarjeta[indexPath.item]) seleccionada", message: "")

    
    self.performSegue(withIdentifier: "carrito", sender: self)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if uno == false{
        uno = true
            return 0
        }
        if tarjeta.count > 0{
            
            
            return tarjeta.count
        }
        else{
            return 0
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MetodosCell
        if tipoimg[indexPath.item] == "billete"
        {
            cell.imagentarjeta.image = UIImage(named: "bi")

        }
        if tipoimg[indexPath.item] == "Terminal"
               {
                   cell.imagentarjeta.image = UIImage(named: "negocio")

               }
        if  tipoimg[indexPath.item] != "billete" && tipoimg[indexPath.item] != "Terminal"{
        if tipoimg[indexPath.item] == "visa"{
            cell.imagentarjeta.image = UIImage(named: "visa")


        }
        else{
            cell.imagentarjeta.image = UIImage(named: "ma")

        }
        }
        cell.tarjeta.text =  (tarjeta [indexPath.item] )

        
        return cell
    }
    
    func consulta(){
        let pk = UserDefaults.standard.string(forKey: "pkuser")!
        self.tarjeta.removeAll()
        self.idtar.removeAll()
        let datos_a_enviar = ["PK_CLIENTE": pk] as NSMutableDictionary
        self.tarjeta.append("Efectivo")
     self.idtar.append("Efectivo")
            self.tipoimg.append("billete")
           self.tarjeta.append("Terminal")
        self.idtar.append("Terminal")
               self.tipoimg.append("Terminal")
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"ListaTarjetasClientesByPkCliente",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["tarjetas"] as? NSArray {
                        
                        for obj in array {
                            
                            if let dict = obj as? NSDictionary {
                                
                                self.tarjeta.append(dict.value(forKey: "cardNumber") as! String)
                                //self.imgtar.append(dict.value(forKey: "pk") as! String)
                          self.idtar.append(dict.value(forKey: "id") as! String)
                                self.tipoimg.append(dict.value(forKey: "brand") as! String)

                            }
                        }
                        self.tabla.reloadData()
                        if(self.tarjeta.count >= 5){
                            self.mas.isEnabled = false
                            
                        }
                        
                    }
                    
                }
                
                
            }
        }
    }
    
    func agregartarjeta(){
    
        let pk = UserDefaults.standard.string(forKey: "pkuser")!
       
       let replaced = deviceseisionid.replacingOccurrences(of: "ios-", with: "")
        let datos_a_enviar = ["PK_CLIENTE": pk as Any,"ID_TARJETA" : idtoken as Any,"DEVICE_SESSION_ID":replaced as Any] as NSMutableDictionary
        print(datos_a_enviar)

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"AgregaTarjetasClientes",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    if let mensaje = dictionary["resultado"] {
                       print(mensaje)
                       let men = (mensaje) as! Int
                       if men == 0 {
                    
                       self.mostrarAlerta(title: "No se pudo agregar tu tarjeta intenta mas tarde", message: "")
                        self.tabla.reloadData()
                       return
                       }
                       else{
                        self.consulta()
                        }
                    }
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
    
    func alerta(title: String, message: String) {
    
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
         self.performSegue(withIdentifier: "goregistro", sender: self)

        }
        alertaGuia.addAction(guiaOk)
        present(alertaGuia, animated: true, completion: nil)

        
    }
}


