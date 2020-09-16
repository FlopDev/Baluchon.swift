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

    @IBOutlet weak var nameOfCityVisited: UITextField!
    @IBOutlet weak var nameOfMyCity: UILabel!
    @IBOutlet weak var tempOfCityVisited: UILabel!
    @IBOutlet weak var tempOfMycity: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tempLgoOfCityVisited: UIImageView!
    @IBOutlet weak var tempLogoOfOwnCity: UIImageView!
    
    // TODO : Maybe find the own city of the user with geolocalisation
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 20
        searchButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            manager.requestLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        
        // Do any additional setup after loading the view.
        MeteoService.getMeteo(city: "Niort") { (success, meteo) in
            
            let tempOfOwnCityInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: (meteo?.main.temp)!))
            DispatchQueue.main.async {
                self.tempOfMycity.text = String(tempOfOwnCityInCelcius)+("°")
                print(meteo!.weather)
                
                //    let icon = meteo?.weather
                //   self.tempLogoOfOwnCity.image
                //icon?.last
                
            }
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func searchCityTemp(_ sender: Any) {
        if nameOfCityVisited.text != "" {
        MeteoService.getMeteo(city: (nameOfCityVisited.text!)) { (success, meteo) in
            if success == true {
                  let tempOfCityVisitedInCelcius = Int(self.getTempInCelcius(temperatureInKelvin: (meteo?.main.temp)!))
                  DispatchQueue.main.async {
                      self.tempOfCityVisited.text = String(tempOfCityVisitedInCelcius)+("°")
                  }
              } else {
                self.presentAlert(title: "Erreur", message: "Veuillez trouver un nom de ville valide, nous ne trouvons rien de  correspondant")
            }
        
            
        }
        } else {
            presentAlert(title: "Rien à rechercher", message: "Veuillez rentrer le nom d'une ville avant  d'appuyer sur le  bouton de recherche")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let location = locations[0]
        print(location.coordinate)
        print(location)
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
}
