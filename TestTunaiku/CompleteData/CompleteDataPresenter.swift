//
//  CompleteDataPresenter.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

class CompleteDataPresenter: CompleteDataViewToPresenter {
    var view: CompleteDataPresenterToView?

    init() { }

    var dataDiriArray: DataDiriEntity = DataDiriEntity()
    var alamatKtpArray: AlamatKtpEntity = AlamatKtpEntity()

    func getData() {
        if let dataDiriEncoded = UserDefaults.standard.value(forKey: "dataDiriEntity") as? Data,
            let alamatKtpEncoded = UserDefaults.standard.value(forKey: "alamatKtpEntity") as? Data {
            guard let dataDiri = try? JSONDecoder().decode(DataDiriEntity.self, from: dataDiriEncoded) as? DataDiriEntity else { return }
            guard let alamatKtp = try? JSONDecoder().decode(AlamatKtpEntity.self, from: alamatKtpEncoded) as? AlamatKtpEntity else { return }

            dataDiriArray = dataDiri
            alamatKtpArray = alamatKtp

            view?.setData(dataDiri: dataDiriArray, alamatKtp: alamatKtpArray)
        }
    }
}
