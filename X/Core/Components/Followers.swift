//
//  Followers.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct Followers: View {
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Text("1k")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Following")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            HStack(spacing: 4) {
                Text("10k")
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
    Followers()
}
