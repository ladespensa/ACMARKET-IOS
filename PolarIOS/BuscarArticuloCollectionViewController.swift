//
//  BuscarArticuloCollectionViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 12/06/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit


class BuscarArticuloCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    @IBOutlet weak var carritobo: UIButton!
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    @IBOutlet weak var collecion: UICollectionView!
    
    @IBOutlet weak var titulocat: UILabel!
    
    let defaults = UserDefaults.standard
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var pkincidencia:[Any] = []
    var url:[String] = []
    var img:UIImage!
    var img2:String!
    var imgencargar:Bool = true
    var de = ""
    var tit = ""
    var pre = ""
    var pkprod = ""
    var IMAGEURL:[UIImage] = []
    var burlstring:[String] = []
    
    var burl:[UIImage] = []
    var pkp:[String] = []
    var titulo:[String] = []
    var desc:[String] = []
    var precio:[String] = []
    var bpkp:[String] = []
    var btitulo:[String] = []
    var bdesc:[String] = []
    var bprecio:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
            let   cantidadcarrito = UserDefaults.standard.integer(forKey: "cantidadcarrito")
            
            carritobo.setTitle("\(cantidadcarrito)",for: .normal)
        }
        else{
            carritobo.setTitle("\(0)",for: .normal)
        }
     
                            self.cargador.isHidden = true

        cargador.startAnimating()
        
        
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
    }
    // MARK: - UICollectionViewDataSource protocol
    
    @IBOutlet weak var collectio: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.btitulo.count > 0 {
            //            self.titulo =  UserDefaults.standard.array(forKey: "aproducto") as! [String]
            //            self.url =  UserDefaults.standard.array(forKey: "aimgproducto") as! [String]
            
            return btitulo.count
            
        }
        else{
            return 0
            
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! InicioCollectionViewCell
        
        //Use the outlet in our custom class to get a reference to the UILabel in the cell
        // cell.precio.text = (self.precio  [indexPath.item] as! String)
        cell.producto.text = (self.btitulo  [indexPath.item])
      
        let t = self.bprecio  [indexPath.item]
             let tt = Double(t)!
             let b:String = String(format:"%.2f", tt)

              cell.precio.text = "$ \(b)"
        
        let url = URL(string: self.burlstring[indexPath.item])
                  cell.imagenpromo.kf.setImage(with: url)
        
        
        
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pkprod = self.bpkp[indexPath.item]
        self.tit = self.btitulo[indexPath.item]
        self.img2 = self.burlstring[indexPath.item]
        
        self.pre = self.bprecio[indexPath.item]
        self.de = self.bdesc[indexPath.item]
        
        // handle tap events
        self.performSegue(withIdentifier: "godetalle", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "godetalle" {
            let detalle = segue.destination as! DetalleViewController
            detalle.tituloproducto = self.tit
            detalle.img2 = self.img2
            detalle.pkproducto = self.pkprod
            detalle.prec = self.pre
            detalle.descrip = self.de
            
        }
    }
    
    func consulta(search :String){
        let pktienda =  UserDefaults.standard.string(forKey: "pktienda")!
        let datos_a_enviar = ["PK_TIENDA": pktienda as Any,"PRODUCTO": search as Any] as NSMutableDictionary
        
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"ProductosByTienda/getProductosByTiendaAndNombre",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {//proceso principal
                
                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["productos"] as? NSArray {
                        
                        self.defaults.removeObject(forKey:"aproducto")
                        self.defaults.removeObject(forKey:"aimgproducto")
                        self.defaults.removeObject(forKey:"aprecio")
                                                  let imagee = UIImage.gifImageWithName("gifcargando")

                        
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                
                                self.pkp.append(dict.value(forKey: "pk") as! String)
                                self.titulo.append(dict.value(forKey: "producto") as! String)
                                self.desc.append(dict.value(forKey: "descripcion") as! String)
                                
                                self.url.append(dict.value(forKey: "imagen") as! String)
                                self.precio.append(dict.value(forKey: "precio") as! String)
                                
                                
                                self.IMAGEURL.append(imagee!)
                                
                            }
                        }
                        
                        self.btitulo = self.titulo
                        self.burlstring = self.url
                        
                        self.bdesc = self.desc
                        self.bprecio = self.precio
                        self.bpkp = self.pkp
                        self.defaults.set(self.titulo, forKey: "aproducto")
                        self.defaults.set(self.url, forKey: "aimgproducto")
                        self.defaults.set(self.precio, forKey: "aprecio")
                        
                        
                    }
                    self.collecion.reloadData()
                }
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                    self.cargador.isHidden = true

           
              
                   
                    
                    
                }
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
        return searchbar
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.pkp.removeAll()
        self.titulo.removeAll()
        self.desc.removeAll()
        self.precio.removeAll()
        self.url.removeAll()
        
        consulta(search: searchBar.text!)
        
    }
    
    
}
