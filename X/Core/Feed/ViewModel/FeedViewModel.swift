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
    
    func fetchXs(refetchXs: Bool = false) {
        fetchJob?.cancel()
        fetchJob = Task { [weak self] in
            await self?.updateViewState(XFeedViewState(loading: true))
            if refetchXs {
                self?.lastDocument = nil
            }
            let response = await XServices.shared.fetchXs(payload: self?.xPayload ?? 10, lastDocument: self?.lastDocument)
            switch response {
            case .error(_):
                print("\(String(describing: self)): Error fetching Xs.")
                await self?.updateViewState(XFeedViewState(error: true, errorMessage: "Oops, we got an error, please try again."))
            case let .success(xDataAndLastDocument, followsList):
                await self?.updateFeedData(refetched: refetchXs, xList: xDataAndLastDocument.xData)
                
                self?.lastDocument = xDataAndLastDocument.lastDocument
                await self?.updateFollowsList(followsList: followsList)
                await self?.updateViewState(XFeedViewState(success: true))
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
        handleXActionJob = Task { [weak self] in
            switch actions {
            case .deleteX(userId: let userId, xId: let xId):
                switch await XServices.shared.deleteX(userId: userId, xId: xId) {
                case .error(_):
                    await self?.updateViewState(XFeedViewState(error: true, errorMessage: "Oops, we got an error, please try again."))
                case .success(_, _):
                    self?.fetchXs()
                    await self?.updateViewState(XFeedViewState(success: true))
                }
            case .unfollow(userId: let userId):
                switch await UserServices.shared.unfollowUser(userIdToUnfollow: userId) {
                case .error(_):
                    await self?.updateViewState(XFeedViewState(error: true, errorMessage: "Unfollow request couldn't be processed. Please try again."))
                case .success(_, _):
                    self?.fetchXs(refetchXs: true)
                    break
                }
            case .follow(userId:  _):
                //pending
                break
            }
        }
    }
    
    @MainActor
    private func updateViewState(_ viewState: XFeedViewState) {
        self.viewState = viewState
    }
    
    @MainActor
    private func updateFeedData(refetched: Bool, xList: [XData]) {
        if refetched {
            self.xDataList = xList
        } else {
            self.xDataList.append(contentsOf: xList)
        }
        
    }
    
    @MainActor
    private func updateFollowsList(followsList: [String]?) {
        self.followsList = followsList ?? []
    }
    
    func checkIfItsOwnX(userId: String) -> Bool {
        return AuthServices.shared.userSession?.uid == userId
    }
    
    func checkIfCurrentUserFollowsXOwner(userId: String) -> Bool {
        return followsList.contains(userId)
    }
    
    func timeAgoPosted(_ timestamp: Timestamp) -> String {
        let currentDate = Timestamp(date: Date())
        let timeIntervalSincePosted = currentDate.dateValue().timeIntervalSince(timestamp.dateValue())
        let secondsPassed = Int(timeIntervalSincePosted)
        var timeAgo = ""
        if secondsPassed < 60 {
            timeAgo = "\(secondsPassed)s ago"
        }
        if secondsPassed > 60 {
            let mins = Int(ceil(Double(secondsPassed / 60)))
            timeAgo = "\(mins)m ago"
        }
        if secondsPassed > 3600 {
            let hours = Int(ceil(Double(secondsPassed / 3600)))
            timeAgo = "\(hours)h ago"
        }
        if secondsPassed > 86400 {
            let days = Int(ceil(Double(secondsPassed / 86400)))
            timeAgo = "yesterday"
        }
        if secondsPassed > 172800 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.string(from: timestamp.dateValue())
            timeAgo = date
        }
        return timeAgo
    }
}
