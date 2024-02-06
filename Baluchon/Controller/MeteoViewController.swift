//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 20/11/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import CoreLocation
import UIKit

enum MyMeteoState {
    case loading
    case refused
    case received
}

class MeteoViewController: UIViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let service = MeteoService()

    var myMeteoState: MyMeteoState = .loading {
        didSet {
            reloadMyMeteoScreen()
        }
    }
    
    @IBOutlet var nameOfCityVisited: UITextField!
    @IBOutlet var nameOfMyCity: UILabel!
    @IBOutlet var tempOfCityVisited: UILabel!
    @IBOutlet var tempOfMycity: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tempLgoOfCityVisited: UIImageView!
    @IBOutlet var tempLogoOfOwnCity: UIImageView!
    var userLatitude: CLLocationDegrees?
    var userLongitude: CLLocationDegrees?
    
    @IBOutlet var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupManager()
        searchButton.layer.cornerRadius = 20
        searchButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        manager.desiredAccuracy = kCLLocationAccuracyKilometer

        tcheckAuthorisation()
    }
    
    func reloadMyMeteoScreen() {
        switch myMeteoState {
        case .loading:

            nameOfMyCity.isHidden = true
            tempLogoOfOwnCity.isHidden = true
            tempOfMycity.isHidden = true
            loader.isHidden = false
        case .refused:
            nameOfMyCity.text = "Veuillez activer la géolocalisation depuis vos réglages ou verifier votre connexion."
            tempLogoOfOwnCity.isHidden = true
            tempOfMycity.isHidden = true
            //self.presentAlert(title: "Impossible d'avoir votre localisation", message: "Veuillez verifier votre connexion, ou activer la géolocalisation depuis vos réglages")
        case .received:
            nameOfMyCity.isHidden = false
            nameOfMyCity.text = "Météo Locale"
            tempLogoOfOwnCity.isHidden = false
            tempOfMycity.isHidden = false
            loader.isHidden = true
        }
    }
    
    @IBAction func searchCityTemp(_ sender: Any) {
        if nameOfCityVisited.text != "" {
            service.getMeteo(city: nameOfCityVisited.text!) { success, meteo in
        
                if success == true {
                    let tempOfCityVisitedInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: (meteo?.main.temp)!))
                    DispatchQueue.main.async {
                        self.tempOfCityVisited.text = String(tempOfCityVisitedInCelcius)+"°"
                        let icon = meteo?.weather.first?.icon

                        self.service.getImage(iconNumber: icon!) { success, data in
                            DispatchQueue.main.async {
                                if success == true {
                                    self.tempLgoOfCityVisited.image = UIImage(data: data!)
                                } else {
                                    self.presentAlert(title: "Erreur", message: "Nous ne trouvons pas d'images associées à votre ville, veuillez réessayer.")
                                }
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.presentAlert(title: "Erreur", message: "Veuillez renseigner un nom de ville valide, nous ne trouvons rien de correspondant, veuillez verifier l'orthographe ou encore votre connexion internet.")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.presentAlert(title: "Rien à rechercher", message: "Veuillez rentrer le nom d'une ville avant d'appuyer sur le bouton de recherche.")
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
                myMeteoState = .refused
                print("Denied")
            case .notDetermined:
                print("NotDetermined")
            case .restricted:
                myMeteoState = .refused
                print("Restricted")
            default:
                print("other")
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                myMeteoState = .refused
            case .restricted:
                myMeteoState = .refused
            case .denied:
                myMeteoState = .refused
            case .authorizedAlways:
                requestMeteo()
            case .authorizedWhenInUse:
                requestMeteo()
                break
            @unknown default:
                break
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // erreur de position
        print(error.localizedDescription)
        myMeteoState = .refused
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Quand on recoit les nouvelles positions
        if let first = locations.first {
            let coordinates = first.coordinate
            userLatitude = coordinates.latitude
            userLongitude = coordinates.longitude
            print("Nous avons les coordonnées \(coordinates)")
            requestMeteo()
            myMeteoState = .received
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        present(alert, animated: true, completion: nil)
    }
    
    func getTempInCelcius(temperatureInKelvin: Double) -> Double {
        let temperatureInCelcius = temperatureInKelvin - 273.15
        return temperatureInCelcius
    }

    func tcheckAuthorisation() {
        //
        switch manager.authorizationStatus {
        case .restricted, .denied:
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            setupManager()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }

    func requestMeteo() {
        if let userLatitude = userLatitude, let userLongitude = userLongitude {
            service.getMeteoGeoLoc(latitude: userLatitude, longitude: userLongitude) { success, meteo in
                print("\(userLatitude) and \(userLongitude)")
                
                guard let unwrappedMeteo = meteo else {
                    DispatchQueue.main.async {
                        // Si meteo est nul, nous sortons de la méthode ou du bloc
                        self.presentAlert(title: "Aucune connexion internet", message: "Verifier votre connexion internet, nous ne parvenons pas à établir une connexion.")
                    }
                    return
                }
                
                let temperatureKelvin = unwrappedMeteo.main.temp
                let tempOfOwnCityInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: temperatureKelvin))


                DispatchQueue.main.async {
                    self.tempOfMycity.text = String(tempOfOwnCityInCelcius)+"°"
                    let icon = unwrappedMeteo.weather.first?.icon

                    self.service.getImage(iconNumber: icon!) { success, data in
                        DispatchQueue.main.async {
                            if success == true {
                                self.tempLogoOfOwnCity.image = UIImage(data: data!)
                            } else {
                                self.presentAlert(title: "Erreur", message: "Nous ne trouvons pas d'images associées à votre ville, veuillez réessayer.")
                            }
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.presentAlert(title: "Erreur", message: "Nous n'avons pas réussi à trouver votre localisation, veuillez réessayer ou rechercher une ville ci-dessus via la barre de recherche.")
            }
        }
    }
    
    private func setUpTextFieldManager() {
        nameOfCityVisited.delegate = self
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameOfCityVisited.resignFirstResponder()
    }
}

extension MeteoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
