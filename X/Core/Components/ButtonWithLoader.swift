//
//  ButtonWithLoader.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import SwiftUI

struct ButtonWithLoader: View {
    
    var text: String
    var isLoading: Bool
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                Text(text)
                    .padding(.vertical, 16)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    
            }
            .frame(maxWidth: .infinity)
            .background(isLoading ? .gray : .surface)
            .cornerRadius(8)
            .disabled(isLoading)
            .padding(.horizontal, 24)
            
        }
        .animation(.easeIn, value: isLoading)
    }
}
