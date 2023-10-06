//
//  Response.swift
//  X
//
//  Created by Manuel Crovetto on 25/09/2023.
//

import Foundation
enum Response<T, R> {
    case error(String)
    case success(T, aditional: R? = nil)
}
