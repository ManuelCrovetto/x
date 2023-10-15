//
//  UserCell.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct UserCell: View {
    
    var username: String = "macro"
    var currentlyFollows = false
    var nickName = "Manuel"
    var userId = ""
    var isCurrentUser = false
    var profileImageUrl = ""
    
    var followAction: (UserActions) -> ()
    
    @ViewBuilder private var followButton: some View {
        if currentlyFollows {
            Button {
                followAction(.unfollow(userId: userId))
            } label: {
                Text("Unfollow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
        } else {
            if isCurrentUser {
                Button {
                    followAction(.viewProfile(userId: userId))
                } label: {
                    Text("View profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.base)
                }
            } else {
                Button {
                    followAction(.follow(userId: userId))
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.base)
                }
            }
            
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                CircularProfileImageView(url: profileImageUrl)
                VStack(alignment: .leading) {
                    Text("@\(username)")
                        .fontWeight(.semibold)
                    Text(nickName)
                }
                .font(.footnote)
                Spacer()
                followButton
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.mini)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            Divider()
        }
    }
}

#Preview {
    UserCell { followAction in
        
    }
}
