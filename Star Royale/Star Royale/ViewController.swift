//
//  ViewController.swift
//  Star Royale
//
//  Created by Sam Goldfield on 5/14/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var icon_1: UIImageView!
    @IBOutlet weak var recycle_1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            // which mean you are forced to use portrait.
            AppUtility.lockOrientation(.portrait)
        }
        
        func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // first parameter mean you will let user use again your customized orientation support. If the previous user screen is landscapeLeft, setting the second parameter to `.landscapeLeft ` will bring back to its previous landscape after disappear. This is really useful for best user experience.
            AppUtility.lockOrientation([.portrait,.landscapeLeft,.landscapeRight], andRotateTo: .landscapeLeft)
            
            // Thanks to you bmjohns
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct AppUtility {
        
        // This method will force you to use base on how you configure.
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        // This method done pretty well where we can use this for best user experience.
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            
            self.lockOrientation(orientation)
            
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
        
    }
    
    


}

