
import MapKit
import CoreLocation
import UIKit
import UserNotifications


class CoordenadasViewController: UIViewController{
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var acept: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var address: UILabel!
    var lugarentrega = ""
    var oolatitud:[Double] = []
    var oolongitud:[Double] = []
    var cantidadarreglos:[Int] = []
    var primero:Bool = true
    var olatitud:[Double] = []
    var olongitud:[Double] = []
    var cantidad = 0
    var latitud:Double = 19.4147
    var longitud:Double =  -98.1423
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation:CLLocation?
    var di:String = ""
    var primera:Bool = false
    var pkusuario:String = ""
    var geofencesLabel: UILabel!
    var adentro:Bool = false
    var result = ""
    var miubicacion = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
     mapView.delegate = self
      mapView.showsUserLocation = true;
         self.miubicacion = UserDefaults.standard.bool(forKey: "ubicacion")
                         if miubicacion == false{
                          self.latitud =  UserDefaults.standard.double(forKey: "latitud")
                          self.longitud =  UserDefaults.standard.double(forKey: "longitud")
                          self.di =  UserDefaults.standard.string(forKey: "placesalida")!
                      
                         }
             obtenerarreglos()
                   
                   
                   
                   setupMap()
             
         
             pkusuario = UserDefaults.standard.string(forKey: "pkuser")!
             acept.layer.cornerRadius = 10
             locationManager.delegate = self
             locationManager.requestAlwaysAuthorization()
             locationManager.requestWhenInUseAuthorization()
             locationManager.desiredAccuracy = kCLLocationAccuracyBest
             locationManager.startUpdatingLocation()
    }
    func buscarcordenada(){
                 
                 let geocoder = CLGeocoder()
        
                 geocoder.geocodeAddressString(di) { (places:[CLPlacemark]?, error:Error?) in
                     if error == nil {
                         
                         let place = places?.first
                         let anotacion = MKPointAnnotation()
                         anotacion.coordinate = (place?.location?.coordinate)!
                         
                         let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                         let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                         self.mapView.setRegion(region, animated: true)
                         self.latitud = anotacion.coordinate.latitude as Double
                         self.longitud = anotacion.coordinate.longitude as Double
                         print(self.latitud)
                    

                      
                     }else{
                         print("error al encontrar direccion")
                     }
                 }
    }
 
    func obtenerarreglos(){
   
        let pktienda =  UserDefaults.standard.string(forKey: "pktienda")!

        let pkpoligonotienda =  UserDefaults.standard.array(forKey: "pkpoligonoentrega\(pktienda)")!

        let cantidad = pkpoligonotienda.count
        var p = 0
        for index in 0...cantidad-1 {
           let al = pkpoligonotienda[index]
            let a = "\(al)"
            for cantidadpol in 0...pkpoligonotienda.count-1{
               print(cantidadpol)
                let aa = pkpoligonotienda[cantidadpol] as! Int
                let aaa = "\(aa)"
                if  aaa == a{
            let l = "olatitud\(a)"
            let ll = "olongitud\(a)"
            let lon =  UserDefaults.standard.array(forKey: ll)!
            let lat =  UserDefaults.standard.array(forKey: l)!
            var i = 0
            var api: [CLLocationCoordinate2D] = []
            for obj in 0...lat.count-1 {
                let long2 = "\(lon[obj])"
                let lat2 = "\(lat[obj])"
                let dlong = Double(long2)
                let dlat = Double(lat2)
                self.olatitud.append(dlat!)
                self.olongitud.append(dlong!)
                api.append(CLLocationCoordinate2D.init(latitude: dlat!, longitude: dlong!))
                let d = lat.count-1
                if d == i {
                    let apipoli = MKPolygon.init(coordinates: api, count: i)

                    self.mapView.addOverlays([apipoli])
                
                 
                          self.oolatitud.insert(contentsOf: self.olatitud, at: p)
                                               self.oolongitud.insert(contentsOf: self.olongitud, at: p)

                                      self.olatitud.removeAll()
                                      self.olongitud.removeAll()
            }
                i = i + 1

            }
            self.cantidadarreglos.append(i)
            p = p + 1
        }
        }
        self.cantidad = p
        }
    }



