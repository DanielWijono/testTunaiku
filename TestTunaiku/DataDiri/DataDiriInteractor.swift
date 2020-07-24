//
//  DataDiriInteractor.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

class DataDiriInteractor: DataDiriPresenterToInteractor {
    var presenter: DataDiriInteractorToPresenter?

    init(presenter: DataDiriInteractorToPresenter?) {
        self.presenter = presenter
    }
}
