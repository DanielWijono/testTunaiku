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
}

protocol AlamatKtpPresenterToView: class {
    var presenter: AlamatKtpViewToPresenter? {get set}

    func pickerViewReloadData()
}

protocol AlamatKtpPresenterToInteractor: class {
    var presenter: AlamatKtpInteractorToPresenter? {get set}
}

protocol AlamatKtpInteractorToPresenter: class {

}
