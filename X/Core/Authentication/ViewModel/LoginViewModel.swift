//
//  LoginViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import Foundation
import Observation

@Observable class LoginViewModel {
    
    var viewState = LoginViewState()
    var username: String = ""
    var password: String = ""
    var genericError: String = "Username or password not valid"
    
    func login() async throws {
        viewState = LoginViewState(loading: true)
        if validateFields() {
            let result = try await AuthServices.shared.login(withEmail: username, password: password)
            switch (result) {
            case let .error(errorMessage):
                viewState = LoginViewState(error: true, userErrorDescription: errorMessage.isEmpty ? genericError : errorMessage)
            case .success(_):
                viewState = LoginViewState(success: true)
            }
        }
    }
    
    private func validateFields() -> Bool {
        if !username.isValidEmail() {
            viewState = LoginViewState(error: true, userErrorDescription: genericError)
            return false
        }
        
        if password.count < 6 {
            viewState = LoginViewState(error: true, userErrorDescription: genericError)
            return false
        }
        
        return true
    }
    
}
