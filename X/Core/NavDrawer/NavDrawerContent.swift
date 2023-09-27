//
//  NavDrawerContent.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct NavDrawerContent: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Text("Profile")
                .fontWeight(.semibold)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavDrawerContent()
}
