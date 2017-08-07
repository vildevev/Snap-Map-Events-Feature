//
//  EventAnnotation.swift
//  Snap Map Events Feature
//
//  Created by Vilde Vevatne on 07/08/2017.
//  Copyright © 2017 Vilde Vevatne. All rights reserved.
//

import Foundation
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
