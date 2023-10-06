//
//  XActions.swift
//  X
//
//  Created by Manuel Crovetto on 02/10/2023.
//

import Foundation

enum XActions {
    case deleteX(userId: String, xId: String)
    case unfollow(userId: String)
    case follow(userId: String)
}
