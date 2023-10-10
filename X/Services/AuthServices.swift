//
//  AuthServices.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import Observation

@Observable class AuthServices {
    var userSession: FirebaseAuth.User?
    var userDetails: UserDetailedData?
    private var db = Firestore.firestore()

    static let shared = AuthServices()

    init() {
        userSession = Auth.auth().currentUser
        fetchUsersDetailedData()
    }

    func login(withEmail email: String, password: String) async throws -> Response<User, Void> {
        do {
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            if !loginResult.user.isEmailVerified {
                try await sendVerificationEmail(user: loginResult.user)
                try Auth.auth().signOut()
                return Response.error("Your e-mail is not verified, please verify your e-mail. We just sent you a verification email.")
            }
            userSession = loginResult.user
            return Response.success(loginResult.user)
        } catch {
            return Response.error("")
        }
    }

    func signOut() throws {
        do {
            try Auth.auth().signOut()
            userSession = nil
        } catch {
            print(error.localizedDescription)
        }
    }

    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws -> Response<Bool, Void> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("\(self): User with email created.")
            let document = db.collection("users").document(result.user.uid)
            let dataDictionaryList: [String: Any] = [
                "email": email,
                "nickname": fullname,
                "username": username,
                "bio": "",
                "joinDate": Timestamp(date: Date.now),
            ]
            await setDocumentsData(document: document, dataDictionaryList: dataDictionaryList)

            try await db.collection("usernames").document(username).setData([:])
            print("\(self): Username added...")
            try await sendVerificationEmail(user: result.user)
            print("\(self): Verification email sent..")
            try Auth.auth().signOut()
            return Response.success(true)
        } catch {
            print("\(self): Failed to create user with error \(error.localizedDescription)")
            return Response.error(error.localizedDescription)
        }
    }

    func resetPassword(email: String, onCompletion: @escaping (Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("ERROR in \(self): Error resetting password: Stacktrace: \(error)")
                onCompletion(false)
            } else {
                onCompletion(true)
            }
        }
    }

    func fetchUsersDetailedData() {
        Task { [weak self] in
            do {
                if let userId = self?.userSession?.uid {
                    let userReference = self?.db.collection("users").document(userId)
                    let userDataEntity = try await self?.db.collection("users").document(userId).getDocument().data(as: UserDataFireStoreEntity.self)
                    let followersCount = try await userReference?.collection("followers").getDocuments().count
                    let followsCount = try await userReference?.collection("follows").getDocuments().count
                    let userData = UserData(
                        id: userDataEntity?.id ?? "",
                        email: userDataEntity?.email ?? "",
                        nickname: userDataEntity?.nickname ?? "",
                        username: userDataEntity?.username ?? "",
                        doesCurrentUserFollowsThisUser: false,
                        bio: userDataEntity?.bio ?? ""
                    )
                    let userDetailedData = UserDetailedData(
                        userData: userData,
                        followsCount: followsCount ?? 0,
                        followersCount: followersCount ?? 0,
                        joinedDate: userDataEntity?.joinDate ?? Timestamp(date: Date.now)
                    )
                    await self?.setUsersDetailedData(userDetailedData: userDetailedData)
                }
            } catch {
                print("Error in \(String(describing: self)): fetching user detailed data failed. Error: \(error)")
            }
        }
    }

    @MainActor
    private func setUsersDetailedData(userDetailedData: UserDetailedData) {
        userDetails = userDetailedData
    }

    private func setDocumentsData(document: DocumentReference, dataDictionaryList: [String: Any]) async {
        do {
            try await document.setData(dataDictionaryList)
        } catch {
            print("ERROR in \(self): Error during setting data in the document: \(document.path), the following data: \(dataDictionaryList).")
        }
    }

    private func sendVerificationEmail(user: User) async throws {
        do {
            try await user.sendEmailVerification()
        } catch {
            print("ERROR in \(self): Sending email verification failed.")
        }
    }
}
