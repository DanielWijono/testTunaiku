//
//  AlamatKtpPresenter.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

class AlamatKtpPresenter: AlamatKtpViewToPresenter {
    var view: AlamatKtpPresenterToView?

    init(view: AlamatKtpPresenterToView?) {
        self.view = view
    }
}
