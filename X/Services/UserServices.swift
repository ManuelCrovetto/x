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
    
    static let shared = UserServices()
    
    func checkUsernameAvailability(newUsername: String, doesExists: @escaping (Bool) -> ()) async throws {
        do {
            let usernameLowercased = newUsername.lowercased()
            let querySnapshot = try await db.collection("usernames").getDocuments()
            if querySnapshot.documents.isEmpty {
                doesExists(false)
                return
            } else {
                var usernamesList: [String] = []
                querySnapshot.documents.forEach { data in
                    usernamesList.append(data.documentID.lowercased())
                }
                doesExists(usernamesList.contains(usernameLowercased))
            }
        } catch {
            doesExists(true)
            print("ERROR in \(self): error attempting to get documents to check username availability.")
        }
    }
    
    func getUserData() async throws -> Response<UserData, ()> {
        let userId = AuthServices.shared.userSession?.uid
        if let userId = userId {
            let userQuerySnapshot = try await db.collection("users").document(userId).getDocument()
            return .success(try userQuerySnapshot.data(as: UserData.self))
        } else {
            return .error("\(self): UserId is nil.")
        }
    }
    
    
    private func setDocumentsData(document: DocumentReference, dataDictionaryList: [String: String]) async {
        do {
            try await document.setData(dataDictionaryList)
        } catch {
            print("ERROR in \(self): Error during setting data in the document: \(document.path), the following data: \(dataDictionaryList).")
        }
    }
}
