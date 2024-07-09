//
//  ViewModelFactory.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class ViewModelFactory {
    
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        .init(remoteDataManager: remoteDataManager)
    }
}
