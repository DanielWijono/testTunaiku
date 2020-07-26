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
    
}

protocol AlamatKtpPresenterToView: class {
    var presenter: AlamatKtpViewToPresenter? {get set}
}
