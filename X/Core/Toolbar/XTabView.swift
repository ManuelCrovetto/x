//
//  XTabView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI
import Observation
struct XTabView: View {

    @State private var selectedTab = 0
    @State private var isCreateXPresented = false
    @State private var viewModel = XTabViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isDrawerOpen {
                NavDrawer()
            }
            
            TabView(selection: $selectedTab) {
                FeedView().tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                
                .onAppear {
                    selectedTab = 0
                }
                .tag(0)
                ExploreView().tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear {
                    selectedTab = 1
                }
                .tag(1)
                Text("").tabItem {
                    Image(systemName: "plus")
                }
                .onAppear {
                    selectedTab = 2
                }
                .tag(2)
                ActivityView().tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 3
                }
                .tag(3)
                ProfileView().tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 4
                }
                .tag(4)
            }
            .if(viewModel.isDrawerOpen) { view in
                view.onTapGesture {
                    withAnimation(.spring) {
                        viewModel.isDrawerOpen.toggle()
                    }
                    
                }
            }
            .cornerRadius(viewModel.isDrawerOpen ? 20 : 10)
            .offset(x: viewModel.isDrawerOpen ? 300 : 0, y: viewModel.isDrawerOpen ? 44 : 0)
            .scaleEffect(viewModel.isDrawerOpen ? 0.8 : 1)
            .onChange(of: selectedTab) {
                isCreateXPresented = selectedTab == 2
            }
            .sheet(isPresented: $isCreateXPresented, onDismiss: {selectedTab = 0}, content: {
                CreateXView()
            })
        .tint(.black)
        }
        
        .environment(viewModel)
        
        
    }
}

#Preview {
    XTabView()
}
