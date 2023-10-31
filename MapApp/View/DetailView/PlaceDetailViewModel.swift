//
//  PlaceDetailViewModel.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var photos: [FourSquarePhoto] = []
    private var service: FoursquareService

    init(service: FoursquareService = FoursquareService()) {
        self.service = service
    }

    func fetchPhotos(for placeID: String) {
        service.fetchPhotos(for: placeID) { result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self.photos = photos
                }
            case .failure(let error):
                print("Failed to fetch photos: \(error.localizedDescription)")
            }
        }
    }
}
