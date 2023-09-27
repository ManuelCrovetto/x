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
    
    
    
    func toggleDrawer(initiator: DrawerActionInitiator) {
        switch(initiator) {
        case .opening:
            if initiator == .opening && !isDrawerOpen {
                print("tool")
                isDrawerOpen = true
            }
        case .closing:
            if initiator == .closing && isDrawerOpen {
                print("parent")
                isDrawerOpen = false
            }
        }
    }
}
