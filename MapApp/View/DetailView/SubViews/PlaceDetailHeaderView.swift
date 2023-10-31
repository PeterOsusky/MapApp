//
//  PlaceDetailHeaderView.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailHeaderView: View {
    var place: FoursquarePlace

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
        }
    }
}
