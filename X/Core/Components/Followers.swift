//
//  Followers.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct Followers: View {
    
    var follows: Int
    var followers: Int
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Text(follows.description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Following")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            HStack(spacing: 4) {
                Text(followers.description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Followers")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    Followers(follows: 5, followers: 10000)
}
