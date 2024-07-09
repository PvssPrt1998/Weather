//
//  ViewModelFactory.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class ViewModelFactory {

    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        .init(dataManager: dataManager)
    }
    
    func makeCitiesViewModel() -> CitiesViewModel {
        .init(dataManager: dataManager)
    }
}
