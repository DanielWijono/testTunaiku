//
//  DataDiriEntity.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

struct DataDiriEntity: Codable {
    var nationalId: String
    var fullname: String?
    var bankAccount: String
    var education: String
    var dob: String

    init() {
        self.nationalId = ""
        self.fullname = nil
        self.bankAccount = ""
        self.education = ""
        self.dob = ""
    }
}
