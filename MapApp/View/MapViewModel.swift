//
//  MapViewModel.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

class MapViewModel: ObservableObject {
    @Published var annotations: [AnnotatedItem] = []
    @Published var places: [FourSquareResult] = []

    private let foursquareService = FoursquareService()
    
    func handleTap(coordinate: CLLocationCoordinate2D) {
        annotations.append(AnnotatedItem(coordinate: coordinate))
        
        foursquareService.fetchVenueDetails(for: coordinate) { [weak self] response in
            guard let self = self else { return }
            
            if let results = response?.results {
                self.places = results
                print(self.places)
            }
        }
    }
}
