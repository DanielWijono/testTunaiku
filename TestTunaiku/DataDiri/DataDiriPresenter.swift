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

    var dataDiriArray: [String] = []
    var dataDiriEntity: DataDiriEntity = DataDiriEntity()

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

    func validateAllField(nationalId: String, bankAccount: String, education: String, dob: String, fullname: String) {
        if nationalId.count == 16 && bankAccount.count >= 8 && education.count > 0 && dob.count > 0 {
            dataDiriEntity.nationalId = nationalId
            dataDiriEntity.bankAccount = bankAccount
            dataDiriEntity.education = education
            dataDiriEntity.dob = dob
            dataDiriEntity.fullname = fullname
            let dataDiriEncoded = try? JSONEncoder().encode(dataDiriEntity)
            UserDefaults.standard.set(dataDiriEncoded, forKey: "dataDiriEntity")
            view?.goToAlamatKtpPage()
        } else if nationalId.count != 16 {
            view?.showSnackbarError(messsage: "national id must have 16 characters")
        } else if bankAccount.count < 8 {
            view?.showSnackbarError(messsage: "bank account must have minimum 8 characters")
        } else if education.count == 0 {
            view?.showSnackbarError(messsage: "education cannot be empty")
        } else if dob.count == 0 {
            view?.showSnackbarError(messsage: "dob cannot be empty")
        }
    }

    func numberOfEducationRow() -> Int {
        return educationArray.count
    }

    func titleEducationAt(row: Int) -> String {
        return educationArray[row]
    }
}
