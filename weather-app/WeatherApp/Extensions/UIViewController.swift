//
//  UIViewController+Extension.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    static func loadXib<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        return T(nibName: "\(self)", bundle: bundle)
    }
    
    
    
    func showAlert(with error: Error, action: (() -> ())? = nil) {
        showAlert(title: "ERROR".localized(), message: error.localizedDescription, action: action)
    }
    
    func showAlert(title: String, message: String, action: (() -> ())?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "CLOSE".localized(), style: .default, handler: { _ in
            if let action = action {
                action()
            }
        }))
        present(alertViewController, animated: true, completion: nil)
    }
    

    func showActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .blue
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }

    
}
