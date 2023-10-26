//
//  FourSquare.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

class FoursquareService {
    
    private let authorizationToken = "fsq3BdIvFwpCKTGbZrBAlL8GKOC/cJtgB5prVWKIXyVd/I0="

    func fetchVenueDetails(for location: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.foursquare.com/v3/places/search?ll=\(location.latitude),\(location.longitude)") else {
            completion(nil)
            return
        }
        
        print(url)
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(authorizationToken, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Networking error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                print(data)
                let response = try decoder.decode(FourSquareResponse.self, from: data)
                print(response)
            } catch let error {
                print("Error decoding: \(error)")
            }
        }

        dataTask.resume()
    }
}

struct FourSquareResult: Codable {
    struct Category: Codable {
        let id: Int
        let name: String
        let short_name: String
        let plural_name: String
        let icon: Icon
    }

    struct Icon: Codable {
        let prefix: String
        let suffix: String
    }

    struct Chain: Codable {
        let id: String
        let name: String
    }

    struct Geocode: Codable {
        let latitude: Double
        let longitude: Double
    }

    struct Location: Codable {
        let address: String?
        let address_extended: String?
        let country: String
        let formatted_address: String
        let locality: String
        let postcode: String?
        let region: String
    }

    let fsq_id: String
    let categories: [Category]
    let chains: [Chain]?
    let distance: Int
    let geocodes: [String: Geocode]
    let link: String
    let location: Location
    let name: String
}

struct FourSquareResponse: Codable {
    let results: [FourSquareResult]
}
