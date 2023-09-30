//
//  XData.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct XData: Identifiable ,Codable {
    @DocumentID var id: String?
    let userId: String
    let date: String
    let body: String
    let nickName: String
    let imageUrl: String
    let username: String
    let reposts: [String]
    let comments: [XData]
    let likes: [String]
    
}
