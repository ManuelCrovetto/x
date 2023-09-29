//
//  LoginViewState.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import Foundation


struct LoginViewState: Equatable {
    let loading: Bool
    let error: Bool
    let success: Bool
    let userErrorDescription: String
    let passwordErrorDescription: String
    
    
    init(loading: Bool = false, error: Bool = false, success: Bool = false, userErrorDescription: String = "", passwordErrorDescription: String = "") {
        self.loading = loading
        self.success = success
        self.error = error
        self.userErrorDescription = userErrorDescription
        self.passwordErrorDescription = passwordErrorDescription
    }
}
