//
//  LoginView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import Observation
import SwiftUI

struct LoginView: View {
    @Bindable var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VScrollView {
                VStack {
                    Spacer()
                    Image(.xLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 32)

                    VStack {
                        TextFieldWithError(hint: "Username", text: $viewModel.username, isError: viewModel.viewState.error, errorMessage: viewModel.viewState.userErrorDescription, icon: "person")
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()

                        SecureFieldToggeable(hint: "Password", text: $viewModel.password, icon: "lock")
                            .modifier(XTextFieldsModifiers())
                    }

                    NavigationLink {
                        ForgotPassword()
                            .navigationBarBackButtonHidden()

                    } label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                            .padding(.trailing, 28)
                            .foregroundStyle(.base)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    ButtonWithLoader(text: "Log in", isLoading: viewModel.viewState.loading) {
                        Task {
                            try await viewModel.login()
                        }
                    }
                    Spacer()
                    Divider()
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")

                            Text("Sign Up")
                                .fontWeight(.semibold)
                        }
                        .font(.footnote)
                        .foregroundStyle(.base)
                    }
                    .padding(.vertical, 16)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
