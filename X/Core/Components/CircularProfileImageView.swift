//
//  CircularProfileImageView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct CircularProfileImageView: View {
    
    var url: String? = nil

    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { image in
            image.resizable()
            
        } placeholder: {
            Image(systemName: "person")
                .resizable()
                .padding(8)
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
