//
//  URLImageView.swift
//  MapApp
//
//  Created by Peter on 31/10/2023.
//

import Foundation
import SwiftUI
import Combine

struct URLImageView: View {
    @State private var uiImage: UIImage? = nil
    private let url: URL
    @State private var cancellable: AnyCancellable?

    init(withURL url: URL) {
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: self.uiImage ?? UIImage(systemName: "photo")!)
            .resizable()
            .onAppear(perform: loadImage)
            .onDisappear(perform: cancelImageLoading)
    }
    
    func loadImage() {
        cancellable = Future<Data, Error> { promise in
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    promise(.success(data))
                } else if let error = error {
                    promise(.failure(error))
                }
            }.resume()
        }
        .map { UIImage(data: $0) }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Image loading failed: \(error)")
            }
        }, receiveValue: { image in
            self.uiImage = image
        })
    }

    func cancelImageLoading() {
        cancellable?.cancel()
    }
}
