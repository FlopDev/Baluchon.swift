//
//  TraductionViewController.swift
//  Baluchon
//
//  Created by Florian Peyrony on 09/12/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {
    
    @IBOutlet weak var sentenceFrenchTextField: UITextField!
    @IBOutlet weak var traductionEnglishTextField: UITextField!
    @IBOutlet weak var traductionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFieldManager()
        traductionButton.layer.cornerRadius = 20
    }
    @IBAction func traductionButton(_ sender: UIButton) {
        if let sentenceToTraduce = sentenceFrenchTextField.text, sentenceToTraduce.isEmpty == false {
            TraductionRateService.getTraduction(textToTraduce: sentenceToTraduce) { (sucess, traduce) in
                print(traduce!.data.translations[0])
            }
        } else {
            presentAlert(title: "Nous n'avons rien à traduire", message: "Veuillez renseigner le(s) mots ou phrase(s) à traduire avant d'appuyer sur le bouton Traduire !")
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
        sentenceFrenchTextField.delegate = self
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sentenceFrenchTextField.resignFirstResponder()
    }
}

extension TraductionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
