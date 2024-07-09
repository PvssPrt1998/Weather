//
//  Rain.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

// MARK: - Rain
class Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }

    init(the1H: Double) {
        self.the1H = the1H
    }
}

