//
//  MapViewModel.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

class MapViewModel: ObservableObject {
    @Published var places: [FourSquarePlace] = []
    
    private let foursquareService = FoursquareService()
    private var updateTimer: Timer?
    
    init() {
        fetchInitialData()
    }
    
    func debounceUpdate(coordinate: CLLocationCoordinate2D) {
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.showPlaces(coordinate: coordinate)
        }
    }
    
    func fetchInitialData() {
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378) // Praha
        showPlaces(coordinate: defaultCoordinate)
        print("fetch init data")
    }
    
    func showPlaces(coordinate: CLLocationCoordinate2D) {
        foursquareService.fetchPlaceDetails(for: coordinate) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let results = response?.results {
                    self.places = results
                    print(results.count)
                    print(results)
                }
            }
        }
    }
}
