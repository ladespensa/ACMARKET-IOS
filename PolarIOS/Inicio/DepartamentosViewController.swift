//
//  DepartamentosViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/28/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class DepartamentosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var imgtam: NSLayoutConstraint!
    var IMAGEURL:[String] = []
    var IMAGE:[UIImage] = []

    @IBOutlet weak var carritobo: UIButton!
    
    @IBOutlet weak var nombrecategoria: UILabel!
    @IBOutlet weak var nabvar: UINavigationItem!
    @IBOutlet weak var carrito: UILabel!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell"
    
    @IBOutlet weak var imgtienda: UIImageView!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    
    var deppk:[String] = []
    var depnombre:[String] = []
    var depimg:[String] = []
    var beppk:[String] = []
    var bdepnombre:[String] = []
    var bdepimg:[String] = []
    var imgvista:Bool = true
    var pk:String = ""
    var t:String = ""
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
            return searchbar
            
            
        }
    
    
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.beppk.removeAll()
            self.bdepnombre.removeAll()
            self.bdepimg.removeAll()
    var i = 0
            for item in self.depnombre {
                
                if (item.lowercased().contains(searchBar.text!.lowercased())) {
                    
                    self.bdepnombre.append(item)
                    self.bdepimg.append(self.IMAGEURL[i])
                    self.beppk.append(self.deppk[i])

                }
                i = i + 1
            }
                
            if (searchBar.text!.isEmpty) {
                self.beppk = self.deppk
                self.bdepnombre = self.depnombre
                self.bdepimg = self.IMAGEURL

            }
            self.collection.reloadData()
        }
    
    func mostrarAlerta2(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Regresar", style: .default) {
            (action) in
            self.defaults.removeObject(forKey:"pkproductoagregado")
            self.defaults.removeObject(forKey:"cantidadproductoagregado")
            self.defaults.removeObject(forKey:"cantidadcarrito")
            self.defaults.removeObject(forKey:"comentarioproducto")
                    let promo = UserDefaults.standard.string(forKey: "promtit")!
            if promo == "promo"{
                self.performSegue(withIdentifier: "goprincipio", sender: self)
            }else{
                
            
            self.performSegue(withIdentifier: "goinicio", sender: self)

            }
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alertaGuia.addAction(guiaOk)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)

        
    }
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(true, animated: false)
        consulta()
pantalla()
          
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
                 self.imgtam.constant = 120
                 print("IPHONE XR")
             case 2688:
                 self.imgtam.constant = 150
                 print("IPHONE XS MAX")
             default:
                 self.imgtam.constant = 150
                 print("cualquier otro tamaño")
             }
             
         }
         else{
             self.imgtam.constant = 250

             
         }
     }
    @IBAction func goinicio(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goinicio", sender: self)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults.set("", forKey: "descuentoseleccionado")

        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
                 let   cantidadcarrito = UserDefaults.standard.integer(forKey: "cantidadcarrito")
                 
                 carritobo.setTitle("\(cantidadcarrito)",for: .normal)
             }
             else{
                   carritobo.setTitle("\(0)",for: .normal)
             }
        
        cargador.startAnimating()
        let imgt = UserDefaults.standard.string(forKey: "depimg")!
        if let url = NSURL(string: imgt ){
                  if let data = NSData(contentsOf: url as URL){
                    self.imgtienda.image = UIImage(data: data as Data)
                      
                  }}
  
        self.imgtienda.layer.shadowColor = UIColor.black.cgColor
        self.imgtienda.layer.shadowRadius = 6.0
        self.imgtienda.layer.shadowOpacity = 0.6
        self.imgtienda.layer.cornerRadius = 15.0
        self.imgtienda.layer.cornerRadius = 15.0
        self.imgtienda.layer.borderWidth = 5.0
        self.imgtienda.layer.borderColor = UIColor.clear.cgColor
        self.imgtienda.layer.masksToBounds = true
        self.defaults.set(0, forKey: "temp")
      var tiend = ""
        let cattienda = UserDefaults.standard.string(forKey: "nombretineda")!
         nabvar.title = cattienda
        tiend = "\(cattienda)-Categorias"
        nombrecategoria.text = tiend

    }
  
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        let tempo:Bool = UserDefaults.standard.string(forKey: key) != nil
        print(tempo)
        return tempo
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if beppk.count > 0 {
            return beppk.count
            
            
        }else{
            return 0
        }
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DepartamentosCell
                                        
        
    let url = URL(string: self.bdepimg[indexPath.item])
        
        cell.imagen.kf.setImage(with: url)

        cell.texto.text = self.bdepnombre[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  pkt = beppk[indexPath.item]
        
      //  let  nombretineda = bdepnombre[indexPath.item]
       // self.defaults.set(nombretineda, forKey: "nombretineda")
        let  nom = bdepnombre[indexPath.item]
           self.defaults.set(nom, forKey: "dd")
        self.defaults.set(pkt, forKey: "tpkcategoria")
        
        
        self.performSegue(withIdentifier: "goproductos", sender: self)
        
    }
    
    func consulta(){
        
        let pkt = UserDefaults.standard.integer(forKey: "tpktienda")
        
        let datos_a_enviar = ["PK_TIPO_TIENDA": pkt] as NSMutableDictionary
        
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"ObtenerCategoriasByPkTipo",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {//proceso principal

                if let dictionary = datos_recibidos as? [String: Any] {
                               let imagee = UIImage.gifImageWithName("gifcargando")

                                           
                    if let array = dictionary["categorias"] as? NSArray {

                        for obj in array {
                            
                            if let dict = obj as? NSDictionary {
                                self.deppk.append(dict.value(forKey: "pk") as! String)
                                
                                self.depnombre.append(dict.value(forKey: "clasificacion") as! String)
                                self.IMAGEURL.append(dict.value(forKey: "imagen") as! String)
                       self.IMAGE.append(imagee!)
                            }
                            
                            
                        }
                        self.beppk = self.deppk
                                     self.bdepnombre = self.depnombre
                                     self.bdepimg = self.IMAGEURL
                            self.cargador.isHidden = true

                        self.collection.reloadData()
                    }
                    
        
                  
                }
            }
            
        }
    }
    
    
}






