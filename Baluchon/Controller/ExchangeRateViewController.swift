//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 09/12/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet var amountInEuroTextField: UITextField!
    @IBOutlet var convertButtonOutlet: UIButton!
    @IBOutlet var amountInDollarTextField: UITextField!
    var finalValue = 0.0
    
    let service = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setUpTextFieldManager()
        convertButtonOutlet.layer.cornerRadius = 20
        convertButtonOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        convertButtonOutlet.layer.borderWidth = 1.5
        amountInDollarTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        amountInDollarTextField.layer.borderWidth = 1
        amountInEuroTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        amountInEuroTextField.layer.borderWidth = 1
    }
    
    @IBAction func convertButton() {
        if let textToConvert = amountInEuroTextField.text, textToConvert.isEmpty == false {

            
            service.getRate { success, value in
                DispatchQueue.main.async {
                guard let value = value, success == true else {
                    self.presentAlert(title: "Erreur", message: "Verifier d'avoir un acccès a internet, ou d'avoir bien renseigné un chiffre/nombre")
                    return
                }
                
                    guard let doubleValueEuro = Double(self.amountInEuroTextField.text!) else {
                        self.presentAlert(title: "Aucun nombre/chiffre trouvé", message: "Veuillez renseigner un montant à convertir")
                        return
                        
                    }
                    self.finalValue = doubleValueEuro * value.rates["USD"]!
                    self.amountInDollarTextField.text = String(self.finalValue)
                }
            }
            //
        }
    }
    
    
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        present(alert, animated: true, completion: nil)
    }
    
    private func setUpTextFieldManager() {
        amountInEuroTextField.delegate = self
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountInEuroTextField.resignFirstResponder()
    }
}

extension ExchangeRateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
