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
    var interactor: DataDiriPresenterToInteractor? {get set}

    func didLoad()
    func validateNumber(replacementString: String, textCount: Int) -> Bool
    func validateCharacters(replacementString: String, textCount: Int) -> Bool
}

protocol DataDiriPresenterToView: class {
    var presenter: DataDiriViewToPresenter? {get set}
}

protocol DataDiriPresenterToInteractor: class {
    var presenter: DataDiriInteractorToPresenter? {get set}
}

protocol DataDiriInteractorToPresenter: class {

}

