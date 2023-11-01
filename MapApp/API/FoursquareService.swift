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

    enum FoursquareError: Error, LocalizedError {
        case invalidURL
        case networkError(Error)
        case decodingError(Error)
        case responseError(statusCode: Int)
        case unknownError
        
        var isNetworkError: Bool {
            if case .networkError = self {
                return true
            }
            return false
        }

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL."
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
            case .decodingError(let error):
                return "Decoding error: \(error.localizedDescription)"
            case .responseError(let statusCode):
                return "HTTP Status: \(statusCode)."
            case .unknownError:
                return "An unknown error occurred."
            }
        }
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
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw FoursquareError.responseError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                return data
            }
            .mapError { error in
                if let error = error as? FoursquareError {
                    return error
                }
                return .networkError(error)
            }
            .flatMap { data -> AnyPublisher<T, FoursquareError> in
                let decoder = JSONDecoder()
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError { .decodingError($0) }
                    .eraseToAnyPublisher()
            }
            .catch { error -> AnyPublisher<T, FoursquareError> in
                return Fail(outputType: T.self, failure: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

struct FoursquareResponse: Codable {
    let results: [FoursquarePlace]
}



