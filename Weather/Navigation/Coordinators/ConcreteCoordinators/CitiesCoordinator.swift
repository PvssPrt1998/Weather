//
//  CitiesCoordinator.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import Foundation

final class CitiesCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    var viewControllerFactory: ViewControllerFactory
    
    init(router: Router, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.viewControllerFactory = viewControllerFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewControllerFactory.makeCitiesViewController(delegate: self), animated: animated, onDismissed: onDismissed)
    }
    
    func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }
}

extension CitiesCoordinator: CitiesViewControllerNavigationDelegate {
    func dismissAction() {
        dismiss(animated: true)
    }
}
