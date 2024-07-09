//
//  DataManager.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class DataManager {
    
    let remoteDataManager: RemoteDataManager
    var city: Cities = .londonGB
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func fetchWeather(completion: @escaping (WeatherData) -> Void) {
        remoteDataManager.onCompletion = { weatherData in
            completion(weatherData)
        }
        remoteDataManager.fetchWeather(by: city)
    }
}
