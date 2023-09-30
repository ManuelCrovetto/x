//
//  XView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct XView: View {
    
    let url: String?
    let nickName: String
    let username: String
    let xBody: String
    let comments: [XData]
    let reposts: [String]
    let likes: [String]
    let userId: String
    
    private let iconSize: CGFloat = 16
    
    @ViewBuilder private var heartIcon: some View {
        if likes.contains(userId) {
            Image(systemName: "heart.fill")
                .resizable()
        } else {
            Image(systemName: "heart")
                .resizable()
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
                        Text("· 10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        Spacer()
                    
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text(xBody)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack() {
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                Image("comment-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
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
                                Image("retweet-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize, height: iconSize)
                                    .tint(.black)
                                    
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
                            Image("analytics")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .colorMultiply(.black)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    XView(url: "", nickName: "Kirstini", username: "@kirstin", xBody: "I'm so annoying hahaha", comments: [], reposts: [], likes: [], userId: "")
}

