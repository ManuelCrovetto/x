//
//  NavDrawer.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct NavDrawer: View {
   
    private let width = UIScreen.main.bounds.width - 100
    private var vm = NavDrawerViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack() {
                NavDrawerHeader {
                    vm.signOut()
                }
                NavDrawerContent()
                Spacer()
            }
        }
    }
}

#Preview {
    NavDrawer()
}
