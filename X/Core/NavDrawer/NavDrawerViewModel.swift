//
//  NavDrawerViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import Foundation
import Observation

@Observable class NavDrawerViewModel {
    
    
    
    func signOut() {
        do {
            try AuthServices.shared.signOut()
        } catch {
            
        }
        
    }
}
