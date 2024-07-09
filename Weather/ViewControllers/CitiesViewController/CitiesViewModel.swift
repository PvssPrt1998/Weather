//
//  CitiesViewModel.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class CitiesViewModel {
    
    let dataManager: DataManager
    private var notificationName: String?
    
    var filtered: Array<String> = []
    var trie = Trie<String>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        dataManager.fetchData { cityList in
            cityList.forEach { city in
                self.trie.insert("\(city.name) \(city.country)")
            }
            guard let notificationName = self.notificationName else { return }
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
        }
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
