//
//  ViewController.swift
//  Snap Map Events Feature
//
//  Created by Vilde Vevatne on 05/08/2017.
//  Copyright © 2017 Vilde Vevatne. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
       locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

