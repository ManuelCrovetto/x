//
//  CircularEditingProfileView.swift
//  X
//
//  Created by Manuel Crovetto on 11/10/2023.
//

import PhotosUI
import SwiftUI

struct CircularEditingProfileImageView: View {
    var url: String? = nil
   

    @Environment(EditProfileViewModel.self) private var vm

    var body: some View {
        @Bindable var vm = vm
        ZStack(alignment: .center) {
            CircularProfileImageView(
                url: url,
                width: 70,
                height: 70,
                uiImage: vm.photoSelected
            )
            PhotosPicker(selection: $vm.pickerItemSelection, matching: .images) {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                    .overlay(alignment: .center) {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}

#Preview {
    CircularEditingProfileImageView()
        .environment(EditProfileViewModel())
}
