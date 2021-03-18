//
//  BusquedaCollectionViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 21/04/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class BusquedaCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var imagen: UIImageView!
    let defaults = UserDefaults.standard

    @IBOutlet weak var titulocaty: UILabel!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    var de = ""
    var tit = ""
    var pre = ""
    var pkprod = ""
      var img2:String!
    var img:[String] = []
     var titulo:[String] = []
     var IMAGEURL:[UIImage] = []
    var descripcion:[String] = []
    var preciop:[String] = []
    var tienda:[String] = []
    var imgtienda:[String] = []
    var pkpoligonoentrega:[Int] = []


    @IBOutlet weak var titulonab: UINavigationItem!
    var pk:[String] = []
     var horario:[String] = []
     var sipuede:[Bool] = []
     var bimg2:[String] = []


     var bimg:[UIImage] = []
     var btitulo:[String] = []
     var bhorario:[String] = []

     var bpk:[String] = []
       
    
    var pktienda:[String] = []

    var cat:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        cargador.isHidden = false
        let im = UserDefaults.standard.string(forKey: "im")!
        
        cat = UserDefaults.standard.string(forKey: "catbusqueda")!
        titulonab.title = cat
        let url = URL(string: im)
        imagen.kf.setImage(with: url)
         consulta()
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         if self.titulo.count > 0 {
             
             
             return titulo.count
             
         }else{
             return 0
             
         }
     }
     func isKeyPresentInUserDefaults(key: String) -> Bool {
         return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
     }
     
     // make a cell for each cell index path
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         
         // get a reference to our storyboard cell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! BusquedaCell

        cell.titulo.text = self.titulo[indexPath.item]
        cell.descripc.text = "Descripciòn: \(self.descripcion [indexPath.item] )"
        cell.nombretienda.text = self.tienda[indexPath.item]
        let t = self.preciop  [indexPath.item]
        let tt = Double(t)!
        let b:String = String(format:"%.2f", tt)

         cell.precio.text = "Precio: $ \(b)"
         let url = URL(string: self.img[indexPath.item])
                   cell.imgbus.kf.setImage(with: url)
               
         return cell
     }
     
     // MARK: - UICollectionViewDelegate protocol
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        self.pkprod = self.pk[indexPath.item]
        self.tit = self.titulo[indexPath.item]
        self.img2 = self.img[indexPath.item]
        
        self.pre = self.preciop[indexPath.item]
        self.de = self.descripcion[indexPath.item]
              self.defaults.set(self.tienda[indexPath.item], forKey: "nombretineda")
                self.defaults.set(self.tienda[indexPath.item], forKey: "tt")
              self.defaults.set(self.pktienda[indexPath.item], forKey: "pktienda")
           self.defaults.set(self.imgtienda[indexPath.item], forKey: "depimg")
                   self.defaults.set("promo", forKey: "promtit")
        self.defaults.set(self.pk[indexPath.item], forKey: "pkproductoagregado")
           
                   self.performSegue(withIdentifier: "detalle", sender: self)
        
  
     }
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "detalle" {
             let detalle = segue.destination as! DetalleViewController
             detalle.tituloproducto = self.tit
             detalle.img2 = self.img2
             detalle.pkproducto = self.pkprod
             detalle.prec = self.pre
             detalle.descrip = self.de
             
         }
     }
     
     
     
     func consulta(){
         
         let p = UserDefaults.standard.string(forKey: "pkcategoritatienda")!
        
        
         let datos_a_enviar = ["PK_CATEGORIA": p] as NSMutableDictionary
         
         
         //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
         let dataJsonUrlClass = JsonClass()
         dataJsonUrlClass.arrayFromJson(url2:"ProductosByCategoria",datos_enviados:datos_a_enviar){ (datos_recibidos) in
             DispatchQueue.main.async {//proceso principal

                 if let dictionary = datos_recibidos as? [String: Any] {
                     
                     if let array = dictionary["productos"] as? NSArray {
                                    

                         for obj in array {
                             
                             if let dict = obj as? NSDictionary {
                                 
                                self.pk.append(dict.value(forKey: "pk") as! String)
                              

                                 self.titulo.append(dict.value(forKey: "producto") as! String)
                                           self.descripcion.append(dict.value(forKey: "descripcion") as! String)
                                 self.img.append(dict.value(forKey: "imagen") as! String)
                                self.preciop.append(dict.value(forKey: "precio") as! String)
                                                   self.pktienda.append(dict.value(forKey: "pK_TIENDA") as! String)
                                                        self.tienda.append(dict.value(forKey: "tienda") as! String)
                           
                            self.imgtienda.append(dict.value(forKey: "imageN_TIENDA") as! String)
                                             
                                
                            }
                             
                             
                         }
                   

                        self.cargador.isHidden = true
                         self.collection.reloadData()
                     }
        
                 }
             }
             
         }
     }
     func mostrarAlerta2(title: String, message: String) {
     
         let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
             (action) in
           
             self.performSegue(withIdentifier: "godepartamentos", sender: self)

             
         }
         let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
         alertaGuia.addAction(guiaOk)
         alertaGuia.addAction(cancelar)
         present(alertaGuia, animated: true, completion: nil)

         
     }
   
 }
