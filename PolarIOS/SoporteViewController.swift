//
//  SoporteViewController.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/6/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import UIKit

class SoporteViewController: UIViewController {
    @IBOutlet weak var imagenusuario: UIImageView!
    @IBOutlet weak var nombreuser: UILabel!
  @IBOutlet weak var traling: NSLayoutConstraint!
  @IBOutlet weak var leading: NSLayoutConstraint!
    let defaults = UserDefaults.standard

    @IBOutlet weak var imgtam: NSLayoutConstraint!
    var menuVisible = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                      traling.constant = 0
        leading.constant = 0

          navigationController?.isToolbarHidden = true
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
                              }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
                 pantalla()
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
           self.tabBarController?.selectedIndex = 2

           
       }
       @IBAction func notificaciones(_ sender: Any) {
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
    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
       
            case 1136:
                print("IPHONE 5 O SE")
                imgtam.constant = 80
            case 1334:
                print("IPHONE 6 6S 7 8")
                self.imgtam.constant = 150

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
    
    
    @IBAction func email(_ sender: Any) {
        let mailURL = URL(string: "message://")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
         }
    }
    
    @IBAction func histpe(_ sender: Any) {
        leading.constant = 0
                       traling.constant = 0
                       menuVisible = false
              self.tabBarController?.selectedIndex = 2

    }
    
    @IBAction func what(_ sender: Any) {
        if let url = URL(string: "https://wa.me/522411184557") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
