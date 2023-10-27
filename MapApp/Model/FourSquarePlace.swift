//
//  FourSquareResult.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import Foundation

struct FourSquarePlace: Codable, Identifiable {
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

    struct Geocode: Codable, Identifiable {
        let id = UUID()
        let latitude: Double
        let longitude: Double
    }

    struct Location: Codable {
        let address: String?
        let address_extended: String?
        let country: String
        let formatted_address: String
        let locality: String?
        let postcode: String?
        let region: String?
    }

    let fsq_id: String
    var id: String { fsq_id }
    let categories: [Category]
    let chains: [Chain]?
    let distance: Int
    let geocodes: [String: Geocode]
    let link: String
    let location: Location
    let name: String
}
