//
//  ViewEx.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
           if condition {
               transform(self)
           } else {
               self
           }
       }
}
