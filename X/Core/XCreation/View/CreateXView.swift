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

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    CircularProfileImageView()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.userData?.nickname ?? "")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            
                        TextFieldWithError(hint: "Start X", text: $vm.xBody, isError: vm.viewState.error, errorMessage: vm.viewState.errorMessage, isRegularTextField: false, leadingPadding: 8)
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
                dismiss()
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
                    .foregroundStyle(.black)
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
                        .foregroundStyle(.black)
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
