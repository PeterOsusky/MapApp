//
//  CustomAnnotationView.swift
//  MapApp
//
//  Created by Peter on 27/10/2023.
//

import Foundation
import SwiftUI

struct CustomAnnotationView: View {
    var place: FourSquarePlace
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
        .popover(isPresented: $isPopoverPresented) {
            PlaceDetailsView(place: place)
        }
    }
}

