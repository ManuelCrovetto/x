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
    var usernameAvailability: AvailabilityEvents = .notStarted
    
    private var checkUsernameAvailabilityJob: Task<Void, Never>? = nil

    func createUser() async throws {
        print("\(self): creation user started...")
        viewState = RegistrationViewState(loading: true)

        if validateUserData() {
            let response = try await AuthServices.shared.createUser(withEmail: email
                                                                    , password: password
                                                                    , fullname: fullName
                                                                    , username: userName)

            switch response {
            case let .error(errorMessage):
                viewState = RegistrationViewState(networkError: true, errorMessage: errorMessage)
            case .success:
                viewState = RegistrationViewState(success: true)
                resetFields()
            }
        } else {
            print("\(self): Registration data is not valid.")
        }
    }

    private func validateUserData() -> Bool {
        if userName.count < 4 {
            viewState = RegistrationViewState(fieldsError: true, usernameError: "Username must contain 4 letters as minimum")
            return false
        }
        if usernameAvailability != .available {
            print("\(self): username is not available. status: \(usernameAvailability)")
            viewState = RegistrationViewState()
            return false
        }

        if fullName.count < 4 {
            viewState = RegistrationViewState(fieldsError: true, nameError: "Name must contain 4 letters as minimum")
            return false
        }

        if !email.isValidEmail() {
            viewState = RegistrationViewState(fieldsError: true, emailError: "Provide a valid email")
            return false
        }

        if password.count < 6 && repeatedPassword.count < 6 {
            viewState = RegistrationViewState(fieldsError: true, passwordError: "Password must contain 6 characters as minimum")
            return false
        }

        if password != repeatedPassword {
            viewState = RegistrationViewState(fieldsError: true, passwordError: "Passwords don't match")
            return false
        }

        return true
    }

    private func resetFields() {
        email = ""
        password = ""
        repeatedPassword = ""
        fullName = ""
        userName = ""
    }
    
    func checkIfUserAlreadyExists() {
        if userName.isEmpty {
            usernameAvailability = .notStarted
            return
        }
        checkUsernameAvailabilityJob?.cancel()
        checkUsernameAvailabilityJob = Task { [weak self] in
            do {
                await self?.updateUsernameAvailability(.loading)
                try await Task.sleep(seconds: 2)
                if self?.userName.isEmpty == true {
                    await self?.updateUsernameAvailability(.notStarted)
                    return
                }
                switch try await UserServices.shared.checkUsernameAvailability(newUsername: self?.userName ?? "") {
                case .exists:
                    await self?.updateUsernameAvailability(.unavailable)
                case .noExists:
                    await self?.updateUsernameAvailability(.available)
                }
            } catch {
                self?.usernameAvailability = .unavailable
                print("\(String(describing: self)): error during check of username availability... stacktrace: \(error)")
            }
        }
    }
    
    @MainActor
    private func updateUsernameAvailability(_ availabilityEvent: AvailabilityEvents) {
        self.usernameAvailability = availabilityEvent
    }
    
}
