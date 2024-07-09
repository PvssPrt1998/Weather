//
//  DataManager.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation
import Alamofire

final class DataManager {
    
    let remoteDataManager: RemoteDataManager
    var city: City = City(country: "GB", name: "London")
    
    let decoder = JSONDecoder()
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func fetchWeather(completion: @escaping (WeatherData) -> Void) {
        remoteDataManager.onCompletion = { weatherData in
            completion(weatherData)
        }
        remoteDataManager.fetchWeather(by: city)
    }
    
    private func save<T: Encodable>(_ object: T, to fileName: String) throws {
        do {
            let encoder = JSONEncoder()
            let url = createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        } catch (let error) {
            print("Save failed: Object: `\(object)`, " + "Error: `\(error)`")
            throw error
        }
    }
    
    func fetchData(completion: @escaping (CityList) -> Void) {
        guard let url = getURL() else {
            fatalError("No file named: CitiesJson.json in Bundle")
        }
        AF.request(url).responseDecodable(of: CityList.self) { response in
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                                   print("Data: \(utf8Text)")
//                           }
            guard let cityList = response.value else { return }
            completion(cityList)
        }
    }

    private func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        try retrieve(T.self, from: createDocumentURL(withFileName: fileName))
    }
    
    private func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
//            if let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)")
//            }
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            print("Retrieve failed: URL: `\(url)`, Error: `\(error)`")
            throw error
        }
    }
    
    private func createDocumentURL(withFileName fileName: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
    private func getURL() -> URL? {
        Bundle.main.url(forResource: "CitiesJson.json", withExtension: nil)
    }
}
