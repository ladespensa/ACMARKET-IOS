//
//  ListadestinosCollectionViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 22/04/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class ListadestinosCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let defaults = UserDefaults.standard
    var lugares:[Any]!
    var latitud:[Any]!
    var longitud:[Any]!
    var primero:Bool = true
    var donde:Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       if   UserDefaults.standard.array(forKey: "misdirecciones") != nil {
        lugares = UserDefaults.standard.array(forKey: "misdirecciones")!
        latitud = UserDefaults.standard.array(forKey: "mislatitudes")!
        longitud  = UserDefaults.standard.array(forKey: "mislongitudes")!
        }
        
                // Do any additional setup after loading the view, typically from a nib.
                txtSearch.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
                tblPlaces.estimatedRowHeight = 44.0
                tblPlaces.dataSource = self
                tblPlaces.delegate = self
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
         return UserDefaults.standard.string(forKey: key) != nil || UserDefaults.standard.string(forKey: key) != ""
     }
@IBOutlet weak var tblPlaces: UITableView!
@IBOutlet weak var txtSearch: UITextField!
var placetemp = ""
var resultsArray:[Dictionary<String, AnyObject>] = Array()
override func viewDidLoad() {
    super.viewDidLoad()

    
      }
      
      //MARK:- UITableViewDataSource and UItableViewDelegates
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if primero{
          
            if lugares.count > 0{
            return lugares.count
            }else{
                if self.txtSearch.text != ""{
                              return resultsArray.count
                }else{
                return 0
                }
            }
        }else{

            return resultsArray.count
        }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "placecell")
          if let lblPlaceName = cell?.contentView.viewWithTag(102) as? UILabel {
            if indexPath.row >= 0 && indexPath.row < resultsArray.count {
           donde  = false
              let place = self.resultsArray[indexPath.row]
              lblPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
            }else{
                primero = false
                donde = true
                lblPlaceName.text = (lugares[indexPath.item] as! String)
            }
            
        }
        return cell!
      }
      
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
      
    
    @IBAction func continuar(_ sender: Any) {
        defaults.set(true, forKey: "ubicacion")
         self.performSegue(withIdentifier: "gomapa", sender: self)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if donde{
            defaults.set(latitud[indexPath.item], forKey: "latitud")
                             defaults.set(longitud[indexPath.item], forKey: "longitud")
            defaults.set(lugares[indexPath.item], forKey: "placesalida")
                             defaults.set(false, forKey: "ubicacion")
            self.performSegue(withIdentifier: "gomapa", sender: self)

        }else{
          tableView.deselectRow(at: indexPath, animated: true)
          let place = self.resultsArray[indexPath.row]
          if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
              if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                  if let latitude = location["lat"] as? Double {
                      if let longitude = location["lng"] as? Double {
                                    
                        defaults.set(latitude, forKey: "latitud")
                        defaults.set(longitude, forKey: "longitud")
                        defaults.set(place["name"], forKey: "placesalida")
                        defaults.set(false, forKey: "ubicacion")

                       self.performSegue(withIdentifier: "gomapa", sender: self)

                      }
                  }
              }
          }
        }
      }


      
     @objc func searchPlaceFromGoogle(_ textField:UITextField) {
      
      if let searchQuery = textField.text {
          var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key=AIzaSyDHbtaNdd8CjgHXhLetYIcFbFAG0IXjwCI"
          strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
          
          var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
          urlRequest.httpMethod = "GET"
          let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
              
            if error == nil {
                do{
                DispatchQueue.main.async {
    
                  if let responseData = data {
                  let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                      
                      if let dict = jsonDict as? Dictionary<String, AnyObject>{
                          
                          if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                              print("json == \(results)")
                              self.resultsArray.removeAll()
                           
                              for dct in results {
                                  self.resultsArray.append(dct)
                          
                              }
                                                                    


                               self.tblPlaces.reloadData()
                              }
                              
                          }
                      }
                     
                  }
              
            } catch {
                self.mostrarAlerta2(title: "se perdio la conexion", message: "intente mas tarde")
               }
            
            }   else {
print("error")
                
            }
                
          }
          task.resume()
      }
      }
      
      
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
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

