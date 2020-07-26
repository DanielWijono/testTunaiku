//
//  AlamatKtpInteractor.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 25/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation
import Alamofire

class AlamatKtpInteractor: AlamatKtpPresenterToInteractor {
    var presenter: AlamatKtpInteractorToPresenter?

    init() {
        
    }

    func getProvince() {
        AF.request("https://dev.farizdotid.com/api/daerahindonesia/provinsi").responseDecodable(of: ProvinceResponse.self) { (response) in
            guard let provinceNameArray = response.value?.provinsi else {
                self.presenter?.failedGetProvince(response: response.error?.errorDescription ?? "Gagal mendapatkan provinsi")
                return
            }
            self.presenter?.successGetProvince(response: provinceNameArray)
        }
    }
}
