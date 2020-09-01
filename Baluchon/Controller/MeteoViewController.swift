//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 20/11/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    
    @IBOutlet weak var nameOfCityVisited: UILabel!
    @IBOutlet weak var nameOfMyCity: UILabel!
    @IBOutlet weak var tempOfCityVisited: UILabel!
    @IBOutlet weak var tempOfMyCity: UILabel!
    // TODO : Maybe find the own city of the user with geolocalisation
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MeteoService.getMeteo(city: "Niort")
    }
}
