//
//  FoursquareService.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation
import Combine

class FoursquareService {
    
    private let baseURL = "https://api.foursquare.com/v3/places"
    private let authorizationToken = "fsq3BdIvFwpCKTGbZrBAlL8GKOC/cJtgB5prVWKIXyVd/I0="

    enum FoursquareError: Error {
        case invalidURL
        case networkError(Error)
        case decodingError(Error)
    }
    
    func fetchPlaceDetails(for location: CLLocationCoordinate2D) -> AnyPublisher<FoursquareResponse, FoursquareError> {
        guard let url = URL(string: "\(baseURL)/search?ll=\(location.latitude),\(location.longitude)") else {
            return Fail(outputType: FoursquareResponse.self, failure: FoursquareError.invalidURL).eraseToAnyPublisher()
        }
        return makeRequest(with: url)
    }

    func fetchPhotos(for placeID: String) -> AnyPublisher<[FourSquarePhoto], FoursquareError> {
        guard let url = URL(string: "\(baseURL)/\(placeID)/photos") else {
            return Fail(outputType: [FourSquarePhoto].self, failure: FoursquareError.invalidURL).eraseToAnyPublisher()
        }
        return makeRequest(with: url)
    }

    private func makeRequest<T: Codable>(with url: URL) -> AnyPublisher<T, FoursquareError> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(authorizationToken, forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { .networkError($0) }
            .flatMap { data, _ -> AnyPublisher<T, FoursquareError> in
                let decoder = JSONDecoder()
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError { .decodingError($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

struct FoursquareResponse: Codable {
    let results: [FoursquarePlace]
}
