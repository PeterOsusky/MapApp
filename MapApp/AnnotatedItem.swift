//
//  AnnotatedItem.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

struct AnnotatedItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
