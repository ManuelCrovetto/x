//
//  ContentView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                XTabView()
            }
        }
        .animation(.easeIn, value: viewModel.userSession)
    }
}

#Preview {
    ContentView()
}
