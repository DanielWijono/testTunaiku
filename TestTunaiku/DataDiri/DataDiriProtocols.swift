//
//  DataDiriProtocols.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

protocol DataDiriViewToPresenter: class {
    var view: DataDiriPresenterToView? {get set}

    func validateNumber(replacementString: String, textCount: Int) -> Bool
    func validateCharacters(replacementString: String, textCount: Int) -> Bool
    func numberOfEducationRow() -> Int
    func titleEducationAt(row: Int) -> String
    func validateAllField(nationalId: String, bankAccount: String, education: String, dob: String, fullname: String)
}

protocol DataDiriPresenterToView: class {
    var presenter: DataDiriViewToPresenter? {get set}

    func goToAlamatKtpPage()
    func showSnackbarError(messsage: String)
}

