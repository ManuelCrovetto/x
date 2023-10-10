//
//  EditProfileView.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name = ""
    @State private var bio = ""
    @State private var isPrivateProfile = false
    private var isBioEmpty: Bool {
        if bio.count == 0 {
            return true
        } else {
            return false
        }
    }
    private let nameCharLimit = 50
    private let bioCharLimit = 250
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Color(.systemGroupedBackground)
                        .edgesIgnoringSafeArea([.bottom, .horizontal])
                    VStack(spacing: 8) {
                        HStack {
                            CircularProfileImageView()
                            Spacer()
                        }
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                        Divider()
                        VStack {
                            HStack() {
                                Text("Name")
                                    .fontWeight(.semibold)
                                    .frame(width: geo.size.width * 0.2, alignment: .leading)
                                    
                                    
                                TextField("Enter your name...", text: $name)
                                    .onChange(of: name) {
                                        if name.count > nameCharLimit {
                                            name = String(name.prefix(nameCharLimit))
                                        }
                                    }
                                    
                            }
                            .padding(.horizontal)
                            Divider()
                            HStack(alignment: .top) {
                                Text("Bio")
                                    .fontWeight(.semibold)
                                    .frame(minWidth: geo.size.width * 0.2, alignment: isBioEmpty ? .leading : .topLeading)
                                    
                                TextField("Bio", text: $bio, axis: .vertical)
                                    .onChange(of: bio) {
                                        
                                        if bio.count > bioCharLimit {
                                            bio = String(bio.prefix(bioCharLimit))
                                        }
                                    }
                                    .frame(minHeight: 84, maxHeight: 84, alignment: .topLeading)
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            Toggle("Private profile", isOn: $isPrivateProfile)
                                .padding(.horizontal)
                                .fontWeight(.semibold)
                        
                        }
                        .padding(.bottom, 8)
                       
                    }
                    
                    .background(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    .font(.footnote)
                    .navigationTitle("Edit profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                
                            }
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Save") {
                                
                            }
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        }
                    }
                }
            }
            
        }
        
    }
}


#Preview {
    EditProfileView()
}
