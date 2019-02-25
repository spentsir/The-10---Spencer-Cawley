//
//  ErrorAlert.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/22/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

extension Error {
    
    func customAlert(with message: String) {
        let alertController = UIAlertController(title: "Uh-Oh!", message: message, preferredStyle: .alert)
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootVC as? UINavigationController {
            rootVC = navigationController.viewControllers.first
        }
        
        if let tabBarController = rootVC as? UITabBarController {
            rootVC = tabBarController.selectedViewController
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        rootVC?.present(alertController, animated: true, completion: nil)
    }
}

