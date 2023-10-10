//
//  UserData.swift
//  X
//
//  Created by Manuel Crovetto on 06/10/2023.
//

import Foundation

struct UserData {
    let id: String
    let email: String
    let nickname: String
    let username: String
    let doesCurrentUserFollowsThisUser: Bool
    let bio: String
    
    init(id: String, email: String, nickname: String, username: String, doesCurrentUserFollowsThisUser: Bool, bio: String) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.username = username
        self.doesCurrentUserFollowsThisUser = doesCurrentUserFollowsThisUser
        self.bio = bio
    }
}
