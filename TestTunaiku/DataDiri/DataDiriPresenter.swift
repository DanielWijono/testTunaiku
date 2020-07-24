//
//  DataDiriPresenter.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

class DataDiriPresenter: DataDiriViewToPresenter {
    var view: DataDiriPresenterToView?

    var interactor: DataDiriPresenterToInteractor?

    init(view: DataDiriPresenterToView?) {
        self.view = view
    }

    init(interactor: DataDiriPresenterToInteractor?) {
        self.interactor = interactor
    }

    func didLoad() {
        interactor = DataDiriInteractor(presenter: self)
    }

    func validateNumber(replacementString: String, textCount: Int) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = replacementString.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        if textCount < 16 || replacementString == "" {
            return replacementString == numberFiltered
        } else {
            return false
        }
    }

    func validateCharacters(replacementString: String, textCount: Int) -> Bool {
        let letters = CharacterSet.letters
        let whitespaces = CharacterSet.whitespaces
        let characterSet = CharacterSet(charactersIn: replacementString)
        if textCount < 10 || replacementString == "" {
            return letters.isSuperset(of: characterSet) || whitespaces.isSuperset(of: characterSet)
        } else {
            return false
        }
    }
}

extension DataDiriPresenter: DataDiriInteractorToPresenter {
    
}
