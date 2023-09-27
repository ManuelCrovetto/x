//
//  RegistrationView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI
import Observation

struct RegistrationView: View {
    @Bindable var viewModel: RegistrationViewModel = RegistrationViewModel()
    @State private var presentSuccessDialog = false
    @State private var presentErrorDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image(.xLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            VStack {
                TextFieldWithError(hint: "Enter your username", text: $viewModel.userName, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.usernameError)
                    
                TextFieldWithError(hint: "Enter your name", text: $viewModel.fullName, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.nameError)
                    
                TextFieldWithError(hint: "Enter your email", text: $viewModel.email, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.emailError)
                    
                    .textInputAutocapitalization(.none)
                    
                SecureFieldWithError(hint: "Password", text: $viewModel.password, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.passwordError)
                SecureFieldWithError(hint: "Repeat password", text: $viewModel.repeatedPassword, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.passwordError)
                    
                
                ButtonWithLoader(text: "Sign up", isLoading: viewModel.viewState.loading, action: {
                    Task {
                        try await viewModel.createUser()
                    }
                })
                .padding(.vertical)
            }
            Spacer()
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundStyle(.black)
            }
            .padding(.vertical)
        }
        .onChange(of: viewModel.viewState) {
            presentSuccessDialog = viewModel.viewState.success
            presentErrorDialog = viewModel.viewState.networkError
        }
        .alert("Regisration successful", isPresented: $presentSuccessDialog) {
            Button("Ok") {
                dismiss()
            }
        }
        .alert("Oops...", isPresented: $presentErrorDialog) {
            Button("Ok") {
                dismiss()
            }
        } message: {
            Text(viewModel.viewState.errorMessage)
        }

    }
}

#Preview {
    RegistrationView()
}
