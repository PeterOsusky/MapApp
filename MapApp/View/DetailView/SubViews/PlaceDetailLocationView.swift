//
//  PlaceDetailLocationView.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailLocationView: View {
    var place: FoursquarePlace

    var body: some View {
        Group {
            Text(place.location.formatted_address)
            if let locality = place.location.locality, let region = place.location.region {
                Text("\(locality), \(region)")
            }
            Text(place.location.country)
        }
        .font(.subheadline)
        .foregroundColor(.gray)
    }
}
