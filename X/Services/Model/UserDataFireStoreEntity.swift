//
//  UserData.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct UserDataFireStoreEntity: Identifiable, Codable {
    @DocumentID var id: String?
    let email: String
    let nickname: String
    let username: String
    let joinDate: Timestamp
    let bio: String
}
