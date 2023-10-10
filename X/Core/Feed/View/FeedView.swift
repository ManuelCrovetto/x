//
//  FeedView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import Observation
import SwiftUI

struct FeedView: View {
    
    var onNavigationAction: (NavigationStates) -> ()
    
    @State private var vm = FeedViewModel()
    @Environment(XTabViewModel.self) private var xTabviewViewModel
    
    @ViewBuilder private var feedBody: some View {
        if vm.viewState.loading && vm.showsProgressViewInCenter {
            ProgressView()
        } else {
            if !vm.viewState.loading && vm.xDataList == nil {
                EmptyView(
                    onAction: {
                        onNavigationAction(.explore)
                    }
                )
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.xDataList ?? [], id: \.id) { x in
                            XView(xId:x.id.orEmpty() ,url: nil, nickName: x.nickName, username: "@\(x.username)", timeAgo: vm.timeAgoPosted(x.date), xBody: x.body, comments: x.comments, reposts: x.reposts, likes: x.reposts, userId: x.userId) { action in
                                vm.handleXAction(actions: action)
                            }.onAppear {
                                withAnimation(.easeIn) {
                                    vm.shouldLoadMoreTweets(xId: x.id ?? "")
                                }
                            }
                        }
                    }
                    if vm.viewState.loading {
                        ProgressView()
                    }
                }
                
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                feedBody
                    .onAppear(perform: {
                        vm.fetchXs(refetchXs: true)
                    })
                .refreshable {
                    withAnimation(.easeIn) {
                        vm.showsProgressViewInCenter = false
                        vm.fetchXs(refetchXs: true)
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image(.xLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.easeIn) {
                                vm.showsProgressViewInCenter = true
                                vm.fetchXs(refetchXs: true)
                            }
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundStyle(.base)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.spring) {
                                xTabviewViewModel.isDrawerOpen.toggle()
                            }
                        } label: {
                            Image(systemName: "person")
                                .foregroundStyle(.base)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .animation(.easeIn, value: vm.viewState.loading)
        }
        .environment(vm)
        .ignoresSafeArea()
    }
}

#Preview {
    FeedView(
        onNavigationAction: { navigateTo in
            
        }
    )
        .environment(XTabViewModel())
}
