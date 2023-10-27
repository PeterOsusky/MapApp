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
        center: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378), // Praha
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var lastRegionCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378)
    
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: viewModel.places.compactMap { $0.geocodes.values.first }) { geocode in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: geocode.latitude, longitude: geocode.longitude), tint: .red)
            }
            .onAppear {
                viewModel.debounceUpdate(coordinate: region.center)
            }
            .onChange(of: region.center.latitude) { _ in
                if abs(lastRegionCenter.latitude - region.center.latitude) > 0.001 ||
                   abs(lastRegionCenter.longitude - region.center.longitude) > 0.001 {
                    viewModel.debounceUpdate(coordinate: region.center)
                    lastRegionCenter = region.center
                }
            }
        }
    }
}
