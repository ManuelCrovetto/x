//
//  NavDrawerHeader.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct NavDrawerHeader: View {
    
    @State var showOptionsDialog = false
    var action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray)
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
            Text("Manuel")
                .font(.headline)
                .fontWeight(.semibold)
                
            Text("@manuel")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundStyle(.gray)
                .padding(.bottom, 8)
            Followers()
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
    NavDrawerHeader{
        
    }
}
