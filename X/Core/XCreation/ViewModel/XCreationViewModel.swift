//
//  XCreationViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import Observation
import FirebaseAuth

@Observable class XCreationViewModel {
    
    var viewState = XCreationViewState()
    var user: User? = nil
    var xBody: String = ""
    
    private var createXJob: Task<Void, Never>? = nil
    private var getUserDataJob: Task<Void, Never>? = nil
    
    init() {
        getUserData()
    }
    
    func createX() {
        if xBody.isEmpty {
            viewState = XCreationViewState(error: true, errorMessage: "We're sure you have something else to say.")
            return
        }
        createXJob?.cancel()
        createXJob = Task {
            let xData = XData(userId: user?.uid ?? "", date: Date.now.description, body: xBody)
            let response = await XServices.shared.createX(xData: xData)
            switch response {
            case .error(_):
                viewState = XCreationViewState(error: true, errorMessage: "Oops, seems like we got an error. Please try again.")
            case .success():
                viewState = XCreationViewState(success: true)
            }
        }
    }
    
    func getUserData() {
        if let user = AuthServices.shared.userSession {
            self.user = user
        } else {
            viewState = XCreationViewState(error: true, errorMessage: "We got an error. Please try again.")
        }
    }
}
