//
//  PlaceDetailView.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailsView: View {
    var place: FoursquarePlace
    @ObservedObject var viewModel = DetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                // 1. Place Name & Categories
                Text(place.name)
                    .font(.largeTitle)
                    .padding(.top)
                
                HStack {
                    ForEach(place.categories.prefix(3), id: \.id) { category in
                        Text(category.name)
                            .font(.subheadline)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                // 2. Location Details
                Group {
                    Text(place.location.formatted_address)
                    if let locality = place.location.locality, let region = place.location.region {
                        Text("\(locality), \(region)")
                    }
                    Text(place.location.country)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                
                // 3. Photos (Horizontal scroll)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.photos, id: \.id) { photo in
                            URLImageView(withURL: photo.fullURL)
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 10)
                }
                
                // 4. Geolocation
                if let mainGeocode = place.geocodes["main"] {
                    Text("Latitude: \(mainGeocode.latitude)")
                    Text("Longitude: \(mainGeocode.longitude)")
                }
                
                // 5. More Information
                Group {
                    if let chains = place.chains, !chains.isEmpty {
                        Text("Part of chains: \(chains.map { $0.name }.joined(separator: ", "))")
                    }
                    Link("More Details", destination: URL(string: place.link)!)
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPhotos(for: place.id)
        }
    }
}
