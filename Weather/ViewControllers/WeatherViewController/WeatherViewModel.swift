//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class WeatherViewModel {
    
    private var weatherData: WeatherData?
    let dataManager: DataManager
    private var notificationName: String?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        updateData()
    }
    
    func updateData() {
        print("update")
        dataManager.fetchWeather { [weak self] weatherData in
            self?.weatherData = weatherData
            guard let notificationName = self?.notificationName else { return }
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
        }
    }
    
    func getCity() -> String {
        dataManager.city.name
    }
    
    func getTemp() -> String? {
        guard let weatherData = weatherData else { return nil }
        return "\(Int(weatherData.main.temp))°"
    }
    
    func setNotificationName(_ name: String) {
        notificationName = name
    }
    
    func isNight() -> Bool {
        guard let weatherData = weatherData else { return false }
        return (weatherData.dt > weatherData.sys.sunset && weatherData.dt > weatherData.sys.sunrise)
            || (weatherData.dt < weatherData.sys.sunset && weatherData.dt < weatherData.sys.sunrise)
    }
    
    func getBackgroundTitle() -> String {
        if isNight() {
            dataManager.isNight = true
            return ImageAssetsTitles.NightBackground.rawValue
        } else {
            dataManager.isNight = false
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
