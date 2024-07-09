//
//  Router.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

public protocol Router {
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (()->Void)?)
    func dismiss(animated: Bool)
}

extension Router {
    public func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: true, onDismissed: nil)
    }
}


