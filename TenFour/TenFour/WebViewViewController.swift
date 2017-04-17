//
//  WebViewViewController.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/5/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webview.loadRequest(URLRequest(url: URL(string: url!)!))
        
    }

}
