//
//  GoalsViewViewController.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/19/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class GoalsViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL = NSURL(fileURLWithPath: "/Users/samg/Downloads/kane.mp4")

        webView.loadHTMLString("<iframe width = \"\(webView.frame.width)\" height = \"<iframe height = \"\(webView.frame.height)\" src =\"\(fileURL)\"></iframe>", baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
