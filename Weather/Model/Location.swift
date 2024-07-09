//
//  Location.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

typealias Locations = [Location]

class Location: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }

    init(name: String, localNames: [String: String]?, lat: Double, lon: Double, country: String, state: String) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
}

