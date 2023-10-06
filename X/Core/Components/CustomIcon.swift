//
//  CustomIcon.swift
//  X
//
//  Created by Manuel Crovetto on 02/10/2023.
//

import SwiftUI

struct CustomIcon: View {
    
    var systemName: String
    var height: CGFloat = 24
    var width: CGFloat = 24
    var foregroundStyle: Color = .black
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .foregroundStyle(foregroundStyle)
    }
}
