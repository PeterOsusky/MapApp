//
//  FoursquareService.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

class FoursquareService {
    
    private let baseURL = "https://api.foursquare.com/v3/places"
    private let authorizationToken = "fsq3BdIvFwpCKTGbZrBAlL8GKOC/cJtgB5prVWKIXyVd/I0="

    enum FoursquareError: Error {
        case invalidURL
        case networkError(Error)
        case decodingError(Error)
    }
    
    func fetchPlaceDetails(for location: CLLocationCoordinate2D, completion: @escaping (Result<FoursquareResponse, FoursquareError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/search?ll=\(location.latitude),\(location.longitude)") else {
            completion(.failure(.invalidURL))
            return
        }
        makeRequest(with: url, completion: completion)
    }
    
    func fetchPhotos(for placeID: String, completion: @escaping (Result<[FourSquarePhoto], FoursquareError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(placeID)/photos") else {
            completion(.failure(.invalidURL))
            return
        }
        makeRequest(with: url, completion: completion)
    }

    private func makeRequest<T: Codable>(with url: URL, completion: @escaping (Result<T, FoursquareError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(authorizationToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidURL)) // This can be another custom error indicating no data.
                return
            }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}

struct FoursquareResponse: Codable {
    let results: [FoursquarePlace]
}
