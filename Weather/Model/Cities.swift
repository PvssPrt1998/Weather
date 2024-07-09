//
//  Cities.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation

enum Cities {
    case londonGB
}

struct City: Equatable {
    let country: String
    let state: String
    let city: String
}
