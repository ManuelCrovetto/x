//
//  XServices.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import FirebaseFirestore
import Foundation

class XServices {
    static let shared = XServices()
    private let db = Firestore.firestore()

    func createX(xData: XData) async -> Response<()> {
        if let userId = AuthServices.shared.userSession?.uid {
            let document = db.collection("users")
                .document(userId)
                .collection("xs")
                .document()
            
            await setDocumentData(documentReference: document, data: xData)
            return .success(())
        } else {
            return .error("\(self): UserID is nil.")
        }
    }

    func fetchXs() async throws -> Response<[XData]> {
        do {
            if let userId = AuthServices.shared.userSession?.uid {
                let xQuerySnapshots = try await db.collection("users").document(userId).collection("xs").limit(to: 10).getDocuments()
                let xDataList = mappedDocuments(documents: xQuerySnapshots.documents)
                if let xDataList = xDataList {
                    return .success(xDataList)
                } else {
                    return .error("Xs list is nil.")
                }
               
            } else {
                return .error("Error in \(self): UserID is nil")
            }
        } catch {
            print("\(self): Error during fetching Xs. Stacktrace: \(error)")
            return .error(error.localizedDescription)
        }
    }

    private func setDocumentData(documentReference: DocumentReference, data: XData) async {
        do {
            try documentReference.setData(from: data)
        } catch {
            print("\(self): error during creation of X document in Firebase. Stacktrace: \(error)")
        }
    }
    
    private func mappedDocuments(documents: [QueryDocumentSnapshot]) -> [XData]? {
        do {
            return try documents.map { document in
                try document.data(as: XData.self)
            }
        } catch {
            print("Error in \(self): Error during mapping documents to XData types. Stacktrace: \(error)")
            return nil
        }
    }
}
