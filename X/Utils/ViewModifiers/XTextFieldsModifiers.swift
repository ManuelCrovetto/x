//
//  TextFieldsModifiers.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct XTextFieldsModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 32)
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}

struct XPlainTextFieldsModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 32)
            .font(.subheadline)
    }
}
