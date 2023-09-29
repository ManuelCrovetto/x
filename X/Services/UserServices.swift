//
//  UserServices.swift
//  X
//
//  Created by Manuel Crovetto on 29/09/2023.
//

import Foundation
import FirebaseFirestore

class UserServices {
    
    private let db = Firestore.firestore()
    private var doesUserIdExists = false
    
    static let shared = UserServices()
    
    func checkUsernameAvailability(newUsername: String, doesExists: @escaping (Bool) -> ()) async throws {
        db.collection("usernames").getDocuments { querySnapshot, error in
           if let error {
               doesExists(true)
               print("Error getting users documents. Error: \(error)")
           } else {
               if let querySnapshot {
                   var usernames: [String] = []
                   for document in querySnapshot.documents {
                       let id = document.documentID
                       usernames.append(id)
                   }
                   doesExists(usernames.contains(newUsername))
                
               } else {
                   doesExists(false)
               }
           }
       }
    }
}
