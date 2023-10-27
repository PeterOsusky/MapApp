//
//  PlaceAnnotation.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var place: FourSquarePlace
    
    init(place: FourSquarePlace) {
        // Attempt to fetch the geocode
        if let geocode = place.geocodes.values.first {
            self.coordinate = CLLocationCoordinate2D(latitude: geocode.latitude, longitude: geocode.longitude)
        } else {
            // Provide a default value
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0) // Defaulting to 0,0
        }
        
        self.title = place.name
        self.place = place
        super.init()
    }
}
