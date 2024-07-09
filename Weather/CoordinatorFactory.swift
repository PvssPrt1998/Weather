//
//  CoordinatorFactory.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class CoordinatorFactory {
    
    var mainCoordinator: WeatherCoordinator!
    let router: Router
    let viewControllerFactory: ViewControllerFactory
    
    init(router: Router, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.viewControllerFactory = viewControllerFactory
    }
    
    func makeWeatherCoordinator() -> WeatherCoordinator {
        mainCoordinator = .init(router: router, viewControllerFactory: viewControllerFactory, delegate: self)
        return mainCoordinator
    }
}

extension CoordinatorFactory: WeatherCoordinatorDelegate {
    func makeCitiesCoordinator(_ viewController: WeatherViewController) -> Coordinator {
        CitiesCoordinator(router: ModalPresentationRouter(parentViewController: viewController), viewControllerFactory: viewControllerFactory)
    }
}
