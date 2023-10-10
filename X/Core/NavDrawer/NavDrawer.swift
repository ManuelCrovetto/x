//
//  NavDrawer.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct NavDrawer: View {
    
    private let width = UIScreen.main.bounds.width - 100
    private var vm = NavDrawerViewModel()
    
    @Environment(XTabViewModel.self) private var xTabVM
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack() {
                    NavDrawerHeader(nickName: AuthServices.shared.userDetails?.userData.nickname ?? "", username: AuthServices.shared.userDetails?.userData.username ?? "", follows: AuthServices.shared.userDetails?.followsCount ?? 0, followers: AuthServices.shared.userDetails?.followersCount ?? 0) {
                        vm.signOut()
                    }
                    NavigationLink {
                        ProfileView()
                            .onAppear(perform: {
                                xTabVM.isPresentingDrawerNavigations = true
                            })
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("Profile")
                                .fontWeight(.semibold)
                               
                            Spacer()
                        }
                    }
                    .foregroundStyle(.black)
                    .padding()
                    Spacer()
                }
                .onAppear(perform: {
                    xTabVM.isPresentingDrawerNavigations = false
                })
            }
        }
        
    }
}

#Preview {
    NavDrawer()
        .environment(XTabViewModel())
}


