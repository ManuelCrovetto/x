//
//  TextFieldWithError.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import SwiftUI

struct TextFieldWithError: View {
    
    var hint: String
    @Binding var text: String
    var isError: Bool
    var errorMessage: String
    var icon: String? = nil
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            textField.modifier(XTextFieldsModifiers())
            
            if isError {
                Text(errorMessage)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 32)
            }
        }
        .animation(.easeIn, value: errorMessage)
    }
}

