//
//  AvailabilityText.swift
//  X
//
//  Created by Manuel Crovetto on 29/09/2023.
//

import SwiftUI

struct AvailabilityText: View {
    
    var username: String
    var availability: AvailabilityEvents
    
    @ViewBuilder private var icon: some View {
        switch availability {
        case .notStarted:
            Image(systemName: "minus.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.gray)
        case .loading:
            ProgressView()
                .frame(width: 20, height: 20)
                
        case .available:
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.green)
        case .unavailable:
            Image(systemName: "x.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.red)
        }
        
    }
    
    @ViewBuilder private var textView: some View {
        switch availability {
        case .notStarted:
            Text("Check your username availability")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundStyle(.gray)
        case .loading:
            Text("Checking @\(username) availability...")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
        case .available:
            Text("@\(username) is available!")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(.green)
        case .unavailable:
            Text("@\(username) is not available.")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            icon
            textView
                .keyboardType(.default)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .animation(.easeIn, value: availability)
    }
}

#Preview {
    AvailabilityText(username: "@macro", availability: .available)
}
