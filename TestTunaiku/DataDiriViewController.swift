//
//  ViewController.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import UIKit

class DataDiriViewController: UIViewController {
    @IBOutlet weak var dataDiriTitle: UILabel!
    @IBOutlet weak var nationalIdTextfield: UITextField!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var bankAccountTextfield: UITextField!
    @IBOutlet weak var educationTextfield: UITextField! //pickerview
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegation()
    }

    func setupView() {
        nationalIdTextfield.placeholder = "National Id"
        fullnameTextfield.placeholder = "Fullname"
        bankAccountTextfield.placeholder = "Bank Account No"
        educationTextfield.placeholder = "Education"
        dobTextfield.placeholder = "Date of Birth"
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)

        nationalIdTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nationalIdTextfield.frame.height))
        nationalIdTextfield.leftViewMode = .always
        nationalIdTextfield.keyboardType = .numberPad

        fullnameTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: fullnameTextfield.frame.height))
        fullnameTextfield.leftViewMode = .always

        bankAccountTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: bankAccountTextfield.frame.height))
        bankAccountTextfield.leftViewMode = .always
        bankAccountTextfield.keyboardType = .numberPad

        educationTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: educationTextfield.frame.height))
        educationTextfield.leftViewMode = .always
        //should be calling pickerview

        dobTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: dobTextfield.frame.height))
        dobTextfield.leftViewMode = .always
        //should be calling pickerview
    }

    func setupDelegation() {
        nationalIdTextfield.delegate = self
        fullnameTextfield.delegate = self
        bankAccountTextfield.delegate = self
        educationTextfield.delegate = self
    }

    @objc func submitButtonClicked() {
        print("submit button")
    }
}

extension DataDiriViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nationalIdTextfield {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if textField.text?.count ?? 0 < 16 {
                return string == numberFiltered
            } else {
                return false
            }
        } else if textField == fullnameTextfield {
            let letters = CharacterSet.letters
            let whitespaces = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
            if textField.text?.count ?? 0 < 10 {
                return letters.isSuperset(of: characterSet) || whitespaces.isSuperset(of: characterSet)
            } else {
                return false
            }
        } else if textField == bankAccountTextfield {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if textField.text?.count ?? 0 < 16  {
                return string == numberFiltered
            }
        }
        return false
    }
}

