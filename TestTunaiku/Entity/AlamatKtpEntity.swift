//
//  AlamatKtpEntity.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

struct AlamatKtpEntity: Codable {
    var domicile: String
    var housingType: String
    var numberAddress: String
    var province: String

    init() {
        self.domicile = ""
        self.housingType = ""
        self.numberAddress = ""
        self.province = ""
    }
}
