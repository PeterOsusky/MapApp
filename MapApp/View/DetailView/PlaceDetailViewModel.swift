//
//  PlaceDetailViewModel.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation
import Combine

class PlaceDetailViewModel: ObservableObject {
    @Published var photos: [FourSquarePhoto] = []
    @Published var isInternetError: Bool = false

    private var service: FoursquareService
    private var cancellables: Set<AnyCancellable> = []

    init(service: FoursquareService = FoursquareService()) {
        self.service = service
    }

    func fetchPhotos(for placeID: String) {
        service.fetchPhotos(for: placeID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch place details: \(error)")
                    if error.isNetworkError {
                        self.isInternetError = true
                    }  
                }
            }, receiveValue: { photos in
                self.photos = photos
            })
            .store(in: &cancellables)
    }
}
