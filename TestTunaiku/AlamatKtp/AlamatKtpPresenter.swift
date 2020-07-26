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

    init(view: AlamatKtpPresenterToView?) {
        self.view = view
    }

    init(interactor: AlamatKtpPresenterToInteractor?) {
        self.interactor = interactor
    }

    var housingTypeArray: [String] = []
    var provinceArray: [Province] = []

    func didLoad() {
        interactor = AlamatKtpInteractor(presenter: self)
        housingTypeArray.append(HousingType.Rumah.rawValue)
        housingTypeArray.append(HousingType.Kantor.rawValue)
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
