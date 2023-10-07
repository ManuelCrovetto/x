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
    
    func checkUsernameAvailability(newUsername: String) async throws -> ExistsEvent {
        do {
            let usernameLowercased = newUsername.lowercased()
            let querySnapshot = try await db.collection("usernames").getDocuments()
            if querySnapshot.documents.isEmpty {
                return .noExists
            } else {
                var usernamesList: [String] = []
                querySnapshot.documents.forEach { data in
                    usernamesList.append(data.documentID.lowercased())
                }
                if usernamesList.contains(usernameLowercased) {
                    return .exists
                } else {
                    return .noExists
                }
            }
        } catch {
            print("ERROR in \(self): error attempting to get documents to check username availability.")
            return .exists
        }
    }
    
    func getUserData() async throws -> Response<UserDataFireStoreEntity, ()> {
        let userId = AuthServices.shared.userSession?.uid
        if let userId = userId {
            let userQuerySnapshot = try await db.collection("users").document(userId).getDocument()
            return .success(try userQuerySnapshot.data(as: UserDataFireStoreEntity.self))
        } else {
            return .error("\(self): UserId is nil.")
        }
    }
    
    func searchUsers(query: String) async -> Response<[UserData], ()> {
        do {
            let usersDocumentPath = db.collection("users")
            let listWithoutFollowingFlag = try await usersDocumentPath
                .whereField("username", isGreaterThanOrEqualTo: query.lowercased())
                .whereField("username", isLessThanOrEqualTo: query.lowercased() + "\u{f8ff}")
                .limit(to: 20)
                .getDocuments()
                .documents.map { document in
                    try document.data(as: UserDataFireStoreEntity.self)
                }
            let usersList = try await listWithoutFollowingFlag.asyncMap { userData in
                let followIdDocument = try await usersDocumentPath.document(AuthServices.shared.userSession?.uid ?? "").collection("follows").document(userData.id ?? "").getDocument()
                return UserData(id: userData.id.orEmpty(), email: userData.email, nickname: userData.nickname, username: userData.username, doesCurrentUserFollowsThisUser: followIdDocument.exists)
            }
            print("DEBG: \(usersList)")
            return .success(usersList)
        } catch {
            return .error("Error in \(self): searching users failed.")
        }
    }
    
    func followUser(userIdToFollow: String) async -> Response<(), ()> {
        do {
            if let userId = AuthServices.shared.userSession?.uid {
                try await db
                    .collection("users")
                    .document(userId)
                    .collection("follows")
                    .document(userIdToFollow)
                    .setData([ : ])
                return .success(())
            } else {
                return .error("Error in \(self): user id is nil.")
            }
        } catch {
            print("Error in \(self): follow user id action failed")
            return .error("")
        }
    }
    
    func unfollowUser(userIdToUnfollow: String) async -> Response<(),()>  {
        do {
            if let userId = AuthServices.shared.userSession?.uid {
                try await db.collection("users")
                    .document(userId)
                    .collection("follows")
                    .document(userIdToUnfollow)
                    .delete()
                return .success(())
            } else {
                return .error("Error in \(self): UserId is nil.")
            }
        } catch {
            print("Error in \(self): Unfollow request couldnt be completed.")
            return .error(error.localizedDescription)
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