@IBAction func locati(_ sender: Any) {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    
    
    
    
    checkLocationServices()
    
}

func setupLocationManager() {
    locationManager.delegate = self as CLLocationManagerDelegate
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
}


func centerViewOnUserLocation() {
    if let location = locationManager.location?.coordinate {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

func checkLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
        setupLocationManager()
        checkLocationAuthorization()
        setupData(lat: latitud, long: longitud)
    } else {
        // Show alert letting the user know they have to turn this on.
    }
}
func mostrarAlerta2(title: String, message: String) {
    
    let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
        (action) in
        //self.startTackingUserLocation()
        
    }
    alertaGuia.addAction(guiaOk)
    present(alertaGuia, animated: true, completion: nil)
}
func mostrarAlerta3(title: String, message: String) {
    
    let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
        (action) in
        
    }
    alertaGuia.addAction(guiaOk)
    present(alertaGuia, animated: true, completion: nil)
}

func checkLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
        if miubicacion{
        startTackingUserLocation()
        }else{
            self.getAddressFromLatLon()

        }
        miubicacion = true

    case .denied:
        // Show alert instructing them how to turn on permissions
        mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "Entra a configuraciòn/acmarket y activa la ubicaciòn")
        
        break
    case .notDetermined:
        mostrarAlerta2(title: "Debes activar el permiso de ubicaciòn", message: "")
        
    case .restricted:
        // Show an alert letting them know what's up
        print ("error")
        break
    case .authorizedAlways:
        if miubicacion{
        startTackingUserLocation()
        }else{
            self.getAddressFromLatLon()

        }
        miubicacion = true

        break
        
    @unknown default:
        locationManager.requestAlwaysAuthorization()
    }
}

func startTackingUserLocation(){
    mapView.showsUserLocation = true
    centerViewOnUserLocation()
    locationManager.startUpdatingLocation()
    previousLocation = getCenterLocation(for: mapView)
}

func getCenterLocation(for  mapView: MKMapView) -> CLLocation{
    if primero == false
    {
    primero = true
    self.latitud =   mapView.centerCoordinate.latitude
    self.longitud = mapView.centerCoordinate.longitude
    print(latitud)
    print(longitud)
    }
    if miubicacion
    {
    primero = true
    self.latitud =   mapView.centerCoordinate.latitude
    self.longitud = mapView.centerCoordinate.longitude
    print(latitud)
    print(longitud)
    }
    return CLLocation(latitude: latitud, longitude: longitud)
}
    func mostrarAlerta33(title: String, message: String) {
        
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
            let datos = UserDefaults.standard.string(forKey: "formadepago")
                           if datos == "Efectivo" || datos == "Terminal"{
                            self.adentro = false
                               
                            self.performSegue(withIdentifier: "goefectivo", sender:self)
                               
                           }else{
                            self.adentro = false
                               
                            self.performSegue(withIdentifier: "gocontinuar", sender: self)
                               
                           }
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
               alertaGuia.addAction(guiaOk)
               alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
    }
