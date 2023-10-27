//
//  FoursquareService.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation
import CoreLocation

class FoursquareService {
    
    private let authorizationToken = "fsq3BdIvFwpCKTGbZrBAlL8GKOC/cJtgB5prVWKIXyVd/I0="

    func fetchPlaceDetails(for location: CLLocationCoordinate2D, completion: @escaping (FourSquareResponse?) -> Void) {
        guard let url = URL(string: "https://api.foursquare.com/v3/places/search?ll=\(location.latitude),\(location.longitude)") else {
            completion(nil)
            return
        }
        
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
                let response = try decoder.decode(FourSquareResponse.self, from: data)
                completion(response)
            } catch let error {
                print("Error decoding: \(error)")
                completion(nil)
            }
        }

        dataTask.resume()
    }
}

struct FourSquareResponse: Codable {
    let results: [FourSquarePlace]
}
