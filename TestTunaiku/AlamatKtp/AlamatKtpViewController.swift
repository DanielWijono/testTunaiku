//
//  AlamatKtpViewController.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation
import UIKit

class AlamatKtpViewController: UIViewController {
    @IBOutlet weak var domicileAddressTf: UITextField!
    @IBOutlet weak var housingTypeTf: UITextField!
    @IBOutlet weak var numberAddressTf: UITextField!
    @IBOutlet weak var provinceTf: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    let pickerViewHousing = UIPickerView()
    let pickerViewProvince = UIPickerView()
    var presenter: AlamatKtpViewToPresenter?

    override func viewDidLoad() {
        presenter = AlamatKtpPresenter(view: self)
        setupDelegation()
        presenter?.didLoad()
        setupView()

    }

    func setupView() {
        domicileAddressTf.placeholder = "Domisili"
        housingTypeTf.placeholder = "Tipe Tempat Tinggal"
        numberAddressTf.placeholder = "No"
        provinceTf.placeholder = "Provinsi"
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)

        domicileAddressTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: domicileAddressTf.frame.height))
        domicileAddressTf.leftViewMode = .always
        domicileAddressTf.keyboardType = .default

        housingTypeTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: housingTypeTf.frame.height))
        housingTypeTf.leftViewMode = .always
        housingTypeTf.inputView = pickerViewHousing
        //picker view

        numberAddressTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: numberAddressTf.frame.height))
        numberAddressTf.leftViewMode = .always
        numberAddressTf.keyboardType = .default

        provinceTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: provinceTf.frame.height))
        provinceTf.leftViewMode = .always
        provinceTf.inputView = pickerViewProvince
        //picker view
    }

    func setupDelegation() {
        domicileAddressTf.delegate = self
        housingTypeTf.delegate = self
        numberAddressTf.delegate = self
        provinceTf.delegate = self
        pickerViewHousing.delegate = self
        pickerViewProvince.delegate = self
        pickerViewHousing.dataSource = self
        pickerViewProvince.dataSource = self
    }

    @objc func submitButtonClicked() {
        //        guard let nationalIdCount = nationalIdTextfield.text?.count else { return }
        //        guard let bankAccountCount = bankAccountTextfield.text?.count else { return }
        //        guard let educationCount = educationTextfield.text?.count else { return }
        //        guard let dobCount = dobTextfield.text?.count else { return }
        //
        //        presenter?.validateAllField(nationalId: nationalIdCount, bankAccount: bankAccountCount, education: educationCount, dob: dobCount)
    }
}

extension AlamatKtpViewController: AlamatKtpPresenterToView {
    func pickerViewReloadData() {
        pickerViewProvince.reloadAllComponents()
        pickerViewHousing.reloadAllComponents()
    }
}

extension AlamatKtpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerViewHousing {
            return presenter?.numberOfHousingRow() ?? 0
        } //must have else for province picker later
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewHousing {
            return presenter?.titleHousingAt(row: row)
        } //must have else for province picker later
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewHousing {
            housingTypeTf.text = presenter?.titleHousingAt(row: row)
        } //must have else for province picker later
    }
}

extension AlamatKtpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == domicileAddressTf {
            guard let text = textField.text else { return false }
            return presenter?.validateLength(textCount: text.count) ?? false
        } else if textField == numberAddressTf {
            return true
        }
        return false
    }
}
