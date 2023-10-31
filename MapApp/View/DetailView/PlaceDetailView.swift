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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.photos, id: \.id) { photo in
                            URLImageView(withURL: photo.fullURL)
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 10)
                }
                
                PlaceDetailGeocodeView(place: place)
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPhotos(for: place.id)
        }
    }
}
