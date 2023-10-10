//
//  UserDetailedData.swift
//  X
//
//  Created by Manuel Crovetto on 07/10/2023.
//

import Foundation
import FirebaseFirestore
struct UserDetailedData {
    let userData: UserData
    let followsCount: Int
    let followersCount: Int
    let joinedDate: Timestamp
    
    init(userData: UserData, followsCount: Int, followersCount: Int, joinedDate: Timestamp) {
        self.userData = userData
        self.followsCount = followsCount
        self.followersCount = followersCount
        self.joinedDate = joinedDate
    }
}
