//
//  ContentViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import Foundation
import Observation
import Firebase

@Observable class ContentViewModel {
    
    var userSession: FirebaseAuth.User? = nil
    var isShowingDrawer = false
    
    init() {
        getUserSession()
    }
    
    private func getUserSession() {
        userSession = AuthServices.shared.userSession
    }
}
