//
//  TiendasViewController.swift
//  Polar
//
//  Created by Oscar San juan on 3/28/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class TiendasViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var carritobo: UIButton!
    
    var ppk:[String] = []
    var pprecio:[Any] = []
    var pdes:[String] = []
    var dimg:[String] = []
    var dpk:[String] = []
    var dtitulo:[String] = []
    var pK_TIENDA:[String] = []
    var pimg:[String] = []
    var ptitulo:[String] = []
    var pnombre:[String] = []
    var pK_TIENDAs = ""
    var img2:UIImage!
    var img22:String!
    var scrollingTimer = Timer()
      var de = ""
      var tit = ""
      var pre = ""
      var pkprod = ""
      var pkt:String = ""
      var t:String = ""
    var pkpoligono:[String] = []
    var pkpoligonob:[String] = []
    @IBOutlet weak var categoriatienda: UILabel!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell"
    var imgencargar:Bool = true

    var img:[String] = []
    var titulo:[String] = []
    var IMAGEURL:[UIImage] = []

    var pk:[String] = []
    var horario:[String] = []
    var sipuede:[Bool] = []
    var bimg2:[String] = []
    var pproducto:[String] = []

    var IMAGEURL2:[UIImage] = []

    var bimg:[UIImage] = []
    var btitulo:[String] = []
    var bhorario:[String] = []

    @IBOutlet weak var btn: UIButton!
    var bpk:[String] = []

    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var deppk:[Any] = []
    var depnombre:[Any] = []
    var depimg:[Any] = []
    
    var pkcategoria:String = ""
    
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet weak var collection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchbar
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.bpk.removeAll()
        self.btitulo.removeAll()
        self.bimg2.removeAll()
        self.bhorario.removeAll()

var i = 0
        for item in self.titulo {
            
            if (item.lowercased().contains(searchBar.text!.lowercased())) {
                
                self.btitulo.append(item)
                self.bimg2.append(self.img[i])
                self.bpk.append(self.pk[i])
                self.bhorario.append(self.horario[i])

            }
            i = i + 1
        }
            
        if (searchBar.text!.isEmpty) {
            self.bpk = self.pk
            self.btitulo = self.titulo
            self.bimg2 = self.img
            self.bhorario = self.horario

        }
        self.collection.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  navigationController?.setNavigationBarHidden(true, animated: false)
        btn.layer.cornerRadius = 10

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       cargador.startAnimating()
        self.defaults.set("", forKey: "descuentoseleccionado")

        if isKeyPresentInUserDefaults(key: "cantidadcarrito"){
                        let   cantidadcarrito = UserDefaults.standard.integer(forKey: "cantidadcarrito")
                        
                        carritobo.setTitle("\(cantidadcarrito)",for: .normal)
                    }
                    else{
                          carritobo.setTitle("\(0)",for: .normal)
                    }
        categoriatienda.text = UserDefaults.standard.string(forKey: "categoriatienda")
        self.view.addSubview(collection)
               self.view.addSubview(collection2)
               collection.dataSource = self
                           collection2.dataSource = self
               collection.delegate = self
                        collection2.delegate = self
                   

        
        consulta()
        startTimer()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               if collectionView == self.collection {
        if self.btitulo.count > 0 {
            
            
            return btitulo.count
            
        }else{
            return 0
            
        }
               } else{
                    if self.ptitulo.count > 0 {
                              
                              
                              return ptitulo.count
                              
                          }else{
                              return 0
                              
                              
                          }

                }
    }



    @IBAction func Buscararticulo(_ sender: Any) {
        
            self.performSegue(withIdentifier: "buscararticulos", sender: self)
        
    }
    
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.collection {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TiendasCell

                //cell.horari.text = "Horario: \(self.bhorario  [indexPath.item] )"
     
        let url = URL(string: self.bimg2[indexPath.item])
                  cell.imagen.kf.setImage(with: url)
              
    
        
   
        return cell
        }
            
        else{
            // get a reference to our storyboard cell
                         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath as IndexPath) as! PromoCell
                         
                         let url = URL(string: self.pimg[indexPath.item])
                         cell.imgpromo.kf.setImage(with: url)
                         var rowIndex = indexPath.row
                                      let numberOfRecords:Int = self.pimg.count-1
                                      if(rowIndex < numberOfRecords){
                                          rowIndex = (rowIndex + 1)
                                      }
                                      else{
                                          rowIndex = 0
                                      }
                         //  cell.titulo.text = (self.ptitulo  [indexPath.item] )
                         //cell.descripcion.text = (self.pdes  [indexPath.item] )
                          //   scrollingTimer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(TiendasViewController.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
                         return cell

        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    //@objc func startTimer(theTimer:Timer){

      //  UIView.animate(withDuration: 30.0, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
        //    self.collection2.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: false)
       // }, completion: nil)
   // }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              if collectionView == self.collection {
        self.defaults.set(self.bimg2[indexPath.item], forKey: "depimg")
        self.defaults.set(self.bpk, forKey: "deppk")
        self.defaults.set(self.btitulo, forKey: "depnombre")
        let dato = indexPath.item
        let  pkt = bpk[dato]
        let  nom = btitulo[dato]
        self.defaults.set(nom, forKey: "tt")

        self.defaults.set(pkt, forKey: "tpktienda")
      //  let horarioo = self.horario[indexPath.item]
        self.defaults.set(nom, forKey: "nombretineda")
        //let si = self.sipuede[indexPath.item]
        //print(si)
