//
//  ForgotPasswordViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 29/09/2023.
//

import Foundation
import Observation

@Observable class ForgotPasswordViewModel {
    
    var email: String = ""
    var isError: Bool = false
    var errorMessage: String = ""
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    private var sendEmailTask: Task<Void, Never>? = nil
    
    func sendPasswordRecoveryEmail() {
        isLoading = true
        if email.isValidEmail() {
            AuthServices.shared.resetPassword(email: email) { [weak self] isCompleted in
                self?.isLoading = false
                if isCompleted {
                    self?.isSuccess = true
                    self?.isError = false
                } else {
                    self?.isSuccess = false
                    self?.isError = true
                    self?.errorMessage = "Oh no, we have an error. Please retry."
                }
            }
        } else {
            isLoading = false
            isError = true
            errorMessage = "Please provide a valid email"
        }
    }
}
