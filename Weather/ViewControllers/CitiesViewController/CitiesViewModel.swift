//
//  CitiesViewModel.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class CitiesViewModel {
    
    private let dataManager: DataManager
    private var notificationName: String?
    
    var filtered: Array<String> = []
    var trie = Trie<String>()
    var isNight = false
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.isNight = dataManager.isNight
        
        dataManager.fetchData { cityList in
            cityList.forEach { city in
                self.trie.insert("\(city.name) \(city.country)")
            }
            guard let notificationName = self.notificationName else { return }
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
        }
    }
    
    func rowSelected(_ index: Int) {
        var cityArray = filtered[index].components(separatedBy: " ")
        let country = cityArray.removeLast()
        let name = cityArray.joined(separator: " ")
        dataManager.city = City(country: country, name: name)
    }
    
    func setNotificationName(_ name: String) {
        notificationName = name
    }
    
    func filter(with text: String) {
        if text != "" {
            filtered = trie.collections(startingWith: text)
        } else { filtered = [] }
    }
}
