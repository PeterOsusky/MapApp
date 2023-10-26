//
//  ContentView.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378), // Praha as default point
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var annotations: [AnnotatedItem] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { item in
            MapMarker(coordinate: item.coordinate, tint: .blue)
        }
        .onTapGesture(perform: handleTap)
    }

    private let foursquareService = FoursquareService()

    func handleTap() {
        annotations.append(AnnotatedItem(coordinate: region.center))
        
        foursquareService.fetchVenueDetails(for: region.center) { info in
            print(info)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
