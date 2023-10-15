//
//  CreateXView.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import SwiftUI

struct CreateXView: View {
    
    @Bindable private var vm = XCreationViewModel()
    @Environment(\.dismiss) var dismiss
    private let profileImageUrl = AuthServices.shared.userDetails?.userData.profileImageUrl ?? ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    CircularProfileImageView(url: profileImageUrl)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.userData?.nickname ?? "")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            
                        TextFieldWithError(hint: "Start X", text: $vm.xBody, isError: vm.viewState.error, errorMessage: vm.viewState.errorMessage, isRegularTextField: false, errorTextLeadingPadding: 8)
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                    .font(.footnote)
                    Spacer()
                    
                    if !vm.xBody.isEmpty {
                        Button {
                            vm.xBody = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }
                Spacer()
            }
            .onChange(of: vm.viewState.success, {
                if vm.viewState.success {
                    dismiss()
                }
            })
            .padding()
            .navigationTitle("New X")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("New")
                        Image(.xLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                }
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
                            .frame(width: 16, height: 16)
                    } else {
                        Button("Post") {
                            vm.createX()
                        }
                        .opacity(vm.xBody.isEmpty ? 0.5 : 1.0)
                        .disabled(vm.xBody.isEmpty)
                        .font(.subheadline)
                        .foregroundStyle(.base)
                        .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}


#Preview {
    CreateXView()
}
