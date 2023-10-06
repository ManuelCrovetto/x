//
//  StringEx.swift
//  X
//
//  Created by Manuel Crovetto on 02/10/2023.
//

import Foundation
extension String? {
    func orEmpty() -> String {
        return self ?? ""
    }
}
