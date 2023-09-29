//
//  ForgotPassword.swift
//  X
//
//  Created by Manuel Crovetto on 29/09/2023.
//

import SwiftUI

struct ForgotPassword: View {
    
    @Bindable private var vm = ForgotPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment:.leading, spacing: 16) {
            
            Text("No worries.")
                .font(.title)
                .fontWeight(.medium)
                .padding(.horizontal, 24)
            Text("Type your e-mail below and we will send you password recovery instructions.")
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 24)
            TextFieldWithError(hint: "E-mail", text: $vm.email, isError: vm.isError, errorMessage: vm.errorMessage, icon: "envelope")
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding(.bottom, 24)
            ButtonWithLoader(text: "Send", isLoading: vm.isLoading) {
                vm.sendPasswordRecoveryEmail()
            }
                
        }
        .alert("Recover password instructions sent ✅", isPresented: $vm.isSuccess) {
            Button("Ok") {
                dismiss()
            }
        }
        .navigationTitle("Forgot password?")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ForgotPassword()
}
