//
//  MapView.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: viewModel.annotations) { item in
                MapMarker(coordinate: item.coordinate, tint: .blue)
            }
            .onTapGesture {
                viewModel.handleTap(coordinate: region.center)
            }
            .frame(height: UIScreen.main.bounds.height / 2)

            List(viewModel.places, id: \.fsq_id) { place in
                Text(place.name)
            }
            .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}
