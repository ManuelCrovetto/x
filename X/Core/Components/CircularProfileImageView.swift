//
//  CircularProfileImageView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct CircularProfileImageView: View {
    
    var url: String? = nil
    var width: CGFloat = 50
    var height: CGFloat = 50
    var uiImage: UIImage? = nil
    
    @ViewBuilder private var imageView: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .clipShape(Circle())
        } else {
            AsyncImage(url: URL(string: url ?? "")) { image in
                image.resizable()
                
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .padding(8)
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(Circle())
            }
        }
        
    }

    var body: some View {
        imageView
        .frame(width: width, height: height)
        .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
