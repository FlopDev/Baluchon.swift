//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 20/11/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit
import CoreLocation

class MeteoViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    let service = MeteoService()

    
    @IBOutlet weak var nameOfCityVisited: UITextField!
    @IBOutlet weak var nameOfMyCity: UILabel!
    @IBOutlet weak var tempOfCityVisited: UILabel!
    @IBOutlet weak var tempOfMycity: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tempLgoOfCityVisited: UIImageView!
    @IBOutlet weak var tempLogoOfOwnCity: UIImageView!
    var userLatitude: CLLocationDegrees?
    var userLongitude: CLLocationDegrees?
    
    
    
    // TODO : Maybe find the own city of the user with geolocalisation
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManager()
        searchButton.layer.cornerRadius = 20
        searchButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        
        // Do any additional setup after loading the view.
        // TO DO : faire un appel sur la localisation de l'utalisateur (location) et pas sur "Niort"

        tcheckAuthorisation()
     
    }
    
    
    
    @IBAction func searchCityTemp(_ sender: Any) {
        if nameOfCityVisited.text != "" {
            
            service.getMeteo(city: nameOfCityVisited.text!) { (success, meteo) in
        
                if success == true {
                    let tempOfCityVisitedInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: (meteo?.main.temp)!))
                    DispatchQueue.main.async {
                        self.tempOfCityVisited.text = String(tempOfCityVisitedInCelcius)+("°")
                        let icon = meteo?.weather.first?.icon

                        self.service.getImage(iconNumber: icon!) { (success, data) in
                            DispatchQueue.main.async {
                                if success == true {
                                    self.tempLgoOfCityVisited.image = UIImage(data: data!)
                                } else {
                                    self.presentAlert(title: "Erreur", message: "Nous ne trouvons pas d'images associées à votre ville, veuillez réessayer !")
                                }
                                
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.presentAlert(title: "Erreur", message: "Veuillez trouver un nom de ville valide, nous ne trouvons rien de  correspondant, veuillez verifier l'orthographe")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.presentAlert(title: "Rien à rechercher", message: "Veuillez rentrer le nom d'une ville avant  d'appuyer sur le  bouton de recherche")
            }
        }
    }
    
    func setupManager() {
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // quand l'autorisation de l'utilisateur a changé
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways:
                print("Always")
            case .authorizedWhenInUse:
                print("when in use")
            case .denied:
                print("Denied")
            case .notDetermined:
                print("NotDetermined")
            case .restricted:
                print("Restricted")
            default:
                print("other")
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                break
            @unknown default:
                break
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //erreur de position
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Quand on recoit les nouvelles positions
        if let first = locations.first {
             let coordinates = first.coordinate
            userLatitude = coordinates.latitude
            userLongitude = coordinates.longitude
            print("Nous avons les coordonnées \(coordinates)")
            requestMeteo()
        }
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTempInCelcius(temperatureInKelvin: Double) -> Double {
        let temperatureInCelcius = temperatureInKelvin - 273.15
        return temperatureInCelcius
    }
    func tcheckAuthorisation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            manager.requestLocation()
            setupManager()
            
        }
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager.requestLocation()
            setupManager()
        
    } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    func requestMeteo() {
        if let userLatitude = userLatitude, let userLongitude = userLongitude {
            service.getMeteoGeoLoc(latitude: userLatitude, longitude: userLongitude) { (success, meteo) in
                
                let tempOfOwnCityInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: (meteo?.main.temp)!))
               
                DispatchQueue.main.async {
                    self.tempOfMycity.text = String(tempOfOwnCityInCelcius)+("°")
                    let icon = meteo?.weather.first?.icon

                    self.service.getImage(iconNumber: icon!) { (success, data) in
                        DispatchQueue.main.async {
                            if success == true {
                                self.tempLogoOfOwnCity.image = UIImage(data: data!)
                            } else {
                                self.presentAlert(title: "Erreur", message: "Nous ne trouvons pas d'images associées à votre ville, veuillez réessayer !")
                            }
                            
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.presentAlert(title: "Erreur", message: "Nous n'avons pas réussi à trouver votre localisation, veuillez réessayer ou rechercher une ville ci-dessus via la barre de recherche !")
            }
        }
    }
    
}


