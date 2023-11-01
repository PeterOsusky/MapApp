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
            .alert(isPresented: $viewModel.isInternetError) {
                Alert(
                    title: Text("Network Error"),
                    message: Text("No internet connection available."),
                    dismissButton: .default(Text("OK")) {
                        viewModel.isInternetError = false
                    }
                )
            }
        }
        .onAppear {
            viewModel.fetchPhotos(for: place.id)
        }
    }
}
