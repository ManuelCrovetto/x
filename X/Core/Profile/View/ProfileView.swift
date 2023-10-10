//
//  ProfileView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter: ProfileXsFilter = .xs
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileXsFilter.allCases.count)
        return UIScreen.main.bounds.width / count
    }
    
    private var vm = ProfileViewModel()
    
    private var nickName = AuthServices.shared.userDetails?.userData.nickname ?? ""
    private var username = "@\(AuthServices.shared.userDetails?.userData.username ?? "")"
    private var bio = AuthServices.shared.userDetails?.userData.bio ?? ""
    private var joined = AuthServices.shared.userDetails?.joinedDate
    private var follows = AuthServices.shared.userDetails?.followsCount ?? 0
    private var followers = AuthServices.shared.userDetails?.followersCount ?? 0
    
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                CircularProfileImageView()
                                VStack(alignment: .leading) {
                                    Text(nickName)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Text(username)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                }
                                .padding(.vertical, 4)
                            }
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Edit profile")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.base)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .overlay {
                                        Capsule(style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                            .stroke(Color.base, lineWidth: 1)
                                    }
                            }
                        }
                        if !bio.isEmpty {
                            VStack {
                                Text(bio)
                                    .font(.headline)
                                    .fontWeight(.regular)
                            }
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("Joined on \(vm.provideJoinedDateFormatted(joinedDate: joined))")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        Followers(follows: follows, followers: followers)
                    }
                }
                .padding()
                VStack {
                    HStack {
                        ForEach(ProfileXsFilter.allCases) { filter in
                            VStack {
                                Text(filter.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundStyle(.black)
                                        .frame(width: filterBarWidth, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                } else {
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .frame(width: filterBarWidth, height: 1)
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedFilter = filter
                                }
                            }
                        }
                    }
                    LazyVStack {
                        ForEach(0...5, id: \.self) { x in
                            
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ProfileView()
}
