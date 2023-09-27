//
//  RegistrationViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import Foundation
import Observation

@Observable class RegistrationViewModel {
    
    var email = ""
    var password = ""
    var repeatedPassword = ""
    var fullName = ""
    var userName = ""
    var viewState = RegistrationViewState()
    
    
    func createUser() async throws {
        viewState = RegistrationViewState(loading: true)
        
        if validateUserData() {
            let response = try await AuthServices.shared.createUser(withEmail: email
                                                                    , password: password
                                                                    , fullname: fullName
                                                                    , username: userName)
        
            switch(response) {
            case let .error(errorMessage):
                viewState = RegistrationViewState(networkError: true, errorMessage: errorMessage)
            case .success(_):
                viewState = RegistrationViewState(success: true)
                resetFields()
            }
        }
    }
    
    private func validateUserData() -> Bool {
        if userName.count < 4 {
            viewState = RegistrationViewState(fieldsError: true, usernameError: "Username must contain 4 letters as minimum")
            return false
        }
        
        if fullName.count < 4 {
            viewState = RegistrationViewState(fieldsError: true, nameError: "Name must contain 4 letters as minimum")
            return false
        }
        
        if !isValidEmail(email: email) {
            viewState = RegistrationViewState(fieldsError: true, emailError: "Provide a valid email")
            return false
        }
        
        if password.count < 6 && repeatedPassword.count < 6{
            viewState = RegistrationViewState(fieldsError: true, passwordError: "Password must contain 6 characters as minimum")
            return false
        }
        
        if password != repeatedPassword {
            viewState = RegistrationViewState(fieldsError: true, passwordError: "Passwords don't match")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func resetFields() {
        email = ""
        password = ""
        repeatedPassword = ""
        fullName = ""
        userName = ""
    }
    
}
