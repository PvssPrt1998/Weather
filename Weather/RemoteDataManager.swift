//
//  RemoteData.swift
//  Weather
//
//  Created by Николай Щербаков on 06.07.2024.
//

import Foundation
import Alamofire

final class RemoteDataManager {
    
    let apiKey = "2971a402db283734eaebc632ccde93dd"
    
    var onCompletion: ((WeatherData) -> Void)?
    
    func fetchWeather(by city: Cities) {
        fetchCoordinates(by: city) { [weak self] location in
            guard let self = self else { return }
            let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=metric"
            print("beforeFetched")
            AF.request(url).responseDecodable(of: WeatherData.self) { response in
//                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                        print("Data: \(utf8Text)")
//                }
                guard let weatherData = response.value else { return }
                self.onCompletion?(weatherData)
            }
        }
    }
    
    func getCity(_ city: Cities) -> City {
        switch city {
            case .londonGB: City(country: "GB", state: "England", city: "London")
        }
    }
    
    private func fetchCoordinates(by city: Cities, completion: @escaping (Location) -> Void) {
        let city = getCity(city)
        let url = "https://api.openweathermap.org/geo/1.0/direct?q=\(city.city),\(city.state),\(city.country)&limit=1&appid=\(apiKey)"
        AF.request(url).responseDecodable(of: Locations.self) { response in
            guard let locations = response.value else { return }
            locations.forEach { location in
                print(location.lat)
                completion(location)
            }
        }
    }
}
