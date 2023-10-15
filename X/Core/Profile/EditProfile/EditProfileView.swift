//
//  EditProfileView.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import SwiftUI

struct EditProfileView: View {
    
    private let nameCharLimit = 50
    private let bioCharLimit = 250
    
    @State private var vm = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 8) {
                    HStack {
                        VStack {
                            CircularEditingProfileImageView(url: AuthServices.shared.userDetails?.userData.profileImageUrl)
                            if vm.viewState.pictureError {
                                withAnimation(.easeIn) {
                                    Text("error")
                                        .font(.footnote)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    Divider()
                    VStack {
                        HStack() {
                            Text("Name")
                                .fontWeight(.semibold)
                                .frame(width: geo.size.width * 0.2, alignment: .leading)
                            TextFieldWithError(hint: "Name", text: $vm.nickname, isError: vm.viewState.nameError, errorMessage: vm.viewState.nicknameErrorDescription, isRegularTextField: false, errorTextLeadingPadding: 0)
                        }
                        .padding(.horizontal)
                        Divider()
                        HStack(alignment: .top) {
                            Text("Bio")
                                .fontWeight(.semibold)
                                .frame(minWidth: geo.size.width * 0.2, alignment: vm.bio.isEmpty ? .leading : .topLeading)
                                .padding(.top, 8)
                            TextFieldWithError(hint: "Bio", text: $vm.bio, isError: vm.viewState.bioError, errorMessage: vm.viewState.bioErrorDescription, isRegularTextField: false, errorTextLeadingPadding: 0)
                                .frame(minHeight: 84, maxHeight: 84, alignment: .topLeading)
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    .padding(.bottom, 8)
                    
                }
                .onChange(of: vm.viewState) {
                    if vm.viewState.success {
                        dismiss()
                    }
                }
                .font(.footnote)
                .navigationTitle("Edit profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .font(.subheadline)
                        .foregroundStyle(.base)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if vm.viewState.loading {
                            ProgressView()
                        } else {
                            Button("Save") {
                                vm.saveChanges()
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.surface)
                        }
                    }
                }
                .environment(vm)
            }
            
        }
        
    }
}


#Preview {
    EditProfileView()
        .environment(EditProfileViewModel())
}
