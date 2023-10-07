//
//  XView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct XView: View {
    
    let xId: String
    let url: String?
    let nickName: String
    let username: String
    let timeAgo: String
    let xBody: String
    let comments: [XData]
    let reposts: [String]
    let likes: [String]
    let userId: String
    
    var xAction: (XActions) -> ()
    
    @State private var isGenericXOptionsPresented = false
    @State private var isOwnXOptionsPresented = false
    private let iconSize: CGFloat = 16
    
    @Environment(FeedViewModel.self) private var viewModel
    
    @ViewBuilder private var heartIcon: some View {
        if likes.contains(userId) {
            CustomIcon(systemName: "heart.fill", height: iconSize, width: iconSize, foregroundStyle: .base)
        } else {
            CustomIcon(systemName: "heart", height: iconSize, width: iconSize, foregroundStyle: .base)
        }
    }
    
    @ViewBuilder private var followButton: some View {
        Button {
            viewModel.handleXAction(actions: .follow(userId: userId))
        } label: {
            HStack {
                CustomIcon(
                    systemName: "person.crop.circle.badge.plus",
                    foregroundStyle: .base
                )
                
                Text("Follow")
                    .foregroundStyle(.base)
                    
                Text("\(username)")
                    .foregroundStyle(.base)
                    .fontWeight(.semibold)
                    .formStyle(.grouped)
                    .presentationDetents([.fraction(0.1)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    @ViewBuilder private var unfollowButton: some View {
        Button {
            viewModel.handleXAction(actions: .unfollow(userId: userId))
        } label: {
            HStack {
                CustomIcon(
                    systemName: "person.crop.circle.badge.minus",
                    foregroundStyle: .red
                )
                Text("Unfollow")
                Text("\(username)")
                    .fontWeight(.semibold)
                    .formStyle(.grouped)
                    .presentationDetents([.fraction(0.1)])
                    .presentationDragIndicator(.visible)
            }
            .foregroundStyle(.red)
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(url: url)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(nickName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(username)
                            .font(.footnote)
                            .fontWeight(.light)
                        Text(timeAgo)
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        Spacer()
                    
                        Button {
                            if viewModel.checkIfItsOwnX(userId: userId) {
                                isOwnXOptionsPresented.toggle()
                            } else {
                                isGenericXOptionsPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text(xBody)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 8)
                    
                    HStack() {
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                CustomIcon(systemName: "message", height: iconSize, width: iconSize, foregroundStyle: .base)
                                Text(comments.count.description)
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                CustomIcon(systemName: "return.right", height: iconSize, width: iconSize, foregroundStyle: .base)
                                    
                            }
                            Text(reposts.count.description)
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                heartIcon
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
                            }
                            Text(likes.count.description)
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            CustomIcon(systemName: "chart.bar", height: iconSize, width: iconSize, foregroundStyle: .base)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            Divider()
        }
        .sheet(isPresented: $isGenericXOptionsPresented) {
            Form {
                if viewModel.checkIfCurrentUserFollowsXOwner(userId: userId) {
                    unfollowButton
                } else {
                    followButton
                }
            }
        }
        .sheet(isPresented: $isOwnXOptionsPresented, content: {
            Form {
                Button {
                    xAction(.deleteX(userId: self.userId, xId: self.xId))
                    isOwnXOptionsPresented.toggle()
                } label: {
                    HStack {
                        CustomIcon(
                            systemName: "trash",
                            foregroundStyle: .base
                        )
                        Text("Delete this X")
                            .foregroundStyle(.base)
                            
                    }
                    
                }
            }
            .formStyle(.grouped)
            .presentationDetents([.fraction(0.1)])
            .presentationDragIndicator(.visible)
        })
        
        
    }
}

#Preview {
    XView(xId: "", url: "", nickName: "Kirstini", username: "@kirstin", timeAgo: "16s ago", xBody: "I'm so annoying hahaha", comments: [], reposts: [], likes: [], userId: "") { action in
        
    }
    .environment(FeedViewModel())
}

