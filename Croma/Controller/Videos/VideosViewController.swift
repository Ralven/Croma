//
//  VideosViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/30/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import WebKit

class VideosViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var webView1: WKWebView!
    @IBOutlet weak var webView2: WKWebView!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideos()
    }
    
    //MARK: Methods
    func loadVideos(){
        var url = URL(string: "https://www.youtube.com/embed/tXiSKaqrFm4")
        var request = URLRequest(url: url!)
        webView1.load(request)
        url = URL(string:"https://www.youtube.com/embed/oVG47IdwZO0")
        request = URLRequest(url: url!)
        webView2.load(request)
    }
    
}

//MARK: Extension for Style Overrides
extension VideosViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
