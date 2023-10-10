//
//  TimestampEx.swift
//  X
//
//  Created by Manuel Crovetto on 10/10/2023.
//

import Foundation
import FirebaseFirestore
extension Timestamp {
    func formatToJoinDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: self.dateValue())
    }
    
    func formatToNormalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self.dateValue())
    }
}
