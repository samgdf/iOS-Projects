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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var address: UILabel!
    
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
    
    @IBAction func userLocation(_ sender: Any) {
        let center = currentLocation?.coordinate
        let region = MKCoordinateRegion(center: center!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
            if (error == nil) {
                if let addrList = placemarks?[0].addressDictionary?["FormattedAddressLines"] as? [String] {
                    let originAddress = addrList.joined(separator: ", ")
                    self.address.text = originAddress
                }
            }
            
        }
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
