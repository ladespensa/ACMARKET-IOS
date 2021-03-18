//
//  CategoriatiendasViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/28/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//
import CoreLocation
import MapKit

import UIKit
import Kingfisher
class CategoriatiendasViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
    @IBOutlet weak var lcoll: NSLayoutConstraint!
    @IBOutlet weak var lprom: NSLayoutConstraint!
    @IBOutlet weak var lcoll2: NSLayoutConstraint!
    var scrollingTimer = Timer()

    @IBOutlet weak var llp: NSLayoutConstraint!
    
    var olatitud:[Double] = []
    var olongitud:[Double] = []
    var oolatitud:[Double] = []
    var oolongitud:[Double] = []

    var IMAGEURL:[UIImage] = []
    var IMAGEURL2:[UIImage] = []
    var cantidadarreglos:[Int] = []
    
    var pkpoligonoentrega:[Int] = []
    var pkpoligonoentrega2:[Int] = []

    
    var poligonversion:[String] = []

    @IBOutlet weak var nombreuser: UILabel!
    @IBOutlet weak var imagenusuario: UIImageView!
    
    var menuVisible = false
    var actualiZAR = false

    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell"
    var link = ""
    var img:[String] = []
    var titulo:[String] = []
    var pk:[String] = []
    var pproducto:[String] = []

    var pimg:[String] = []
    var ptitulo:[String] = []
    var pnombre:[String] = []
    
    var pkpoligono:[String] = []
    var pkpoligonob:[String] = []

    var imagenanuncio:[String] = []
    var anucioborrado:[Bool] = []

    var ppk:[String] = []
    var pprecio:[Any] = []
    var pdes:[String] = []
    var dimg:[String] = []
    var dpk:[String] = []
    var dtitulo:[String] = []
    var pK_TIENDA:[String] = []
    
    var pK_TIENDAs = ""
    var img2:UIImage!
    var img22:String!
    
    var de = ""
    var tit = ""
    var pre = ""
    var pkprod = ""
    var pkt:String = ""
    var t:String = ""
    
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        obtenermapas()
       self.lprom.constant = 0
              self.lcoll.constant = 0
          navigationController?.isToolbarHidden = true

  self.defaults.set("", forKey: "formadepago")
        tabBarController?.hidesBottomBarWhenPushed = false
        let nombr = UserDefaults.standard.string(forKey: "nombre")!
              let apellido = UserDefaults.standard.string(forKey: "apellidos")!
              nombreuser.text = "\(nombr) \(apellido)"
              let fot =  UserDefaults.standard.string(forKey: "foto")!
              if fot.count > 100
              {
                  let dataDecoded : Data = Data(base64Encoded: fot, options: .ignoreUnknownCharacters)!
                  let decodedimage = UIImage(data: dataDecoded)
                  imagenusuario.image = decodedimage
                  imagenusuario.layer.borderWidth = 1
                  imagenusuario.layer.masksToBounds = false
                  imagenusuario.layer.borderColor = UIColor.black.cgColor
                  imagenusuario.layer.cornerRadius = imagenusuario.frame.height/2
                  imagenusuario.clipsToBounds = true
                  imagenusuario.image = decodedimage
              }
    }
    

    @IBAction func btntutorialabrir(_ sender: Any) {
        self.performSegue(withIdentifier: "tuto", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantalla()
    
        self.defaults.set("", forKey: "descuentoseleccionado")

        self.defaults.removeObject(forKey:"pkproductoagregado")
        self.defaults.removeObject(forKey:"cantidadproductoagregado")
        self.defaults.removeObject(forKey:"cantidadcarrito")
        self.defaults.removeObject(forKey:"comentarioproducto")
        
  
        cargador.startAnimating()
        self.view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
            self.view.addSubview(collection2)
                 collection2.dataSource = self
                 collection2.delegate = self
        obtenerincidencias()
    }
    
    
    @objc func scrollToNextCell(){

          //get Collection View Instance

          //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height);

          //get current content Offset of the Collection view
          let contentOffset = collection2.contentOffset;

          //scroll to next cell
        collection2.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);


      }

      /**
       Invokes Timer to start Automatic Animation with repeat enabled
       */
      func startTimer() {



        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(CategoriatiendasViewController.scrollToNextCell), userInfo: nil, repeats: true)


      }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
              print(indexPath.item)
    
              if collectionView == self.collection {
                  // get a reference to our storyboard cell
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoriasCell
                  let url = URL(string: self.img[indexPath.item])
                  cell.imagen.kf.setImage(with: url)
                  
                  
                  cell.texto.text = (self.titulo  [indexPath.item] )
                  
                  return cell
              }
                  
              else {        
                //  var rowIndex = indexPath.row
                  //               if(rowIndex < numberOfRecords){
                    //                   rowIndex = (rowIndex + 1)
                      //             }
                        //           else{
                          //             rowIndex = 0
                            //       }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath as IndexPath) as! PromoCell
                  
                  let url = URL(string: self.imagenanuncio[indexPath.item])
                  cell.imgpromo.kf.setImage(with: url)
                  
                //scrollingTimer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(CategoriatiendasViewController.startTimer(theTimer:)), userInfo: rowIndex, repeats: false)
                self.startTimer()
                  return cell
              }
              
          }
      

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collection {
            
            if self.titulo.count > 0 {
                print(titulo.count)
                
                
                return titulo.count
                
            }else{
                return 0
                
                
            }         }
            
        else {
            
            if self.imagenanuncio.count > 0 {
                
                
                return imagenanuncio.count
                
            }else{
                return 0
                
                
            }
        }
        
        
    }
        @objc func startTimer(theTimer:Timer){

            UIView.animate(withDuration: 3.0, delay: 0,options: .curveEaseOut, animations: {
            self.collection2.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
    }
    func mostrarAlerta(title: String, message: String) {
        
        
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Aceptar", style: .cancel)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        
        if collectionView == self.collection {
            print("You selected cell #\(indexPath.item)!")
            pkt=pk[indexPath.item]
            let categoriatienda=titulo[indexPath.item]
            self.defaults.set(categoriatienda, forKey: "categoriatienda")
            self.defaults.set(self.pkt, forKey: "pkcategoritatienda")
            self.defaults.set(self.pkt, forKey: "pktienda")
            self.defaults.set(categoriatienda, forKey: "nombretineda")
            self.defaults.set("normal", forKey: "promtit")
            
            self.performSegue(withIdentifier: "gotiendas", sender: self)
        }else{
            self.defaults.set(self.ppk[indexPath.item], forKey: "tpktienda")
            self.defaults.set(self.pK_TIENDA[indexPath.item], forKey: "pktienda")
            self.defaults.set(self.dtitulo[indexPath.item], forKey: "categoriatienda")
            self.defaults.set(self.dpk[indexPath.item], forKey: "pkcategoritatienda")
            self.defaults.set(self.dimg[indexPath.item], forKey: "depimg")
            self.defaults.set(self.dpk[indexPath.item], forKey: "deppk")
            self.defaults.set(self.dtitulo[indexPath.item], forKey: "depnombre")
          //  self.defaults.set(self.ppk[indexPath.item], forKey: "deppk")
            self.defaults.set(self.pnombre[indexPath.item], forKey: "depnombre")
            let  nombretineda = self.dtitulo[indexPath.item]
            self.defaults.set(self.dtitulo[indexPath.item], forKey: "nombretineda")
            self.defaults.set(nombretineda, forKey: "tt")
            self.defaults.set("promo", forKey: "promtit")
            
            let  nom = pnombre[indexPath.item]
            self.defaults.set(nom, forKey: "dd")
            self.defaults.set(self.dpk[indexPath.item], forKey: "tpkcategoria")
            img22 = self.pimg[indexPath.item]
            de = self.pdes[indexPath.item]
            tit = self.ptitulo[indexPath.item]
            pre = self.pprecio[indexPath.item] as! String
            pkprod = self.pproducto[indexPath.item]
            self.performSegue(withIdentifier: "goproducto", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goproducto" {
            let detalle = segue.destination as! DetalleViewController
            detalle.tituloproducto = self.tit
            detalle.img2 = self.img22
            detalle.pkproducto = self.pkprod
            detalle.prec = self.pre
            detalle.descrip = self.de
            tabBarController?.hidesBottomBarWhenPushed = true
            
        }
        if segue.identifier == "gotiendas" {
            let destino = segue.destination as! TiendasViewController
            destino.pkcategoria = pkt
            tabBarController?.hidesBottomBarWhenPushed = true
        }
        if segue.identifier == "tuto" {
                let destino = segue.destination as! TutorialCollectionViewController
                destino.tuto = true
                
            }
        
    }
    
    @IBAction func amigos(_ sender: Any) {
        if UIDevice().userInterfaceIdiom == .phone {
            //  Converted to Swift 5.2 by Swiftify v5.2.18840 - https://objectivec2swift.com/
            let textToShare = self.link
            
            let objectsToShare = [textToShare]
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            
            present(activityVC, animated: true)
            
        }else{
            
            
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        self.performSegue(withIdentifier: "inicio", sender: self)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    
    func obtenerincidencias() {
        
        var encuesta = 0
        let pk = UserDefaults.standard.string(forKey: "pkuser")!

        let datos_a_enviar = ["PK_CLIENTE":  pk as String] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass2 = JsonClass()
        dataJsonUrlClass2.arrayFromJson(url2:"TiendasV2/Obtener",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                if let dictionary = datos_recibidos as? [String: Any] {
                    let imagee = UIImage.gifImageWithName("gifcargando")
                    
                      
                                           if let en = dictionary["faltaCalificacion"]     {
                                            print(en)

                    encuesta = dictionary["faltaCalificacion"] as! Int
                                                                                     self.defaults.set("\(encuesta)", forKey: "faltaCalificacion")
                                                                                     
                                                                                 }else{
                                                                                     self.defaults.set("0", forKey: "faltaCalificacion")

                                                                                 }
                                           
                                                     if dictionary["cantidadMisPedidos"] != nil {

                                        let   cantidadMisPedidos = dictionary["cantidadMisPedidos"] as! Int
                                                       if(cantidadMisPedidos > 0){
                                                                  self.defaults.set((cantidadMisPedidos), forKey: "cantidadMisPedidos")
                                                                 }else{
                                                             self.defaults.set(0, forKey: "cantidadMisPedidos")

                                                                                                        }
                                           }
                    
                    
                    
                    
                    if let array = dictionary["tiendas"] as? NSArray {
                        print("detalles")
                        
                        if let publicaopen = dictionary["publicaopen"] {
                            self.defaults.set(publicaopen, forKey: "publicaopen")

                        }
                        
                        if let idopen = dictionary["idopen"] {
                                                self.defaults.set(idopen, forKey: "idopen")

                                            }
                        if let openproduccion = dictionary["openproduccion"] {
                                                                self.defaults.set(openproduccion, forKey: "openproduccion")

                                                            }
                        
            
                        
                        
                        if let mensaje = dictionary["link"] {
                            print(mensaje)
                            self.link = mensaje as! String
                            self.defaults.set(self.link, forKey: "link")
                            
                        }else{
                            self.defaults.set("", forKey: "link")

                        }
                        
                        for obj in array {
                            if let dict = obj as? NSDictionary {

                                self.img.append(dict.value(forKey: "imagen") as! String)
                                self.IMAGEURL.append(imagee!)
                                self.titulo.append(dict.value(forKey: "nombre") as! String)
                                self.pk.append(dict.value(forKey: "pk") as! String)
                                let dia = dict.value(forKey: "pk") as! String
                                self.pkpoligonoentrega2.append(dict.value(forKey: "lunes") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "martes") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "miercoles") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "jueves") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "viernes") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "sabado") as! Int)
                                self.pkpoligonoentrega2.append(dict.value(forKey: "domingo") as! Int)
                                
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "lunes") as! Int){
                                                                   self.pkpoligonoentrega.append(dict.value(forKey: "lunes") as! Int)

                                                               }
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "martes") as! Int){
                                    self.pkpoligonoentrega.append(dict.value(forKey: "martes") as! Int)

                                }
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "miercoles") as! Int){
                                                                  self.pkpoligonoentrega.append(dict.value(forKey: "miercoles") as! Int)

                                                              }
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "jueves") as! Int){
                                                                  self.pkpoligonoentrega.append(dict.value(forKey: "jueves") as! Int)

                                                              }
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "viernes") as! Int){
                                                                  self.pkpoligonoentrega.append(dict.value(forKey: "viernes") as! Int)

                                                              }
                                
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "sabado") as! Int){
                                                                  self.pkpoligonoentrega.append(dict.value(forKey: "sabado") as! Int)

                                                              }
                                if !self.pkpoligonoentrega.contains(dict.value(forKey: "domingo") as! Int){
                                                                  self.pkpoligonoentrega.append(dict.value(forKey: "domingo") as! Int)

                                                              }
                        
                                self.defaults.set(dict.value(forKey: "entregA_LUNES") as! String, forKey:"Monday\(dia)")
                                
                                self.defaults.set(dict.value(forKey: "entregA_MARTES") as! String, forKey:"Tuesday\(dia)")
                                
                                self.defaults.set(dict.value(forKey: "entregA_MIERCOLES") as! String, forKey:"Wednesday\(dia)")
                                
                                self.defaults.set(dict.value(forKey: "entregA_JUEVES") as! String, forKey:"Thursday\(dia)")
                                
                                self.defaults.set(dict.value(forKey: "entregA_VIERNES") as! String, forKey:"Friday\(dia)")
                                
                                self.defaults.set(dict.value(forKey: "entregA_SABADO") as! String, forKey:"Saturday\(dia)")
                                self.defaults.set(dict.value(forKey: "entregA_EXPRESS") as! String, forKey:"express\(dia)")

                                self.defaults.set(dict.value(forKey: "entregA_DOMINGO") as! String, forKey:"Sunday\(dia)")
                                
                                self.defaults.set(self.pkpoligonoentrega2, forKey:"2pkpoligonoentrega\(dia)")

                             self.defaults.set(self.pkpoligonoentrega2, forKey:"pkpoligonoentrega\(dia)")
                                self.pkpoligonoentrega2=[]
                            }
                        }

                    }
                    if  let array2 = dictionary["promos"] as? NSArray {
                        
                        for obj2 in array2 {
                            if let dict = obj2 as? NSDictionary {
                                self.ppk.append(dict.value(forKey: "pK_TIPO_TIENDA") as! String)
                                self.pdes.append(dict.value(forKey: "descripcion") as! String)
                                self.ptitulo.append(dict.value(forKey: "producto") as! String)
                                self.pimg.append(dict.value(forKey: "imagen") as! String)
                                self.IMAGEURL2.append(imagee!)
                                self.pnombre.append(dict.value(forKey: "categoria") as! String)
                                self.dpk.append(dict.value(forKey: "pK_CATEGORIA") as! String)
                                self.dimg.append(dict.value(forKey: "imageN_TIENDA") as! String)
                                self.dtitulo.append(dict.value(forKey: "tienda") as! String)
                                self.pprecio.append(dict.value(forKey: "precio") as! String)
                                self.pK_TIENDA.append(dict.value(forKey: "pK_TIENDA") as! String)
                                self.pproducto.append(dict.value(forKey: "pk") as! String)

                            }
                        }
                        
                        
                    }
   if  let array3 = dictionary["sliderImg"] as? NSArray {
                      
                      for obj3 in array3 {
                          if let dict3 = obj3 as? NSDictionary {
                              self.imagenanuncio.append(dict3.value(forKey: "imagen") as! String)
                               self.anucioborrado.append(dict3.value(forKey: "borrado") as! Bool)

                          }
                      }
                      
                      
                  }

                    
                }
        
                
                self.cargador.isHidden = true
                   self.collection.reloadData()
                self.collection2.reloadData()

                if(encuesta != 0){
                    self.performSegue(withIdentifier: "encuesta", sender: self)

                
                }
            }
        }
        
    }
    
    
    @IBAction func menu(_ sender: Any) {
        
        if !menuVisible {
            self.lprom.constant = 250
            self.lcoll.constant = 250
            self.llp.constant = 250
            menuVisible = true
        
        } else {
            self.llp.constant = 0

            self.lprom.constant = 0
             self.lcoll.constant = 0
            menuVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
        
    }
    
    @IBAction func cerrar(_ sender: Any) {
   self.lprom.constant = 0
      self.lcoll.constant = 0
        self.llp.constant = 0

        menuVisible = false
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        
        self.performSegue(withIdentifier: "inicio", sender: self)
    }
    @IBAction func notificaciones(_ sender: Any) {
        
    }
    @IBAction func pedidos(_ sender: Any) {
  self.lprom.constant = 0
     self.lcoll.constant = 0
        self.llp.constant = 0

        menuVisible = false
        self.tabBarController?.selectedIndex = 1
        
    }
    
    @IBAction func ayuda(_ sender: Any) {
  self.lprom.constant = 0
        self.llp.constant = 0
     self.lcoll.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 3
        
        
    }
    @IBAction func invitaramigo(_ sender: Any) {
       self.lprom.constant = 0
          self.lcoll.constant = 0
        self.llp.constant = 0
        if UIDevice().userInterfaceIdiom == .phone {
            //  Converted to Swift 5.2 by Swiftify v5.2.18840 - https://objectivec2swift.com/
            let textToShare = self.link
            
            let objectsToShare = [textToShare]
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            
            present(activityVC, animated: true)
            
        }else{
            
            
            
        }
        
    }
    @IBAction func histp(_ sender: Any) {
    self.lprom.constant = 0
       self.lcoll.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func perfil(_ sender: Any) {
        self.lprom.constant = 0
           self.lcoll.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 4
        
        
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
        }else{
            
            
        }
    }
    
    func obtenermapas() {
        
        
        
        let datos_a_enviar = ["":  "" ] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass2 = JsonClass2()
        dataJsonUrlClass2.arrayFromJson(url2:"ObtenerPoligonos",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    
                    if let array = dictionary["poligonos"] as? NSArray {
                        
                        var nm = ""
                        var pv = ""
                        
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                let poligononombre =  dict.value(forKey: "pk")!
                                nm = "poligono\(poligononombre)"
                                if UserDefaults.standard.string(forKey: nm) != nil{
                                    pv = "poligonov\(poligononombre)"

                                    
                                    self.pkpoligonob.append("\(poligononombre)")
                                    let v = dict.value(forKey: "poligonO_VERSION")!
                                    let version = "\(v)"
                                    let oldvrsion = UserDefaults.standard.string(forKey: pv)!
                                    
                                    
                                    if version == oldvrsion{
                                        
                                    }else{
                                        self.defaults.set(dict.value(forKey: "poligonO_VERSION"), forKey: pv)

                                        self.actualiZAR = true
                                    }
                                }
                                else{
                                      if UserDefaults.standard.array    (forKey: "pkpoligonos") != nil{
                                   self.pkpoligono =  UserDefaults.standard.array(forKey: "pkpoligonos") as! [String]
                                    }
                                    let poligononombre =  dict.value(forKey: "pk")!
                                    nm = "poligono\(poligononombre)"
                                                                self.pkpoligono.append("\(poligononombre)")
                                    
                                    pv = "poligonov\(poligononombre)"

                                    self.defaults.set(poligononombre, forKey: nm )
                                    self.defaults.set(dict.value(forKey: "poligonO_VERSION"), forKey: pv)
                                                       
                                    self.defaults.set(self.pkpoligono, forKey: "pkpoligonos" )

                                }
                                
                            }
                        }
                        if self.actualiZAR{
                                                  
                                                  self.pkpoligono =  UserDefaults.standard.array(forKey: "pkpoligonos") as! [String]
                                                                      
                                                  
                                              }
                        let pkpoli =  UserDefaults.standard.array(forKey: "pkpoligonos") as! [String]
                        if pkpoli != self.pkpoligonob && self.pkpoligonob.count > 0{
                                            print("no es igual")
                                            self.pkpoligono = self.pkpoligonob
                                        }
                        self.obtenercoordenadas()
                      
               
                    }
                    
                    
                    
                }
                
                
                
                
                
            }
        }
        
    }
    func obtenercoordenadas(){
        if self.pkpoligono.count > 0 {
            self.defaults.set(pkpoligono, forKey: "pkpoligonos" )

            var lugares:[Any] = [ ]
            
            for i in 0...self.pkpoligono.count-1{
                let pkk = pkpoligono[i]
                
                let k = Int(pkk)
                lugares.append(
                    [
                        "PK":k
                    ]
                )
            }
            
            
            
            let datos_a_enviar = [
                "POLIGONOS":  lugares
                ] as NSMutableDictionary
            print("poligonos")
            print(datos_a_enviar)
            let dataJsonUrlClass2 = JsonClass2()
            dataJsonUrlClass2.arrayFromJson(url2:"ObtenerDetallePoligonosByPk",datos_enviados:datos_a_enviar){ (datos_recibidos) in
                DispatchQueue.main.async {//proceso principal
                    print("ok")
                    if let dictionary = datos_recibidos as? [String: Any] {
                        var p = 0
                        if  let array = dictionary["poligonos"] as? NSArray {
                            for obj in array {
                                if let dict = obj as? NSDictionary {
                       
                                    var i = 0
                                    let array2 = dict.value(forKey: "coordenadas") as! NSArray
                                    for obj2 in array2 {
                                        if let dict = obj2 as? NSDictionary {
                                            let long = dict.value(forKey: "longitud") as! String
                                            let lat = dict.value(forKey: "latitud") as! String
                                            let dlat = Double(lat)
                                            let dlong = Double(long)

                                            self.olatitud.append(dlat!)
                                            self.olongitud.append(dlong!)
                                            
                                            
                                            i = i + 1
                                            if array2.count == i{

                                                self.defaults.set(self.olatitud, forKey: "olatitud\(self.pkpoligono[p])" )

                                                self.defaults.set(self.olongitud, forKey: "olongitud\(self.pkpoligono[p])" )
                                                self.olatitud.removeAll()
                                                self.olongitud.removeAll()
                                                
                                            }
                                        }
                                    }
                                    p = p + 1
                                    
                                }
                                self.defaults.set(p, forKey: "cantidadpoli" )
                                
                            }
                        }
                    }}
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
               let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath)
               // Customize footerView here
               return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView", for: indexPath)
               // Customize headerView here
               return headerView
           }
           fatalError()
    }
}

