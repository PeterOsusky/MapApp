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
            Text(place.name)
                .font(.headline)
        }
        .padding()
    }
}
