//
//  EditProfileViewState.swift
//  X
//
//  Created by Manuel Crovetto on 14/10/2023.
//

import Foundation
struct EditProfileViewState: Equatable {
    let loading: Bool
    let error: Bool
    let success: Bool
    let nicknameErrorDescription: String
    let bioErrorDescription: String
    let pictureErrorDescription: String
    let nameError: Bool
    let bioError: Bool
    let pictureError: Bool
    let finalErrorDescription: String
    
    
    
    init(loading: Bool = false, error: Bool = false, success: Bool = false, nicknameErrorDescription: String = "", bioErrorDescription: String = "", pictureErrorDescription: String = "", nameError: Bool = false, bioError: Bool = false, pictureError: Bool = false, finalErrorDescription: String = "") {
        self.loading = loading
        self.error = error
        self.success = success
        self.nicknameErrorDescription = nicknameErrorDescription
        self.bioErrorDescription = bioErrorDescription
        self.pictureErrorDescription = pictureErrorDescription
        self.nameError = nameError
        self.bioError = bioError
        self.pictureError = pictureError
        self.finalErrorDescription = finalErrorDescription
    }
}
