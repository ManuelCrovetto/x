//
//  XDataAndLastDocument.swift
//  X
//
//  Created by Manuel Crovetto on 05/10/2023.
//

import Foundation
import FirebaseFirestore
struct XDataAndLastDocument {
    let lastDocument: QueryDocumentSnapshot?
    let xData: [XData]
    
    init(lastDocument: QueryDocumentSnapshot?, xData: [XData]) {
        self.lastDocument = lastDocument
        self.xData = xData
    }
}
