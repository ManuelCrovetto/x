//
//  AuthServices.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import Foundation
import FirebaseAuth
import Observation
import FirebaseFirestore

@Observable class AuthServices {
    
    var userSession: FirebaseAuth.User? = nil
    private var db = Firestore.firestore()
    
    static let shared = AuthServices()
    
    
    init() {
        
        self.userSession = Auth.auth().currentUser
    }
    
    
    func login(withEmail email: String, password: String) async throws -> Response<User, ()> {
        do {
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            if !loginResult.user.isEmailVerified {
                try await sendVerificationEmail(user: loginResult.user)
                try Auth.auth().signOut()
                return Response.error("Your e-mail is not verified, please verify your e-mail. We just sent you a verification email.")
            }
            self.userSession = loginResult.user
            return Response.success(loginResult.user)
        } catch {
            return Response.error("")
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws -> Response<Bool, ()> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("\(self): User with email created.")
            let document = db.collection("users").document(result.user.uid)
            let dataDictionaryList = [
                "email": email,
                "nickname": fullname,
                "username": username
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
    
    func resetPassword(email: String, onCompletion: @escaping (Bool) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("ERROR in \(self): Error resetting password: Stacktrace: \(error)")
                onCompletion(false)
            } else {
                onCompletion(true)
                
            }
        }
    }
    
    private func setDocumentsData(document: DocumentReference, dataDictionaryList: [String: String]) async {
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
