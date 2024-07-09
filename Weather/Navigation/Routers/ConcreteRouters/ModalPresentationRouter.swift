//
//  ModalPresentationRouter.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

final class ModalPresentationRouter: NSObject, Router {
    
    public unowned let parentViewController: UIViewController
    
    private var customModalTransitioningDelegate: UIViewControllerTransitioningDelegate?
    private var onDismiss: (() -> Void)?
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismiss = onDismissed
        viewController.presentationController?.delegate = self
        parentViewController.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        
        guard let onDismiss = onDismiss else { return }
        onDismiss()
        self.onDismiss = nil
        parentViewController.dismiss(animated: animated)
    }
}

extension ModalPresentationRouter: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismiss(animated: true)
    }
}
