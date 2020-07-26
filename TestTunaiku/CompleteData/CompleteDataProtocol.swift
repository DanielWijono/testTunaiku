//
//  CompleteDataProtocol.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

protocol CompleteDataViewToPresenter: class {
    var view: CompleteDataPresenterToView? {get set}

    func getData()
}

protocol CompleteDataPresenterToView: class {
    var presenter: CompleteDataViewToPresenter? {get set}

    func setData(dataDiri: DataDiriEntity, alamatKtp: AlamatKtpEntity)
}
