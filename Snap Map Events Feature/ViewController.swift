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
        map.delegate = self
        map.showsUserLocation = true
//        if events.count == 1 && events[0].count == 0 {
//            events.remove(at: 0)
//            events.append(["name": "Lady Gaga at AT&T Park", "lat": "37.77860146512109", "lon": "-122.38928318023682"])
//            if let name = events[0]["name"] {
//                if let lat = events[0]["lat"] {
//                    if let lon = events[0]["lon"] {
//                        if let latitude  = Double(lat) {
//                            if let longitude = Double(lon) {
//                                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                                let region = MKCoordinateRegion(center: coordinate, span: span)
//                                self.map.setRegion(region, animated: true)
//                                let annotationForEvent = MKPointAnnotation()
//                            }
//                        }
//                    }
//                }
//            }
//        }
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
            let annotation = EventAnnotation(title: "Concert", subtitle: "", coordinate: newCoordinate)
            self.map.addAnnotation(annotation)
        }
    }
    var currentLocation:CLLocationCoordinate2D?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            self.currentLocation = center 
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
//            self.map.removeAnnotations(self.map.annotations)
            
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = center
//            annotation.title = "Your Location"
//            self.map.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Number of Annotations == \(mapView.annotations.count)")
        print("Type of annotation == \(type(of: annotation))")
        if annotation.isKind(of: MKUserLocation.self) {
            let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Your Location")
            
            //resize image
            let image = UIImage(named: "Avatar")!
            let size = CGSize(width: 31.3, height: 73.4)
            UIGraphicsBeginImageContext(size)
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage  = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            pinView.image = resizedImage
            return pinView
        } else if annotation.isKind(of: EventAnnotation.self) {
            let pinView = EventAnnotationView(annotation: annotation, reuseIdentifier: "EventAnnotation")
            let image = UIImage(named: "Concert")!
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            pinView.image = resizedImage
            pinView.canShowCallout = true
            return pinView
        }
        return nil
    }


}

