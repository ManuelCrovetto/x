//
//  XCreationViewState.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation

struct XCreationViewState: Codable {
    var loading: Bool
    var error: Bool
    var success: Bool
    var errorMessage: String
    
    init(loading: Bool = false, error: Bool = false, success: Bool = false, errorMessage: String = "") {
        self.loading = loading
        self.error = error
        self.success = success
        self.errorMessage = errorMessage
    }
}
