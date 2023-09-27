//
//  AccountsSheet.swift
//  X
//
//  Created by Manuel Crovetto on 26/09/2023.
//

import SwiftUI

struct AccountsSheet: View {
    
    var signOutAction: () -> ()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Accounts")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
                .padding(.leading, 16)
                .padding(.trailing, 16)
            
            AccountLabel {
                signOutAction()
            }
            VStack(spacing: 8) {
                HStack {
                    Button("Create a new account") {
                        
                    }
                    .font(.callout)
                    
                    Spacer()
                }
                HStack {
                    Button("Add an existing account") {
                        
                    }
                    .font(.callout)
                    Spacer()
                }
            }
            .padding(.bottom, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        
    }
}

#Preview {
    AccountsSheet {
        
    }
}

struct AccountLabel: View {
    
    var labelAction: () -> ()
    
    var body: some View {
        List {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 16)
                VStack {
                    Text("Donny")
                        .font(.callout)
                        .fontWeight(.semibold)
                    Text("@Krottlin")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.blue)
                    .padding(.trailing, 16)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

            .swipeActions {
                Button("Sign out") {
                    labelAction()
                }
                .tint(.red)
            }
        }
        
        .listStyle(.plain)
                
    }
}
