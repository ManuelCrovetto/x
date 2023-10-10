//
//  ExploreViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 06/10/2023.
//

import Foundation
import Observation

@Observable class ExploreViewModel {
    
    var query = ""
    var usersList: [UserData] = []
    var viewState = ExploreViewState()
    
    private var searchUsersJob: Task<Void, Never>? = nil
    
    func searchUsers() {
        searchUsersJob?.cancel()
        searchUsersJob = Task { [weak self] in
            do {
                await self?.updateViewState(viewState: ExploreViewState(loading: true))
                try await Task.sleep(seconds: 0.5)
                switch await UserServices.shared.searchUsers(query: self?.query ?? "") {
                case .error(_) :
                
                    await self?.updateViewState(viewState: ExploreViewState(error: true, errorMessage: "Error during searching users, please try again."))
                case let .success(users, _):
                    await self?.updateUsers(users: users)
                    await self?.updateViewState(viewState: ExploreViewState(success: true))
                }
            } catch {
               // this will catch the task cancellation error. So basically do nothing.
            }
            
        }
    }
    
    @MainActor
    private func updateViewState(viewState: ExploreViewState) {
        self.viewState = viewState
    }
    
    @MainActor
    private func updateUsers(users: [UserData]) {
        self.usersList = users
    }
    
    func followAction(followAction: UserActions) {
        Task {
            switch followAction {
            case let .follow(userId):
                switch await UserServices.shared.followUser(userIdToFollow: userId) {
                case .error(_):
                    break
                case .success(_, _):
                    searchUsers()
                    break
                }
            case let .unfollow(userId):
                switch await UserServices.shared.unfollowUser(userIdToUnfollow: userId) {
                case .error(_):
                    break
                case .success(_, _):
                    searchUsers()
                    break
                }
            case .viewProfile(_):
                break
            }
        }
        
    }
    
    func isCurrentUser(userId: String) -> Bool {
        return AuthServices.shared.userSession?.uid == userId
    }
    
}
