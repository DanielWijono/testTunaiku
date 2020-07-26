//
//  ProvinceResponse.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation

struct ProvinceResponse: Codable {
    public let provinsi: [Province]
}

struct Province: Codable {
    public let nama: String
}
