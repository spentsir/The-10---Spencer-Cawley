//
//  UIImageView Extension.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/22/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func applyShadow() {
        layer.shadowColor     = UIColor.black.cgColor
        layer.shadowOffset    = CGSize(width: 0.0, height: 9.0)
        layer.shadowRadius    = 5
        layer.shadowOpacity   = 0.5
    }
}
