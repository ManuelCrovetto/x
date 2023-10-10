//
//  EmptyView.swift
//  X
//
//  Created by Manuel Crovetto on 06/10/2023.
//

import SwiftUI

struct EmptyView: View {
    
    var onAction: () -> ()
    
    var body: some View {
        VStack(spacing: 24) {
            Image(.emptyIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
                .foregroundStyle(.base)
            Text("Ouh, no news going on...")
                .font(.title2)
                .fontWeight(.medium)
                
            Button {
                onAction()
            } label: {
                HStack {
                    CustomIcon(systemName: "magnifyingglass", height: 16, width: 16, foregroundStyle: .surface)
                    Text("Explore")
                }
                .foregroundStyle(.surface)
            }
        }
    }
}

#Preview {
    EmptyView {
        
    }
}
