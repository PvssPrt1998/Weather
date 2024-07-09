//
//  Weather.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

// MARK: - Weather
class Weather: Codable {
    let id: Int
    let main, description, icon: String

    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
