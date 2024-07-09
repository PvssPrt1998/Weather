//
//  Coord.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

// MARK: - Coord
class Coord: Codable {
    let lon, lat: Double

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}
