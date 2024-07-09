//
//  AppDIContainer.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class AppContainer {
    
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func makeViewControllerFactory() -> ViewControllerFactory {
        ViewControllerFactory(viewModelFactory: makeViewModelFactory())
    }
    
    func makeViewModelFactory() -> ViewModelFactory {
        ViewModelFactory(remoteDataManager: remoteDataManager)
    }
}
