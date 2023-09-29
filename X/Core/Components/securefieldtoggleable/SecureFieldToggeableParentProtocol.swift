//
//  SecureFieldToggeableParentProtocol.swift
//  X
//
//  Created by Manuel Crovetto on 28/09/2023.
//

import Foundation
protocol SecureFieldToggeableParentProtocol {
    /// Assign SecuredTextFieldView hideKeyboard method to this and
    /// then parent can excute it when needed..
    var hideKeyboard: (() -> Void)? { get set }
}
