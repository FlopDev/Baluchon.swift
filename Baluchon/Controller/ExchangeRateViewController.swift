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
    @IBOutlet weak var amountInDollarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpTextFieldManager()
    }
    
    private func setUpTextFieldManager() {
        amountInEuroTextField.delegate = self
    }
    
}

extension ExchangeRateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
