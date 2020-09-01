//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 09/12/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    
    @IBOutlet weak var amountInEuroTextField: UITextField!
    @IBOutlet weak var convertButtonOutlet: UIButton!
    @IBOutlet weak var amountInDollarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            ExchangeRateService.getRate()
        }
        else {
            presentAlert(title: "Aucun montant renseigné", message: "Veuillez saisir un montant à convertir avant d'appuyer sur le bouton Convertir")
        }
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
