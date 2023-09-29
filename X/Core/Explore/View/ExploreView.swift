//
//  ExploreView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...4, id: \.self) { user in
                        VStack {
                            UserCell()
                            Divider()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.xLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
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
