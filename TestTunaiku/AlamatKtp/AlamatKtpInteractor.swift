//
//  AlamatKtpInteractor.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

class AlamatKtpInteractor: AlamatKtpPresenterToInteractor {
    var presenter: AlamatKtpInteractorToPresenter?

    init(presenter: AlamatKtpInteractorToPresenter?) {
        self.presenter = presenter
    }
}
