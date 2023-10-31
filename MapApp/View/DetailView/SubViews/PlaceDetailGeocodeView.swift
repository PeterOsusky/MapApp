//
//  PlaceDetailGeocodeView.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailGeocodeView: View {
    var place: FoursquarePlace

    var body: some View {
        if let mainGeocode = place.geocodes["main"] {
            Text("Latitude: \(mainGeocode.latitude)")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("Longitude: \(mainGeocode.longitude)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
