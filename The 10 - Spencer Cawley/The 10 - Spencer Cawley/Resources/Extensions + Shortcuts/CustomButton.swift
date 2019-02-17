//
//  CustomButton.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        
    }
    
    func setupButton() {
        setShadow()
        setGradientBackground(colorOne: Colors.red, colorTwo: .yellow)
        setTitleColor(Colors.veryDarkGrey, for: .normal)
        layer.cornerRadius      = frame.height/2
        layer.borderWidth       = 3.0
        layer.borderColor       = UIColor.darkGray.cgColor
//        clipsToBounds = true
    }

    private func setShadow() {
        layer.shadowColor       = UIColor.black.cgColor
        layer.shadowOffset      = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius      = 8
        layer.shadowOpacity     = 0.5
//        clipsToBounds           = true
//        layer.masksToBounds     = false
    }
}
