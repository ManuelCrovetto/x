//
//  UsernameAvilabilityTextField.swift
//  X
//
//  Created by Manuel Crovetto on 29/09/2023.
//

import SwiftUI

struct UsernameAvilabilityTextField: View {
    var hint: String
    @Binding var text: String
    var userAvailability: AvailabilityEvents
    
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
        VStack(alignment: .leading, spacing: 8) {
            textField
                .modifier(XTextFieldsModifiers())
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.default)
            HStack {
                Spacer()
                AvailabilityText(username: text, availability: userAvailability)
                    .padding(.trailing, 32)
            }
            
        }
    }
}

#Preview {
    UsernameAvilabilityTextField(hint: "Username", text: .constant(""), userAvailability: .available, icon: "at")
}
