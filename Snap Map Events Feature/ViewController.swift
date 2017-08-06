//
//  ViewController.swift
//  Snap Map Events Feature
//
//  Created by Vilde Vevatne on 05/08/2017.
//  Copyright © 2017 Vilde Vevatne. All rights reserved.
//

import UIKit
import MapKit

var events = [Dictionary<String, String>()]

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if events.count == 1 && events[0].count == 0 {
            events.remove(at: 0)
            events.append(["name": "Lady Gaga at AT&T Park", "lat": "37.77860146512109", "lon": "-122.38928318023682"])
            if let name = events[0]["name"] {
                if let lat = events[0]["lat"] {
                    if let lon = events[0]["lon"] {
                        if let latitude  = Double(lat) {
                            if let longitude = Double(lon) {
                                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                let region = MKCoordinateRegion(center: coordinate, span: span)
                                self.map.setRegion(region, animated: true)
                                let annotation = MKPointAnnotation()
                            }
                        }
                    }
                }
            }
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            print(newCoordinate)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = "Temp Title"
            self.map.addAnnotation(annotation)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
            self.map.removeAnnotations(self.map.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "Your Location"
            self.map.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

