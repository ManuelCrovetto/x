//
//  RegistrationViewState.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import Foundation
struct RegistrationViewState: Equatable {
    let loading: Bool
    var networkError: Bool
    var fieldsError: Bool
    let errorMessage: String
    let success: Bool
    let usernameError: String
    let nameError: String
    let emailError: String
    let passwordError: String
    
    
    init(loading: Bool = false, networkError: Bool = false, fieldsError: Bool = false, errorMessage: String = "", success: Bool = false, usernameError: String = "", nameError: String = "", emailError: String = "", passwordError: String = "") {
        self.loading = loading
        self.networkError = networkError
        self.fieldsError = fieldsError
        self.errorMessage = errorMessage
        self.success = success
        self.usernameError = usernameError
        self.nameError = nameError
        self.emailError = emailError
        self.passwordError = passwordError
        
        
    }
}
