//
//  Wind.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

// MARK: - Wind
class Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?

    init(speed: Double, deg: Int, gust: Double?) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}
