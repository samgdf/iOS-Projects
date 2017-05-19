//
//  ViewController.swift
//  Voltair
//
//  Created by Sam Goldfield on 5/17/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    var locationManager:CLLocationManager?
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather.forecast(withLocation: "40.428,-74.416") { (results:[Weather]) in
            for result in results {
                print("\(result)\n\n")
            }
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        enableLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func enableLocation() {
        locationManager?.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
        }
    }

}
