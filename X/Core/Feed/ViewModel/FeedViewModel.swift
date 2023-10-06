//
//  FeedViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import Observation
import FirebaseFirestore
@Observable class FeedViewModel {
    
    private var fetchJob: Task<Void, Never>? = nil
    private var handleXActionJob: Task<Void, Never>? = nil
    var viewState = XFeedViewState()
    var xDataList: [XData] = []
    var followsList: [String] = []
    var showsProgressViewInCenter = true
    var isLoadingMoreTweets = false
    var xPayload = 10
    var lastDocument: QueryDocumentSnapshot? = nil
    
    init() {
        fetchXs()
    }
    
    func fetchXs() {
        fetchJob?.cancel()
        fetchJob = Task {
            viewState = XFeedViewState(loading: true)
            let response = await XServices.shared.fetchXs(payload: xPayload, lastDocument: nil)
            switch response {
            case .error(_):
                print("\(self): Error fetching Xs.")
                viewState = XFeedViewState(error: true, errorMessage: "Oops, we got an error, please try again.")
            case let .success(xDataAndLastDocument, followsList):
                self.xDataList.append(contentsOf: xDataAndLastDocument.xData)
                self.lastDocument = xDataAndLastDocument.lastDocument
                self.followsList = followsList ?? []
                viewState = XFeedViewState(success: true)
            }
        }
    }
    
    func shouldLoadMoreTweets(xId: String) {
        if let index: Int = xDataList.firstIndex(where: {$0.id == xId})  {
            if index+1 == xPayload {
                xPayload += 10
                showsProgressViewInCenter = false
                fetchXs()
            }
        } else {
            print("aha")
        }
        
    }
    
    func handleXAction(actions: XActions) {
        handleXActionJob?.cancel()
        handleXActionJob = Task {
            switch actions {
            case .deleteX(userId: let userId, xId: let xId):
                switch await XServices.shared.deleteX(userId: userId, xId: xId) {
                case .error(_):
                    viewState = XFeedViewState(error: true, errorMessage: "Oops, we got an error, please try again.")
                case .success(_, _):
                    fetchXs()
                    viewState = XFeedViewState(success: true)
                }
            case .unfollow(userId: let userId):
                switch await XServices.shared.unfollowUser(userIdToUnfollow: userId) {
                case .error(_):
                    viewState = XFeedViewState(error: true, errorMessage: "Unfollow request couldn't be processed. Please try again.")
                case .success(_, _):
                    break
                }
            case .follow(userId:  _):
                //pending
                break
            }
        }
    }
    
    func checkIfItsOwnX(userId: String) -> Bool {
        return AuthServices.shared.userSession?.uid == userId
    }
    
    func checkIfCurrentUserFollowsXOwner(userId: String) -> Bool {
        return followsList.contains(userId)
    }
}