//        if si == false {
//          //  mostrarAlerta2(title: "Este establecimiento ya està cerrado", message: "Realiza tu pedido en el horario: \(horarioo) horas")
//
//        }
//        else{
//
        
        self.performSegue(withIdentifier: "godepartamentos", sender: self)
     //   }
        }
              else{
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
       
        
    }
    
    
    
    func consulta(){
        
        let pkt = UserDefaults.standard.string(forKey: "pktienda")!
        
        let datos_a_enviar = ["PK": pkt] as NSMutableDictionary
        
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = JsonClass()
        dataJsonUrlClass.arrayFromJson(url2:"ObtenerTiposTiendasByPkTienda",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {//proceso principal

                if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["tipos"] as? NSArray {
                                      let imagee = UIImage.gifImageWithName("gifcargando")

                        for obj in array {
                            
                            if let dict = obj as? NSDictionary {
                              self.pk.append(dict.value(forKey: "pk") as! String)
//                                let hor = dict.value(forKey: "apertura")!
//                                let min = dict.value(forKey: "cierre")!
//                                self.horario.append("\(hor)-\(min)")
                               // print ((dict.value(forKey: "abierto") as! Bool))
                               // self.sipuede.append((dict.value(forKey: "abierto") as! Bool))

                                self.titulo.append(dict.value(forKey: "tipo") as! String)
                                self.img.append(dict.value(forKey: "imagen") as! String)
                            
                        self.IMAGEURL.append(imagee!)
                                                  
                            }
                            
                            
                        }
                        self.bpk = self.pk
                                self.btitulo = self.titulo
                        self.bimg2 = self.img
                        self.bhorario = self.horario

                        self.cargador.isHidden = true

                        self.collection.reloadData()
                    }
                    if  let array2 = dictionary["promos"] as? NSArray {
                                          
                                          for obj2 in array2 {
                                              if let dict = obj2 as? NSDictionary {
                                                  self.ppk.append(dict.value(forKey: "pK_TIPO_TIENDA") as! String)
                                                  self.pdes.append(dict.value(forKey: "descripcion") as! String)
                                                  self.ptitulo.append(dict.value(forKey: "producto") as! String)
                                                  self.pimg.append(dict.value(forKey: "imagen") as! String)
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
                    self.collection2.reloadData()
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
    @IBAction func regresarinicio(_ sender: Any) {
          mostrarAlerta(title: "Si regresas se  limpiara tu carrito", message: "")

      }
      func mostrarAlerta(title: String, message: String) {
          let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let guiaOk = UIAlertAction(title: "Regresar", style: .default) {
              (action) in
              self.defaults.removeObject(forKey:"pkproductoagregado")
              self.defaults.removeObject(forKey:"cantidadproductoagregado")
              self.defaults.removeObject(forKey:"cantidadcarrito")
              self.defaults.removeObject(forKey:"comentarioproducto")
               
              
                  
              
              self.performSegue(withIdentifier: "goinicio", sender: self)

              
          }
          let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
          alertaGuia.addAction(guiaOk)
          alertaGuia.addAction(cancelar)
          present(alertaGuia, animated: true, completion: nil)

          
      }
}
