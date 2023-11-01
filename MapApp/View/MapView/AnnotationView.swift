//
//  AnnotationView.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import SwiftUI

struct AnnotationView: View {
    var place: FoursquarePlace
    @State private var isPopoverPresented = false

    var body: some View {
        Button(action: {
            self.isPopoverPresented = true
        }) {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
        }
        .sheet(isPresented: $isPopoverPresented) {
            PlaceDetailsView(place: place)
                .presentationDetents([.medium, .large])
        }
    }
}
