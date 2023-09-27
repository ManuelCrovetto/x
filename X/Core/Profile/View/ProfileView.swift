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
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                CircularProfileImageView()
                                VStack(alignment: .leading) {
                                    Text("Der")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Text("@dersarco")
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
                                    .foregroundStyle(.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .overlay {
                                        Capsule(style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                            .stroke(Color.black, lineWidth: 1)
                                    }
                            }
                        }
                        VStack {
                            Text("Me dedico a trolear. Y tu?")
                                .font(.headline)
                                .fontWeight(.regular)
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("Joined September 2018")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        Followers()
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
                            XView()
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
