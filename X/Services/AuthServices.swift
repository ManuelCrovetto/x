//
//  AuthServices.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import Foundation
import FirebaseAuth
import Observation

@Observable class AuthServices {
    
    var userSession: FirebaseAuth.User? = nil
    
    static let shared = AuthServices()
    
    init() {
        
        self.userSession = Auth.auth().currentUser
    }
    
    
    func login(withEmail email: String, password: String) async throws -> Response<User> {
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
    
    
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws -> Response<Bool> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await sendVerificationEmail(user: result.user)
            try Auth.auth().signOut()
            userSession = nil
            return Response.success(true)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            return Response.error(error.localizedDescription)
        }
    }
    
    func sendVerificationEmail(user: User) async throws {
        do {
            try await user.sendEmailVerification()
        } catch {
            print("DEBUG: Sending email verification failed.")
        }
        
    }
}
