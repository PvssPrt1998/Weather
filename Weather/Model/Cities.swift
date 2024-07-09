//
//  Cities.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

typealias CityList = [City]

struct City: Equatable, Codable {
    let country: String
    let name: String
}
