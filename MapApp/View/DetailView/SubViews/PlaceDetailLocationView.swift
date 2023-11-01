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
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.gray)
                Text(place.location.formatted_address)
            }
            
            if let locality = place.location.locality, let region = place.location.region {
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.gray)
                    Text("\(locality), \(region)")
                }
            }
            
            HStack {
                Image(systemName: "flag.fill")
                    .foregroundColor(.gray)
                Text(place.location.country)
            }
        }
        .font(.subheadline)
        .foregroundColor(.gray)
    }
}
