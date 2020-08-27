//
//  EnterCityViewController.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-10.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

protocol EnterCityViewControllerDelegate {
    func setCity(_ city: String)
}

class EnterCityViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet weak var enterCityTextField: UITextField!
    
    // MARK: - Variable

    var enterCityDelegate: EnterCityViewControllerDelegate?

    // MARK: - View did load

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup action doneButton
    
    @IBAction func doneButton(_ sender: UIButton) {
        enterCityTextField.endEditing(true)
        guard let city = enterCityTextField.text else { return }
        enterCityDelegate?.setCity(city)
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        enterCityTextField?.resignFirstResponder()
    }
}

