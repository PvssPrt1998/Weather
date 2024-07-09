//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class WeatherViewModel {
    
    private var weatherData: WeatherData?
    
    var city: Cities = .londonGB
    
    let remoteDataManager: RemoteDataManager
    private var notificationName: String?
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
        
        remoteDataManager.onCompletion = { [weak self] weatherData in
            self?.weatherData = weatherData
            guard let notificationName = self?.notificationName else { return }
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
        }
        remoteDataManager.fetchWeather(by: city)
    }
    
    func getTemp() -> String? {
        guard let weatherData = weatherData else { return nil }
        let date = Date(timeIntervalSince1970: TimeInterval(weatherData.dt))
        return "\(Int(weatherData.main.temp))°"
    }
    
    func setNotificationName(_ name: String) {
        notificationName = name
    }
    
    func getCity() -> City {
        switch city {
            case .londonGB: City(country: "GB", state: "England", city: "London")
        }
    }
    
    func getBackgroundTitle() -> String {
        guard let weatherData = weatherData else { return ImageAssetsTitles.DayBackground.rawValue }
        if (weatherData.dt > weatherData.sys.sunset && weatherData.dt > weatherData.sys.sunrise)
            || (weatherData.dt < weatherData.sys.sunset) {
            return ImageAssetsTitles.NightBackground.rawValue
        } else {
            return ImageAssetsTitles.DayBackground.rawValue
        }
    }
    
    func getWeatherType() -> String? {
        guard let weatherId = weatherData?.weather.first?.id else { return nil }
        switch weatherId {
        case 200...232: return "Thunderstorm"
        case 300...321: return "Drizzle"
        case 500...531: return "Rain"
        case 600...622: return "Snow"
        case 800: return "Clear sky"
        case 801...804: return "Clouds"
        default: return nil
        }
    }
}
