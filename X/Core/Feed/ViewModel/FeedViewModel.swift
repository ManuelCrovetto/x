//
//  FeedViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import Observation

@Observable class FeedViewModel {
    
    private var fetchJob: Task<Void, Never>? = nil
    var xDataList: [XData] = []
    
    init() {
        fetchXs()
    }
    
    func fetchXs() {
        fetchJob?.cancel()
        fetchJob = Task {
            do {
                let response = try await XServices.shared.fetchXs()
                switch response {
                case .error(_):
                    print("\(self): Error fetching Xs.")
                    
                case let .success(xDataList):
                    self.xDataList = xDataList
                    
                }
            } catch {
                print("\(self): Error in Task of function fetchXs.")
            }
            
        }
    }
}
