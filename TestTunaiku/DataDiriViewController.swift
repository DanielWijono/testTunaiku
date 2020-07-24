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

        fullnameTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: fullnameTextfield.frame.height))
        fullnameTextfield.leftViewMode = .always

        bankAccountTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: bankAccountTextfield.frame.height))
        bankAccountTextfield.leftViewMode = .always

        educationTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: educationTextfield.frame.height))
        educationTextfield.leftViewMode = .always

        dobTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: dobTextfield.frame.height))
        dobTextfield.leftViewMode = .always
    }

    @objc func submitButtonClicked() {
        print("submit button")
    }
}

