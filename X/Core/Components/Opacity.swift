//
//  Opacity.swift
//  X
//
//  Created by Manuel Crovetto on 28/09/2023.
//

import Foundation
enum Opacity: Double {
    case hide = 0.0
    case show = 1.0

    /// Toggle the field opacity.
    mutating func toggle() {
        switch self {
        case .hide:
            self = .show
        case .show:
            self = .hide
        }
    }
}
