//
//  LoginView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI
import Observation

struct LoginView: View {
    
    @Bindable var viewModel = LoginViewModel()
    @State var test = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(.xLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                VStack {
                    TextFieldWithError(hint: "Username", text: $viewModel.username, isError: viewModel.viewState.error, errorMessage: viewModel.viewState.userErrorDescription)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                   
                    SecureField("Password", text: $viewModel.password)
                        .modifier(XTextFieldsModifiers())
                }
                
                NavigationLink {
                    Text("Forgot password")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 28)
                        .foregroundStyle(.black)
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
                    .foregroundStyle(.black)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
