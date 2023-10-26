//
//  ContentView.swift
//  MapApp
//
//  Created by Peter on 26/10/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
