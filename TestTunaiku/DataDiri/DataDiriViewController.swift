//
//  ViewController.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum Education: String {
    case SD
    case SMP
    case SMA
    case S1
    case S2
    case S3
}

class DataDiriViewController: UIViewController {
    @IBOutlet weak var dataDiriTitle: UILabel!
    @IBOutlet weak var nationalIdTextfield: UITextField!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var bankAccountTextfield: UITextField!
    @IBOutlet weak var educationTextfield: UITextField!
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    let pickerViewEducation = UIPickerView()
    let educationArray: [String] = [Education.SD.rawValue, Education.SMP.rawValue, Education.SMA.rawValue,
                                    Education.S1.rawValue, Education.S2.rawValue, Education.S3.rawValue]
    let datePicker = UIDatePicker()
    var presenter: DataDiriViewToPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DataDiriPresenter(view: self)
        presenter?.didLoad()
        setupDelegation()
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
        nationalIdTextfield.keyboardType = .numberPad

        fullnameTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: fullnameTextfield.frame.height))
        fullnameTextfield.leftViewMode = .always

        bankAccountTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: bankAccountTextfield.frame.height))
        bankAccountTextfield.leftViewMode = .always
        bankAccountTextfield.keyboardType = .numberPad

        educationTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: educationTextfield.frame.height))
        educationTextfield.leftViewMode = .always
        educationTextfield.inputView = pickerViewEducation

        dobTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: dobTextfield.frame.height))
        dobTextfield.leftViewMode = .always
        dobTextfield.inputView = datePicker
        datePicker.datePickerMode = .date

        dobTextfield.addDoneOnKeyboardWithTarget(self, action: #selector(doneDobTapped))
        dobTextfield.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousTapped), nextAction: #selector(nextTapped), doneAction: #selector(doneDobTapped), shouldShowPlaceholder: true)
    }

    func setupDelegation() {
        nationalIdTextfield.delegate = self
        fullnameTextfield.delegate = self
        bankAccountTextfield.delegate = self
        educationTextfield.delegate = self
        pickerViewEducation.delegate = self
    }

    @objc func submitButtonClicked() {
        print("submit button")
    }

    @objc func doneDobTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        dobTextfield.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    @objc func previousTapped() {
        educationTextfield.becomeFirstResponder()
    }

    @objc func nextTapped() {
        view.endEditing(true)
    }
}

extension DataDiriViewController: DataDiriPresenterToView {

}

extension DataDiriViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nationalIdTextfield {
            guard let text = textField.text else { return false }
            return presenter?.validateNumber(replacementString: string, textCount: text.count) ?? false
        } else if textField == fullnameTextfield {
            guard let text = textField.text else { return false }
            return presenter?.validateCharacters(replacementString: string, textCount: text.count) ?? false
        } else if textField == bankAccountTextfield {
            guard let text = textField.text else { return false }
            return presenter?.validateNumber(replacementString: string, textCount: text.count) ?? false
        }
        return false
    }
}

extension DataDiriViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return educationArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return educationArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        educationTextfield.text = educationArray[row]
    }
}