@IBAction func continuar(_ sender: Any) {
    setupData(lat: latitud, long: longitud)
 

    if adentro {
        pkusuario = UserDefaults.standard.string(forKey: "pkuser")!


        if pkusuario != "0"{
       let pktienda =  UserDefaults.standard.string(forKey: "pktienda")!

       let pkco =  UserDefaults.standard.array(forKey: "2pkpoligonoentrega\(pktienda)")!
            
            var dayOfTheWeekString = ""
            let pktarifa =  UserDefaults.standard.string(forKey: "pk_tarifa")!
            var day=""
            var day2=""

       var fecha=""
                               if "\(pkco[0])" == self.lugarentrega{
                                   day="Lunes"
                                day2="Martes"

                                 dayOfTheWeekString = UserDefaults.standard.string(forKey: "Monday\(pktienda)")!
                                   fecha = dayOfTheWeekString.replacingOccurrences(of: "lunes", with: "")

            }
                                   if "\(pkco[1])" == self.lugarentrega{
                                   day="Martes"
                                    day2="Miercoles"

                                       dayOfTheWeekString = UserDefaults.standard.string(forKey: "Tuesday\(pktienda)")!
                                       fecha = dayOfTheWeekString.replacingOccurrences(of: "martes", with: "")

                                     }
                               if "\(pkco[2])" == self.lugarentrega{
                                   day="Miercoles"
                                day2="Jueves"

                                   dayOfTheWeekString = UserDefaults.standard.string(forKey: "Wednesday\(pktienda)")!
                                     fecha = dayOfTheWeekString.replacingOccurrences(of: "miercoles", with: "")

                                   }
                               if "\(pkco[3])" == self.lugarentrega{
                                   day="Jueves"
                                day2="Viernes"

                                   dayOfTheWeekString = UserDefaults.standard.string(forKey: "Thursday\(pktienda)")!
                                  fecha = dayOfTheWeekString.replacingOccurrences(of: "jueves", with: "")

                                   }
                               if "\(pkco[4])" == self.lugarentrega{
                                   day="Viernes"
                                day2="Sabado"

                                   dayOfTheWeekString = UserDefaults.standard.string(forKey: "Friday\(pktienda)")!
                                   fecha = dayOfTheWeekString.replacingOccurrences(of: "viernes", with: "")

                                   }
                               if "\(pkco[5])" == self.lugarentrega{
                                   day="Sabado"
                                day2="Domingo"

                                   dayOfTheWeekString = UserDefaults.standard.string(forKey: "Saturday\(pktienda)")!
                                   fecha = dayOfTheWeekString.replacingOccurrences(of: "sabado", with: "")

                                   }
                               if "\(pkco[6])" == self.lugarentrega{
                                   day="Domingo"
                                day2="Lunes"

                                   dayOfTheWeekString = UserDefaults.standard.string(forKey: "Sunday\(pktienda)")!
                                   fecha = dayOfTheWeekString.replacingOccurrences(of: "domingo", with: "")

                                     }

          
            
            
                let fechaentrega = dayOfTheWeekString
       let fechaentregaex = UserDefaults.standard.string(forKey: "express\(pktienda)")!

            print(fechaentrega)
            let t = self.address.text!
            print(t)
            
            
            if t.count > 2{
                
                self.defaults.set(t, forKey: "direccion")
                
                
                
                self.defaults.set(latitud, forKey: "latitud")
                self.defaults.set(longitud, forKey: "longitud")
               if pktarifa == "2"{
                self.defaults.set(fechaentregaex, forKey: "fechafinalentrega")
                      mostrarAlerta33(title: "Escogiste el servicio EXPRESS tu pedido te llegara el dia de mañana \(day2)", message: "Tu pedido será entregado: \(fechaentregaex)")

               }else{
                  self.defaults.set(fechaentrega, forKey: "fechafinalentrega")
           mostrarAlerta33(title: "Con el servicio NORMAL tus entregas SIEMPRE  en esta ubicacion te llegara el dia de  \(day)", message: "Tu pedido será entregado: \(fecha)")                }
            }
                
            else{
                mostrarAlerta2(title: "Especifica tu direccion", message: "")
            }
        }
        else{
            self.alerta(title: "Inicia sesion o registrate", message: "Para continuar disfrutando de los beneficios de LA DESPENSA.")
        }
    }
    else{
        mostrarAlerta2(title: "No disponible", message: "Pronto llegaremos a tu zona")
        
    }
}


func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if primera == false{
        primera = true
        let localizacion = CLLocationCoordinate2DMake(latitud, longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }else{
        
    }
}

