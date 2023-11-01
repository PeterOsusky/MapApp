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
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text("Latitude: \(mainGeocode.latitude)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Longitude: \(mainGeocode.longitude)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
