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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpTextFieldManager()
    }
    @IBAction func traductionButton(_ sender: UIButton) {
        if sentenceFrenchTextField.text != nil {
            
        } else {
            print("vous n'avez pas de text d'entrer")
            // TODO: present an alert
        }
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
