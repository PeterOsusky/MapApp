//
//  MapView.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import SwiftUI
import MapKit
import Combine


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: Constants.positionPrague,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var lastRegionCenter = Constants.positionPrague
    @State private var selectedPlace: FourSquarePlace?
    
    @StateObject var viewModel = MapViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("MapApp")
                    .font(.largeTitle)
                    .padding(.top)
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: viewModel.places) { place in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.geocodes.values.first?.latitude ?? 0, longitude: place.geocodes.values.first?.longitude ?? 0)) {
                        CustomAnnotationView(place: place, selectedPlace: $selectedPlace)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onChange(of: region.center.latitude) { _ in
                    if abs(lastRegionCenter.latitude - region.center.latitude) > 0.001 ||
                        abs(lastRegionCenter.longitude - region.center.longitude) > 0.001 {
                        viewModel.debounceUpdate(coordinate: region.center)
                        lastRegionCenter = region.center
                    }
                }
                Spacer()
                if let place = selectedPlace {
                    PlaceDetailsView(place: place)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }
}
