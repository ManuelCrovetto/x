//
//  ProfileXsFilter.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import Foundation

enum ProfileXsFilter: Int, CaseIterable, Identifiable {
    case xs
    case replies
    
    var title: String {
        switch self {
        case.xs: return "Xs"
        case .replies: return "Replies"
        }
    }
    var id: Int { return self.rawValue }
}
