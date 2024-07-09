//
//  WeatherCoordinator.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

final class WeatherCoordinator: Coordinator {
    
    var children: Array<Coordinator> = []
    var router: Router
    var viewControllerFactory: ViewControllerFactory
    
    weak var delegate: WeatherCoordinatorDelegate?
    
    init(router: Router, viewControllerFactory: ViewControllerFactory, delegate: WeatherCoordinatorDelegate) {
        self.router = router
        self.viewControllerFactory = viewControllerFactory
        self.delegate = delegate
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewControllerFactory.makeWeahterViewController(delegate: self), animated: true, onDismissed: onDismissed)
    }
    
    func dismiss(animated: Bool) { }
}

extension WeatherCoordinator: WeatherViewControllerNavigationDelegate {
    func cityButtonPressed(_ parentViewController: WeatherViewController, onDismiss: @escaping () -> Void) {
        guard let delegate = delegate else { return }
        presentChild(delegate.makeCitiesCoordinator(parentViewController), animated: true, onDismissed: onDismiss)
    }
}

protocol WeatherCoordinatorDelegate: AnyObject {
    func makeCitiesCoordinator(_ viewController: WeatherViewController) -> Coordinator
}

