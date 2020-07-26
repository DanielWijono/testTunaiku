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

    init(view: AlamatKtpPresenterToView?) {
        self.view = view
    }

    var housingTypeArray: [String] = []

    func didLoad() {
        housingTypeArray.append(HousingType.Rumah.rawValue)
        housingTypeArray.append(HousingType.Kantor.rawValue)
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
}
