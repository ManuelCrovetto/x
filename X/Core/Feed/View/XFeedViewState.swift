//
//  XFeedViewState.swift
//  X
//
//  Created by Manuel Crovetto on 02/10/2023.
//

import Foundation

struct XFeedViewState: Equatable {
    let loading: Bool
    let error: Bool
    let success: Bool
    let errorMessage: String
    
    init(loading: Bool = false, error: Bool = false, success: Bool = false, errorMessage: String = "") {
        self.loading = loading
        self.error = error
        self.success = success
        self.errorMessage = errorMessage
    }
}
