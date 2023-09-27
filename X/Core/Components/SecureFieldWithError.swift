//
//  SecureFieldWithError.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import SwiftUI

struct SecureFieldWithError: View {
    var hint: String
    @Binding var text: String
    var isError: Bool
    var errorMessage: String
    
    var body: some View {
        VStack {
            SecureField(hint, text: $text)
                .modifier(XTextFieldsModifiers())
            if isError {
                Text(errorMessage)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                
            }
        }
    }
}
