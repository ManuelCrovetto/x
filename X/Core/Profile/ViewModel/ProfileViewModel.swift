//
//  ProfileViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 10/10/2023.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable class ProfileViewModel {
    
    func provideJoinedDateFormatted(joinedDate: Timestamp?) -> String {
        guard let joinedDate else { return "" }
        return joinedDate.formatToJoinDate()
    }
}
