//
//  RegistrationView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import Observation
import SwiftUI

struct RegistrationView: View {
    @Bindable var viewModel: RegistrationViewModel = RegistrationViewModel()
    @State private var presentSuccessDialog = false
    @State private var presentErrorDialog = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VScrollView {
            VStack {
                Spacer()
                Image(.xLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 32)

                VStack {
                    UsernameAvilabilityTextField(hint: "Username", text: $viewModel.userName, userAvailability: viewModel.usernameAvailability, icon: "at")
                        .padding(.bottom, 24)

                    TextFieldWithError(hint: "Enter your name", text: $viewModel.fullName, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.nameError, icon: "person.text.rectangle")
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                    TextFieldWithError(hint: "Enter your email", text: $viewModel.email, isError: viewModel.viewState.fieldsError, errorMessage: viewModel.viewState.emailError, icon: "envelope")
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                    SecureFieldToggeable(hint: "Password", text: $viewModel.password, icon: "lock")
                        .modifier(XTextFieldsModifiers())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)

                    SecureFieldToggeable(hint: "Repeat password", text: $viewModel.repeatedPassword, icon: "lock")
                        .modifier(XTextFieldsModifiers())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)

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
                    .foregroundStyle(.base)
                }
                .padding(.vertical)
            }
            .onChange(of: viewModel.userName) {
                viewModel.checkIfUserAlreadyExists()
            }
            .onChange(of: viewModel.viewState) {
                presentSuccessDialog = viewModel.viewState.success
                presentErrorDialog = viewModel.viewState.networkError
            }
            .alert("Regisration successful", isPresented: $presentSuccessDialog) {
                Button("Ok") {
                    dismiss()
                }
            } message: {
                Text("We've sent you a validation email. Please check your inbox or spam.")
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
}

#Preview {
    RegistrationView()
}
