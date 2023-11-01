//
//  PlaceDetailView.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailsView: View {
    var place: FoursquarePlace
    @ObservedObject var viewModel = PlaceDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                PlaceDetailHeaderView(place: place)
                PlaceDetailLocationView(place: place)
                PlaceDetailImageScrollView(viewModel: viewModel)                
                PlaceDetailGeocodeView(place: place)
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPhotos(for: place.id)
        }
    }
}
