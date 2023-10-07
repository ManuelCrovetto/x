//
//  XTabView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct XTabView: View {

    @State private var selectedTab = 0
    @State private var isCreateXPresented = false
    @State private var viewModel = XTabViewModel()
    
    private let feedTabNumber = 0
    private let exploreTabNumber = 1
    private let createTabNumber = 2
    private let activityTabNumber = 3
    private let profileTabNumber = 4
    
    
    var body: some View {
        ZStack {
            if viewModel.isDrawerOpen {
                NavDrawer()
            }
            
            TabView(selection: $selectedTab) {
                FeedView(
                    onNavigationAction: { navigateTo in
                        switch navigateTo {
                        case .explore:
                            selectedTab = exploreTabNumber
                            break
                        }
                    }
                ).tabItem {
                    Image(systemName: selectedTab == feedTabNumber ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == feedTabNumber ? .fill : .none)
                }
                
                .onTapGesture {
                    selectedTab = feedTabNumber
                }
                .tag(feedTabNumber)
                ExploreView().tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onTapGesture {
                    selectedTab = exploreTabNumber
                }
                .tag(exploreTabNumber)
                Text("").tabItem {
                    Image(systemName: "plus")
                }
                .onTapGesture {
                    selectedTab = createTabNumber
                }
                .tag(createTabNumber)
                ActivityView().tabItem {
                    Image(systemName: selectedTab == activityTabNumber ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == activityTabNumber ? .fill : .none)
                }
                .onTapGesture {
                    selectedTab = activityTabNumber
                }
                .tag(activityTabNumber)
                ProfileView().tabItem {
                    Image(systemName: selectedTab == profileTabNumber ? "message.fill" : "message")
                        .environment(\.symbolVariants, selectedTab == profileTabNumber ? .fill : .none)
                }
                .onTapGesture {
                    selectedTab = profileTabNumber
                }
                .tag(profileTabNumber)
            }
            .if(viewModel.isDrawerOpen) { view in
                view.onTapGesture {
                    withAnimation(.spring) {
                        viewModel.isDrawerOpen.toggle()
                    }
                    
                }
            }
            
            .cornerRadius(viewModel.isDrawerOpen ? 20 : 0)
            .offset(x: viewModel.isDrawerOpen ? 300 : 0, y: viewModel.isDrawerOpen ? 44 : 0)
            .scaleEffect(viewModel.isDrawerOpen ? 0.8 : 1)
            .onChange(of: selectedTab) {
                isCreateXPresented = selectedTab == createTabNumber
            }
            .sheet(isPresented: $isCreateXPresented, onDismiss: {selectedTab = feedTabNumber}, content: {
                CreateXView()
            })
            .tint(.base)
            .ignoresSafeArea()
        }
        
        .environment(viewModel)
        
        
        
    }
}

#Preview {
    XTabView()
}
