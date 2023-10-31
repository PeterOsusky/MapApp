//
//  MapViewModel.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var places: [FoursquarePlace] = []

    private let foursquareService = FoursquareService()
    private var updateTimer: Timer?
    private var cancellables: Set<AnyCancellable> = []

    
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
    }
    
    func showPlaces(coordinate: CLLocationCoordinate2D) {
        foursquareService.fetchPlaceDetails(for: coordinate)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Failed to fetch place details: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.places = response.results
                print(response.results.count)
            })
            .store(in: &cancellables)
    }
}
