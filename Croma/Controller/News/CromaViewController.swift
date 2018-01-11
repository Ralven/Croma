//
//  CromaViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/30/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import WebKit

class CromaViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let cromaURL = URL(string:"https://www.facebook.com/cromabeer")
        let cromaRequest = URLRequest(url: cromaURL!)
        webView.load(cromaRequest)
    }

}
