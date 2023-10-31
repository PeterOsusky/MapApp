//
//  FoursquarePhoto.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation

struct FourSquarePhoto: Codable {
    let id: String
    let created_at: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    let classifications: [String]?

    var fullURL: URL {
        return URL(string: "\(prefix)\(width)x\(height)\(suffix)")!
    }
}
