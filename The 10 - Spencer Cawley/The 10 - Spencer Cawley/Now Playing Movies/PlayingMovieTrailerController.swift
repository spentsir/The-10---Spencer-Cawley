//
//  PlayingMovieTrailerController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/16/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import WebKit

class PlayingMovieTrailerController: UIViewController, WKNavigationDelegate {
    
    var url: URL!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
