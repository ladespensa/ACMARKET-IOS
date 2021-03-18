//
//  PasadosViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/13/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class PasadosViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var traling: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var menuVisible = false
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var pk:[Any] = []
    var grupo:[Any] = []
    var clasificacion:[Any] = []
    var imagen:[Any] = []

    var bpkcat:[Int] = []
    var bpk:[Any] = []
      var bgrupo:[Any] = []
      var bclasificacion:[Any] = []
      var bimagen:[Any] = []
    var ide:String = ""


      var pkcat:[Int] = []
  
    var nombtipo:[Any] = []
    var pktipo:[Any] = []
    var bnombtipo:[Any] = []
    var bpktipo:[Any] = []
    
    var ta:String = ""
    var t:String = ""
    var metp:String = ""
    var comt:String = ""
    var subtot:String = ""
    var tar:String = ""

    @IBOutlet weak var imagenusuario: UIImageView!
    @IBOutlet weak var nombreuser: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.bpk.count > 0 {
            
            
            return bpk.count
            
        }else{
            return 0
            
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
    }
    
    @IBAction func salir(_ sender: Any) {
        self.defaults.removeObject(forKey: "pkuser")
        self.defaults.removeObject( forKey: "telefono")
        self.defaults.removeObject( forKey: "nombre")
        self.defaults.removeObject(forKey: "apellidos")
        self.defaults.removeObject( forKey: "latitud")
        self.defaults.removeObject(forKey: "longitud")
        self.performSegue(withIdentifier: "inicio", sender: self)
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
              // get a reference to our storyboard cell
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PasadosCell
               cell.tienda.text = self.bclasificacion[indexPath.item] as? String
               let t = indexPath.item
               if t == 0{
                   cell.TITULO.text = (self.bgrupo[indexPath.item] as! String)

               }
           let temp =  self.bgrupo[indexPath.item] as? String
                  if temp != self.ta{
                      self.ta = temp!
                      cell.TITULO.text = (self.bgrupo[indexPath.item] as! String)
                  }
                  else{
                      cell.TITULO.text = ""
                      self.ta = temp!

                  }
    if bpk[indexPath.item] as! String == "0"{
            cell.backg.isHidden = true
        }
               
              let url = URL(string: self.bimagen[indexPath.item] as! String)
                        cell.imagentienda.kf.setImage(with: url)
                        

              return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if pk[indexPath.item] as! String == "0"{
            
        }else{
            self.defaults.set(bpk[indexPath.item], forKey: "pkcategoritatienda")
                     self.defaults.set(bpk[indexPath.item], forKey: "tpkcategoria")
                 self.defaults.set(bpk[indexPath.item], forKey: "dd")
           let t = self.bclasificacion[indexPath.item] as! String
            self.defaults.set(t, forKey: "catbusqueda")
            self.defaults.set(self.bimagen[indexPath.item], forKey: "im")
            self.defaults.set(self.bnombtipo[indexPath.item], forKey: "dd")
            self.defaults.set(self.bpktipo[indexPath.item], forKey: "tpktienda")
            self.performSegue(withIdentifier: "detalleproducto", sender: self)

        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      
      
    }
    func obtenerincidencias() {
        
        
        
        let datos_a_enviar = ["":  "" ] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"CategoriasList",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                self.ta = ""
                self.cargador.isHidden = true
                if let dictionary = datos_recibidos as? [String: Any] {
                    if let array = dictionary["categorias"] as? NSArray {
    var i = 1
                        var g = ""
        var ga = ""
                        var tembool = false
                        
                        self.bgrupo.removeAll()
                              self.bpk.removeAll()
                              self.bclasificacion.removeAll()
                              self.bimagen.removeAll()
                              self.bpkcat.removeAll()
                              self.bnombtipo.removeAll()
                                   self.bpktipo.removeAll()
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                g = dict.value(forKey: "grupo") as! String

                                if tembool{
                                    print(dict.value(forKey: "clasificacion") as! String)
  if i % 2 == 0   {
    
                                                           if g != ga {
                                                          
                                                                print(dict.value(forKey: "clasificacion") as! String)
                                                                print(i)
                                                                self.grupo.append(ga)
                                                            i = i+1
                                                                 self.pk.append("0")
                                                                 self.clasificacion.append("")
                                                                 self.imagen.append("")
                                                            self.nombtipo.append("")
                                                            self.pkcat.append(0)
                                                            self.pktipo.append(0)

                                                            }
                                                            
                                                            }
                                
                                }
                                tembool = true

                                self.grupo.append(dict.value(forKey: "grupo") as! String)
                           self.nombtipo.append(dict.value(forKey: "tipo") as! String)

                                self.pktipo.append(dict.value(forKey: "pK_GRUPO") as! Int)

                                self.pk.append(dict.value(forKey: "pk") as! String)
                                self.clasificacion.append(dict.value(forKey: "clasificacion") as! String)
                                self.imagen.append(dict.value(forKey: "imagen") as! String)
                                       self.pkcat.append(dict.value(forKey: "pK_GRUPO") as! Int)
                                ga = dict.value(forKey: "grupo") as! String

                              
                                i = i + 1
                                
                                
                            }
                        

                        }
                        self.bnombtipo = self.nombtipo
                        self.bpktipo = self.pktipo
                        self.bgrupo = self.grupo
                                                self.bpk = self.pk
                                                self.bclasificacion = self.clasificacion
                                                self.bimagen = self.imagen
                                                self.bpkcat = self.pkcat
                        self.collection.reloadData()

                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        
    }
    
    @IBAction func go(_ sender: Any) {
        if !menuVisible {
            leading.constant = 250
            menuVisible = true
        } else {
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
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 4
        
    }
    
    @IBAction func pedidos(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 1
        
        
    }
    
    
    @IBAction func notificaciones(_ sender: Any) {
    }
    
    
    
    @IBAction func pednu(_ sender: Any) {
        leading.constant = 0
             traling.constant = 0
             menuVisible = false
             self.tabBarController?.selectedIndex = 2
             
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
    
    @IBAction func ayuda(_ sender: Any) {
        leading.constant = 0
        traling.constant = 0
        menuVisible = false
        self.tabBarController?.selectedIndex = 3
        
    }
    
    
    @IBAction func cerrar(_ sender: Any) {
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
        override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
            leading.constant = 0
            traling.constant = 0
    tabBarController?.hidesBottomBarWhenPushed = false
            cargador.startAnimating()
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
                   }
                   self.grupo.removeAll()
                         self.pk.removeAll()
                         self.clasificacion.removeAll()
                         self.imagen.removeAll()
                         self.pkcat.removeAll()
                         self.nombtipo.removeAll()
                              self.pktipo.removeAll()
                   
                   obtenerincidencias()
          }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
           return searchbar
           
           
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.ta = ""
           self.bgrupo.removeAll()
           self.bpk.removeAll()
           self.bclasificacion.removeAll()
           self.bimagen.removeAll()
           self.bpkcat.removeAll()
           self.bnombtipo.removeAll()
                self.bpktipo.removeAll()
           var i = 0
        var t = ""
        var ta = ""
        var b = 1
        for item in self.clasificacion {
               
            if ((item as AnyObject).lowercased.contains(searchBar.text!.lowercased())) {
             t = self.grupo[i]  as! String
                 if t != ta {
                if b % 2 == 0   {
                
                    b = b + 1
                             self.bimagen.append("")
                                  
                                  self.bclasificacion.append("")
                                  self.bpk.append("0")
                                  self.bgrupo.append("")
                                self.bpkcat.append(0)
                           
                           self.bpktipo.append("0")
                                         self.bnombtipo.append("")
                    }
                
                }
                   self.bimagen.append(self.imagen[i] )
                   
                   self.bclasificacion.append(item)
                   self.bpk.append(self.pk[i])
                   self.bgrupo.append(self.grupo[i])
                 self.bpkcat.append(self.pkcat[i])
            
            self.bpktipo.append(self.pktipo[i])
                          self.bnombtipo.append(self.nombtipo[i])
                ta = self.grupo[i] as! String
                b = b + 1

            }
            i = i + 1
           }
           
           if (searchBar.text!.isEmpty) {
               self.bgrupo = self.grupo
                                   self.bpk = self.pk
                                   self.bclasificacion = self.clasificacion
                                   self.bimagen = self.imagen
                                   self.bpkcat = self.pkcat
            self.pktipo = self.bpktipo
                                       self.bnombtipo = self.nombtipo
               
           }
           self.collection.reloadData()
       }
       
       
}

