//
//  ViewController.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class DataDiriViewController: UIViewController {
    @IBOutlet weak var nationalIdTextfield: UITextField!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var bankAccountTextfield: UITextField!
    @IBOutlet weak var educationTextfield: UITextField!
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    let pickerViewEducation = UIPickerView()
    let datePicker = UIDatePicker()
    var presenter: DataDiriViewToPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DataDiriPresenter(view: self)
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
        self.title = "Data Diri Page"

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
        guard let nationalId = nationalIdTextfield.text else { return }
        guard let bankAccount = bankAccountTextfield.text else { return }
        guard let education = educationTextfield.text else { return }
        guard let dob = dobTextfield.text else { return }
        guard let fullname = fullnameTextfield.text else { return }

        presenter?.validateAllField(nationalId: nationalId, bankAccount: bankAccount, education: education, dob: dob, fullname: fullname)
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

    func goToAlamatKtpPage() {
        print(#function)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AlamatKtpViewController") as? AlamatKtpViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func showSnackbarError(messsage: String) {
        var snackBar = SnackbarView()
        snackBar = SnackbarView(frame: self.view.frame)
        self.view.addSubview(snackBar)
        snackBar.showSnackbar(message: messsage)
    }
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
        return presenter?.numberOfEducationRow() ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.titleEducationAt(row: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        educationTextfield.text = presenter?.titleEducationAt(row: row)
    }
}

