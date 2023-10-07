//
//  FollowActions.swift
//  X
//
//  Created by Manuel Crovetto on 06/10/2023.
//

import Foundation

enum UserActions {
    case follow(userId: String)
    case unfollow(userId: String)
    case viewProfile(userId: String)
}
