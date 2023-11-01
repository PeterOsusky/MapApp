//
//  PlaceDetailImageScrollView.swift
//  MapApp
//
//  Created by Peter on 01/11/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailImageScrollView: View {
    @ObservedObject var viewModel: PlaceDetailViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.photos, id: \.id) { photo in
                    ImageView(url: photo.fullURL)
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct ImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 150, height: 150)
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
            @unknown default:
                EmptyView()
            }
        }
    }
}

