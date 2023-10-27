//
//  PlaceDetailView.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailsView: View {
    var place: FourSquarePlace

    var body: some View {
        VStack {
            // Display the details of the place here, e.g.
            Text(place.name)
                .font(.headline)
            // Add more details as needed
        }
        .padding()
    }
}
