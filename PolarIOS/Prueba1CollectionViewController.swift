//
//  Prueba1CollectionViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 03/05/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit



class Prueba1CollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "Cell"

    let defaults = UserDefaults.standard
    var menuVisible = false
    
    var pk:[Any] = []
    var grupo:[Any] = []
    var clasificacion:[Any] = []
    var imagen:[Any] = []

    var bpkcat:[Int] = []
    var bpk:[Any] = []
      var bgrupo:[Any] = []
      var bclasificacion:[Any] = []
      var bimagen:[Any] = []
    

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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    @IBAction func regresarinicio(_ sender: Any) {
        mostrarAlerta2(title: "Si regresas se  limpiara tu carrito", message: "")

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
    func obtenerincidencias() {
        
        
        
        let datos_a_enviar = ["":  "" ] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"CategoriasList",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            
            DispatchQueue.main.async {//proceso principal
                self.ta = ""
                if let dictionary = datos_recibidos as? [String: Any] {
                    if let array = dictionary["categorias"] as? NSArray {
    var i = 1
                        var g = ""
        var ga = ""
                        var tembool = false
                        for obj in array {
                            if let dict = obj as? NSDictionary {
                                g = dict.value(forKey: "grupo") as! String


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

                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        
    }
}
