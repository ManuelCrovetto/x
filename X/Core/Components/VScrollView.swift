//
//  VScrollView.swift
//  X
//
//  Created by Manuel Crovetto on 30/09/2023.
//

import SwiftUI

struct VScrollView<Content>: View where Content: View {
    
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                content
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
