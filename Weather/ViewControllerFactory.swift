//
//  ViewControllerFactory.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class ViewControllerFactory {
    
    let viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func makeWeahterViewController() -> WeatherViewController {
        .init(viewModel: viewModelFactory.makeWeatherViewModel())
    }
}
