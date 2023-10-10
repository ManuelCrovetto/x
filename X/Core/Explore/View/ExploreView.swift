//
//  ExploreView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var vm: ExploreViewModel = ExploreViewModel()
    
    @ViewBuilder private var list: some View {
        if vm.viewState.loading {
            ProgressView()
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(vm.usersList, id: \.id) { user in
                        VStack {
                            UserCell(
                                username: user.username,
                                currentlyFollows: user.doesCurrentUserFollowsThisUser,
                                nickName: user.nickname,
                                userId: user.id, isCurrentUser: vm.isCurrentUser(userId: user.id)) { followAction in
                                    vm.followAction(followAction: followAction)
                                }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var searchTextField: some View {
        TextFieldWithError(hint: "Search", text: $vm.query, isError: false, errorMessage: "", icon: "magnifyingglass")
            .padding(.vertical, 16)
    }

    var body: some View {
        NavigationStack {
            VStack {
                searchTextField
                list
                    .onAppear(perform: {
                        vm.searchUsers()
                    })
                    .frame(maxHeight: .infinity)
            }
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: vm.viewState.loading)
            .onChange(of: vm.query) {
                vm.searchUsers()
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.xLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.spring) {
                        }
                    } label: {
                        Image(systemName: "person")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ExploreView()
        .environment(XTabViewModel())
}
