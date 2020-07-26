//
//  AlamatKtpProtocols.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

protocol AlamatKtpViewToPresenter: class {
    var view: AlamatKtpPresenterToView? {get set}
    func validateLength(textCount: Int) -> Bool
    func numberOfHousingRow() -> Int
    func titleHousingAt(row: Int) -> String
    func didLoad()
    func numberOfProvinceRow() -> Int
    func titleProvinceAt(row: Int) -> String
    func validateAllField(domicile: String, housing: String, numberAddress: String, province: String)
}

protocol AlamatKtpPresenterToView: class {
    var presenter: AlamatKtpViewToPresenter? {get set}

    func pickerViewReloadData()
    func showSnackbarErrorMessage(error: String)
    func navigateToReviewDataPage()
}

protocol AlamatKtpPresenterToInteractor: class {
    var presenter: AlamatKtpInteractorToPresenter? {get set}

    func getProvince()
}

protocol AlamatKtpInteractorToPresenter: class {
    func failedGetProvince(response: String)
    func successGetProvince(response: [Province])
}
