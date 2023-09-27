//
//  FeedView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI
import Observation

struct FeedView: View {
    
    @Environment(XTabViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ScrollView {
                    LazyVStack {
                        ForEach(0 ... 0, id: \.self) { x in
                            XView()
                        }
                    }
                }

                .refreshable {
                    
                }
                .scrollIndicators(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image(.xLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
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
                            Image(systemName: "list.bullet")
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
}