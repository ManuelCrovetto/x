//
//  XCreationViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import Observation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

@Observable class XCreationViewModel {
    
    var viewState = XCreationViewState()
    var userData: UserDataFireStoreEntity? = nil
    var xBody: String = ""
    
    private var createXJob: Task<Void, Never>? = nil
    private var getUserDataJob: Task<Void, Never>? = nil
    
    init() {
        Task {
            await getUserData()
        }
        
    }
    
    func createX() {
        if xBody.isEmpty {
            viewState = XCreationViewState(error: true, errorMessage: "We're sure you have something else to say.")
            return
        }
        createXJob?.cancel()
        createXJob = Task {
            viewState = XCreationViewState(loading: true)
            guard let userData = await provideUserData() else {
                return
            }
            self.userData = userData
            let xData = XData(userId: AuthServices.shared.userSession?.uid ?? "", date: Timestamp(date: Date.now), body: xBody, nickName: userData.nickname, imageUrl: "", username: userData.username, reposts: [], comments: [], likes: [])
            let response = await XServices.shared.createX(xData: xData)
            switch response {
            case .error(_):
                viewState = XCreationViewState(error: true, errorMessage: "Oops, seems like we got an error. Please try again.")
            case .success(_, _):
                viewState = XCreationViewState(success: true)
            }
        }
    }
    
    func getUserData() async {
        guard let userData = await provideUserData() else {
            viewState = XCreationViewState(error: true, errorMessage: "Seems we have an error, please re-open this dialog.")
            return
        }
        self.userData = userData
    }
    
    private func provideUserData() async -> UserDataFireStoreEntity? {
        do {
            let response = try await UserServices.shared.getUserData()
            switch response {
                
            case .error(_):
                viewState = XCreationViewState(error: true, errorMessage: "We got an error, please try again.")
                print("\(self): error during fetching user's data.")
                return nil
            case let .success(userData, _):
                return userData
            }
        } catch {
            print("\(self): error during fetching user's data.")
            return nil
        }
    }
}
