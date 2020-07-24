//
//  DataDiriPresenter.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

enum Education: String {
    case SD
    case SMP
    case SMA
    case S1
    case S2
    case S3
}

class DataDiriPresenter: DataDiriViewToPresenter {
    var view: DataDiriPresenterToView?

    var educationArray: [String] = [Education.SD.rawValue, Education.SMP.rawValue, Education.SMA.rawValue,
    Education.S1.rawValue, Education.S2.rawValue, Education.S3.rawValue]

    init(view: DataDiriPresenterToView?) {
        self.view = view
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

    func numberOfEducationRow() -> Int {
        return educationArray.count
    }

    func titleEducationAt(row: Int) -> String {
        return educationArray[row]
    }
}
