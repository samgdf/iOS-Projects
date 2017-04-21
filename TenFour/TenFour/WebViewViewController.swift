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
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBAction func sharePressed(_ sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: ["\(url!)"], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil	)
    }
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webview.loadRequest(URLRequest(url: URL(string: url!)!))
        
        navigationBar.topItem!.title = "\(url!)"

        
    }

}
