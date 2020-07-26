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

        numberAddressTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: numberAddressTf.frame.height))
        numberAddressTf.leftViewMode = .always
        numberAddressTf.keyboardType = .default

        provinceTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: provinceTf.frame.height))
        provinceTf.leftViewMode = .always
        provinceTf.inputView = pickerViewProvince
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
        guard let domicileText = domicileAddressTf.text else { return }
        guard let housingText = housingTypeTf.text else { return }
        guard let numberAddressText = numberAddressTf.text else { return }
        guard let provinceText = provinceTf.text else { return }

        presenter?.validateAllField(domicile: domicileText, housing: housingText, numberAddress: numberAddressText, province: provinceText)
    }
}

extension AlamatKtpViewController: AlamatKtpPresenterToView {
    func pickerViewReloadData() {
        pickerViewProvince.reloadAllComponents()
        pickerViewHousing.reloadAllComponents()
    }

    func showSnackbarErrorMessage(error: String) {
        var snackBar = SnackbarView()
        snackBar = SnackbarView(frame: self.view.frame)
        self.view.addSubview(snackBar)
        snackBar.showSnackbar(message: error)
    }

    func navigateToReviewDataPage() {
        print(#function)
    }
}

extension AlamatKtpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerViewHousing {
            return presenter?.numberOfHousingRow() ?? 0
        } else if pickerView == pickerViewProvince {
            return presenter?.numberOfProvinceRow() ?? 0
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewHousing {
            return presenter?.titleHousingAt(row: row)
        } else if pickerView == pickerViewProvince {
            return presenter?.titleProvinceAt(row: row)
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewHousing {
            housingTypeTf.text = presenter?.titleHousingAt(row: row)
        } else if pickerView == pickerViewProvince {
            provinceTf.text = presenter?.titleProvinceAt(row: row)
        }
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
