//
//  ImageView.swift
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
    
    init(withURL url: URL) {
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: self.uiImage ?? UIImage(systemName: "photo")!) // Use a placeholder image if the image hasn't loaded.
            .resizable()
            .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }.resume()
    }
}
