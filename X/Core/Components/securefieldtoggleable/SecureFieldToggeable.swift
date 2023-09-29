//
//  SecureFieldToggeable.swift
//  X
//
//  Created by Manuel Crovetto on 28/09/2023.
//

import SwiftUI

struct SecureFieldToggeable: View {
    
    @State private var isHashed = true
    var hint: String
    @Binding var text: String
    var icon: String? = nil
    
    @ViewBuilder private var toggleButton: some View {
        Button {
            withAnimation(.easeIn) {
                isHashed.toggle()
            }
        } label: {
            Image(systemName: isHashed ? "eye.slash" : "eye")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder private var textField: some View {
        if icon != nil {
            HStack(spacing: 8) {
                Image(systemName: icon ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray)
                TextField(hint, text: $text)
            }
        } else {
            TextField(hint, text: $text)
        }
    }
        
    
    @ViewBuilder private var secureField: some View {
        if icon == nil {
            SecureField(hint, text: $text)
        } else {
            HStack(spacing: 8) {
                Image(systemName: icon ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray)
                SecureField(hint, text: $text)
            }
        }
    }

    var body: some View {
        Group {
            if isHashed {
               secureField
                    .overlay(
                        toggleButton,
                        alignment: .trailing
                    )
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                    
            } else {
                textField
                    .overlay(
                        toggleButton,
                        alignment: .trailing
                    )
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                    
            }
        }
        
    }
}


