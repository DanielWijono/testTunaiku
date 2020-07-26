//
//  AlamatKtpPresenter.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

public enum HousingType: String {
    case Rumah
    case Kantor
}

class AlamatKtpPresenter: AlamatKtpViewToPresenter {
    var view: AlamatKtpPresenterToView?
    var interactor: AlamatKtpPresenterToInteractor?

    init() { }

    var housingTypeArray: [String] = [HousingType.Rumah.rawValue, HousingType.Kantor.rawValue]
    var provinceArray: [Province] = []
    var alamatKtpEntity: AlamatKtpEntity = AlamatKtpEntity()

    func didLoad() {
        interactor?.getProvince()
        view?.pickerViewReloadData()
    }

    func validateLength(textCount: Int) -> Bool {
        return textCount > 100 ? false : true
    }

    func numberOfHousingRow() -> Int {
        return housingTypeArray.count
    }

    func titleHousingAt(row: Int) -> String {
        return housingTypeArray[row]
    }

    func numberOfProvinceRow() -> Int {
        return provinceArray.count
    }

    func titleProvinceAt(row: Int) -> String {
        return provinceArray[row].nama
    }

    func validateAlphaNumeric(text: String) -> Bool {
        let hasLetters = text.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = text.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = text.components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }

    func validateAllField(domicile: String, housing: String, numberAddress: String, province: String) {
        if domicile.count > 0 && domicile.count <= 100 && housing.count > 0 && numberAddress.count > 0 && validateAlphaNumeric(text: numberAddress) && province.count > 0 {
            alamatKtpEntity.domicile = domicile
            alamatKtpEntity.housingType = housing
            alamatKtpEntity.numberAddress = numberAddress
            alamatKtpEntity.province = province
            let dataEncoded = try? JSONEncoder().encode(alamatKtpEntity)
            UserDefaults.standard.set(dataEncoded, forKey: "alamatKtpEntity")
            view?.navigateToReviewDataPage()
        } else if domicile.isEmpty {
            view?.showSnackbarErrorMessage(error: "domicile cannot be empty")
        } else if housing.isEmpty {
            view?.showSnackbarErrorMessage(error: "housing type cannot be empty")
        } else if numberAddress.isEmpty {
            view?.showSnackbarErrorMessage(error: "number address cannot be empty")
        } else if validateAlphaNumeric(text: numberAddress) == false {
            view?.showSnackbarErrorMessage(error: "number address not alphanumeric")
        } else if province.isEmpty {
            view?.showSnackbarErrorMessage(error: "province cannot be empty")
        }
    }
}

extension AlamatKtpPresenter: AlamatKtpInteractorToPresenter {
    func successGetProvince(response: [Province]) {
        self.provinceArray = response
        view?.pickerViewReloadData()
    }

    func failedGetProvince(response: String) {
        view?.showSnackbarErrorMessage(error: response)
    }
}
