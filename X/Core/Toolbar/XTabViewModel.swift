//
//  XTabViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import Foundation
import Observation

@Observable class XTabViewModel {
    
    var isDrawerOpen = false
    var hasAppearedOnce = false
    
    var isPresentingDrawerNavigations = false
    
    
    func assignOffset(width: CGFloat) -> CGFloat {
        return if isPresentingDrawerNavigations {
            1000
        } else {
            300
        }
    }
    
    func getDetailedUserData() {
        AuthServices.shared.fetchUsersDetailedData()
    }
    
}
