//
//  FeedView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import Observation
import SwiftUI

struct FeedView: View {
    private var vm = FeedViewModel()
    @Environment(XTabViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.xDataList, id: \.id) { x in
                            XView(url: nil, nickName: x.nickName, username: "@\(x.username)", xBody: x.body, comments: x.comments, reposts: x.reposts, likes: x.reposts, userId: x.userId)
                        }
                    }
                }
                .refreshable {
                    vm.fetchXs()
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
                        Image(systemName: "arrow.counterclockwise")
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.spring) {
                                viewModel.isDrawerOpen.toggle()
                            }
                        } label: {
                            Image(systemName: "person")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    FeedView()
        .environment(XTabViewModel())
}
