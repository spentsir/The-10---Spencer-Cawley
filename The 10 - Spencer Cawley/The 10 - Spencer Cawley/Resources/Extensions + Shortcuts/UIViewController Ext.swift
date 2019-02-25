//
//  UIViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/22/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func showSafariVC(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func playMovie(with key: String) {
        showSafariVC(url: "https://www.youtube.com/embed/\(key)")
    }
}
