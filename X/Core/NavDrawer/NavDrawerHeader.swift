//
//  NavDrawerHeader.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct NavDrawerHeader: View {
    
    var nickName: String
    var username: String
    var follows: Int
    var followers: Int
    var profileImageUrl: String
    @State var showOptionsDialog = false
    var action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CircularProfileImageView(url: profileImageUrl)
                Spacer()
                Button {
                    showOptionsDialog.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                }
            }
            .padding(.bottom, 8)
            Text(nickName)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                
            Text("@\(username)")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundStyle(.gray)
                .padding(.bottom, 8)
            Followers(follows: follows, followers: followers)
                .foregroundStyle(.black)
        }
        .sheet(isPresented: $showOptionsDialog, content: {
            AccountsSheet {
                action()
            }
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
        })
        .padding()
        
    }
}

#Preview {
    NavDrawerHeader(nickName: "Manuel", username: "macro", follows: 10, followers: 10000, profileImageUrl: ""){
        
    }
}
