//
//  UIButton Ext.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/24/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

extension UIButton {
    func updateButtonViews() {
        setTitleColor(Colors.veryDarkGrey, for: .normal)
        setTitleColor(Colors.white, for: .highlighted)
        backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        layer.cornerRadius = 25
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowColor = UIColor.black.cgColor
    }
}