func getAddressFromLatLon() {
    
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    let lat: Double = Double("\(self.latitud)")!
    //21.228124
    let lon: Double = Double("\(self.longitud)")!
    //72.833770
    let ceo: CLGeocoder = CLGeocoder()
    center.latitude = lat
    center.longitude = lon
    
    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
    
    
    ceo.reverseGeocodeLocation(loc, completionHandler:
        {(placemarks, error) in
            do{
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
       
      let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
       
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.address.text = addressString
                print(addressString)
                
                return
        
            }
                } catch{
                             
                         }
            })
 
    
    return
}
func notify(msg : String) {
    let content = UNMutableNotificationContent()
    content.title = "FUERA DEL AREA DE ENTREGA"
    content.body = msg
    let request = UNNotificationRequest(identifier: "geofence", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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


func setupData(lat:Double,long:Double){
    let pktienda =  UserDefaults.standard.string(forKey: "pktienda")!

    let pkco =  UserDefaults.standard.array(forKey: "pkpoligonoentrega\(pktienda)")!
    let cou = pkco.count
       for index in 0...cou-1 {
        var xinters = 0.0
         let a = pkco[index]
         var intersection = 0
        self.olatitud.removeAll()
        self.olongitud.removeAll()
          let l = "olatitud\(a)"
          let ll = "olongitud\(a)"
          let lon2 =  UserDefaults.standard.array(forKey: ll)!
          let lat2 =  UserDefaults.standard.array(forKey: l)!
          for obj in 0...lat2.count-1 {
              let long2 = "\(lon2[obj])"
              let lat2 = "\(lat2[obj])"
              let dlong = Double(long2)
              let dlat = Double(lat2)
              self.olatitud.append(dlat!)
              self.olongitud.append(dlong!)
        
        }
        
        for index2 in 1...olatitud.count-1 {
            let vertex1 = olongitud[index2 - 1]
            let vertex2 = olongitud[index2]
            let tvertex1 = olatitud[index2 - 1]
            let tvertex2 = olatitud[index2]
            
            
            
            if long > min(vertex1, vertex2) && long <= max(vertex1, vertex2) && lat <= max(tvertex1, tvertex2) && vertex1 != vertex2 {
                
                
                xinters = (long - vertex1) * (tvertex2 - tvertex1) / (vertex2 - vertex1) + tvertex1
                if (tvertex1 == tvertex2 || lat <= xinters) {
                    intersection =  intersection + 1
                }
            }
        }
        if intersection % 2 != 0 {
            self.defaults.set(a, forKey: "lugardeentrega")
            lugarentrega = "\(a)"
            adentro = true
            return
            
        } else {
            adentro = false
            
        }
        
        
    }
    
    
    
}

func setupMap(){
    
    
    let region = MKCoordinateRegion.init(center:  CLLocationCoordinate2D.init(latitude:  19.4203129, longitude:  -98.1433634), latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(mapView.regionThatFits(region), animated: true)
    mapView.userTrackingMode = .follow
}


}

extension CoordenadasViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    
}


extension CoordenadasViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center  = getCenterLocation(for: mapView)
        
        let geoCoder =  CLGeocoder()
     
      
        geoCoder.reverseGeocodeLocation(center){
            [weak self] (placemarks,error) in
            guard let self = self else{return}
            if let _ = error {
                return
            }
            guard let placemark = placemarks?.first else{
                return
            }
            let streetName = placemark.thoroughfare ?? ""
            let municipio =  placemark.locality ?? ""
            
            let colonia = placemark.subLocality ?? ""
            let estado = placemark.isoCountryCode ?? ""
            
            DispatchQueue.main.async {
                self.di = "\(streetName) \(colonia) \(municipio) \(estado)"
                
                self.address.text = self.di
            }
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.fillColor = UIColor(red: 0, green: 215/255, blue: 145/255, alpha: 0.1)
        
        return polygonView
    }
    
    
}
    
