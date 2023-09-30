//
//  UserData.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Identifiable, Codable {
    @DocumentID var id: String?
    let email: String
    let nickname: String
    let username: String
}
