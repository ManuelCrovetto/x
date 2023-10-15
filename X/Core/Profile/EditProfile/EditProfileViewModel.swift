//
//  EditProfileViewModel.swift
//  X
//
//  Created by Manuel Crovetto on 10/10/2023.
//

import Foundation
import Observation
import SwiftUI
import PhotosUI


@Observable class EditProfileViewModel {
    
    var viewState = EditProfileViewState()
    var photoSelected: UIImage? = nil
    
    var pickerItemSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: pickerItemSelection)
        }
    }
    var nickname = AuthServices.shared.userDetails?.userData.nickname ?? ""
    var bio = AuthServices.shared.userDetails?.userData.bio ?? ""
    
    private var saveChangesTask: Task<Void, Never>? = nil
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else {return}
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                photoSelected = uiImage
            } catch {
                print("Error in \(self): \(error)")
            }
        }
    }
    
    func saveChanges() {
        saveChangesTask?.cancel()
        saveChangesTask = Task {
            await self.updateViewState(viewState: EditProfileViewState(loading: true))
            await uploadProfileImage()
            await updateUserDetails()
        }
    }
    
    @MainActor
    func updateViewState(viewState: EditProfileViewState) {
        self.viewState = viewState
    }
    
    private func uploadProfileImage() async {
        guard let imageItem = pickerItemSelection else { return }
        guard let data = try? await imageItem.loadTransferable(type: Data.self) else { 
            await self.updateViewState(viewState: EditProfileViewState(pictureErrorDescription: "Error loading picture, please try again or try with other picture.", pictureError: true))
            return
        }
        switch await UserServices.shared.uploadProfilePicture(data: data) {
        case .error(_):
            await self.updateViewState(viewState: EditProfileViewState(pictureErrorDescription: "Error while uploading profile picture, please try again. #0001", pictureError: true))
            return
        case .success(_, _):
            await self.updateViewState(viewState: EditProfileViewState())
            return
        }
    }
    
    private func updateUserDetails() async {
        if nickname.isEmpty {
            await self.updateViewState(viewState: EditProfileViewState(nicknameErrorDescription: "Name can't be empty.", nameError: true))
            return
        }
        switch await UserServices.shared.updateUserData(nickname: nickname, bio: bio) {
        case .error(_):
            await self.updateViewState(viewState: EditProfileViewState(error: true, finalErrorDescription: "We had an error, please try again."))
        case .success(_, _):
            await self.updateViewState(viewState: EditProfileViewState(success: true, finalErrorDescription: "We had an error, please try again."))
        }
    }
}
