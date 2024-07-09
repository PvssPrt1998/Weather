//
//  NavigationRouter.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

class NavigationRouter: NSObject, Router {
    
    public let window: UIWindow?
    private var viewController: UIViewController?
    private var onDismiss: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismiss = onDismissed
        self.viewController = viewController
        self.window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool) {
        guard let viewController = viewController else { return }
        performOnDismissed(for: viewController)
        viewController.dismiss(animated: animated)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismiss else { return }
        onDismiss()
        self.onDismiss = nil
    }
}
