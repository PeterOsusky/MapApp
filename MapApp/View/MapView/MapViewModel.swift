//
//  MapViewModel.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    @Published var places: [FoursquarePlace] = []

    private let foursquareService = FoursquareService()
    private var updateTimer: Timer?
    
    init() {
        fetchInitialData()
    }
    
    func debounceUpdate(coordinate: CLLocationCoordinate2D) {
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
            self?.showPlaces(coordinate: coordinate)
        }
    }
    
    func fetchInitialData() {
        showPlaces(coordinate: Constants.positionPrague)
        print("fetch init data")
    }
    
    func showPlaces(coordinate: CLLocationCoordinate2D) {
        foursquareService.fetchPlaceDetails(for: coordinate) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.places = response.results
                    print(response.results.count)
                    
                case .failure(let error):
                    print("Failed to fetch place details: \(error)")
                }
            }
        }
    }
}
