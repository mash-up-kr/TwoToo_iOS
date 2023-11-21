//
//  ChallengeCertificatePresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeCertificatePresentationLogic {
    /// 이미지 첨부 방식 팝업을 보여준다.
    func presentImageAttachmentMethodPopup()
    /// 카메라 및 사진 접근 권한 팝업을 보여준다.
    func presentCameraPermissionPopup()
    /// 사진 접근 권한 팝업을 보여준다.
    func presentPhotosPermissionPopup()
    /// 카메라를 보여준다.
    func presentCamera()
    /// 이미지 피커를 보여준다.
    func presentImagePicker()
    /// 이미지 크롭 화면을 보여준다.
    func presentImageCropView(with image: ChallengeCertificate.Model.Image)
    /// 인증 사진을 보여준다.
    func presentCertificateImage(image: ChallengeCertificate.Model.Image)
    /// 인증하기를 활성화하여 보여준다.
    func presentEnabledCertificate()
    /// 인증하기를 비활성화하여 보여준다.
    func presentDisabledCertificate()
    /// 인증 성공을 보여준다.
    func presentCertificateSuccess()
    /// 인증 실패를 보여준다.
    func presentCertificateError(error: Error)
}

final class ChallengeCertificatePresenter {
    weak var viewController: ChallengeCertificateDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeCertificatePresenter: ChallengeCertificatePresentationLogic {
    
    func presentImageAttachmentMethodPopup() {
        self.viewController?.displayImageAttachmentMethodPopup(viewModel: .init(
            options: (
                ChallengeCertificate.ViewModel.ImageAttachmentMethodPopup.cameraOptionText,
                ChallengeCertificate.ViewModel.ImageAttachmentMethodPopup.albumOptionText,
                ChallengeCertificate.ViewModel.ImageAttachmentMethodPopup.cancelOptionText
            )
        ))
    }
    
    func presentCameraPermissionPopup() {
        self.viewController?.displayPermissionPopup(viewModel: .init(
            options: (
                "카메라 및 사진 접근 권한이 필요합니다",
                ChallengeCertificate.ViewModel.PermissionPopup.desc,
                ChallengeCertificate.ViewModel.PermissionPopup.acceptOption
            )
        ))
    }
    
    func presentPhotosPermissionPopup() {
        self.viewController?.displayPermissionPopup(viewModel: .init(
            options: (
                "사진 접근 권한이 필요합니다",
                ChallengeCertificate.ViewModel.PermissionPopup.desc,
                ChallengeCertificate.ViewModel.PermissionPopup.acceptOption
            )
        ))
    }
    
    func presentCamera() {
        self.viewController?.displayCamera(viewModel: .init())
    }
    
    func presentImagePicker() {
        self.viewController?.displayImagePicker(viewModel: .init())
    }
    
    func presentImageCropView(with image: ChallengeCertificate.Model.Image) {
        self.viewController?.displayImageCropView(viewModel: .init(image: image))
    }
    
    func presentCertificateImage(image: ChallengeCertificate.Model.Image) {
        self.viewController?.displayCommitPhoto(viewModel: .init(image: image))
    }
    
    func presentEnabledCertificate() {
        self.viewController?.displayCommitButton(viewModel: .init(isEnabled: true))
    }
    
    func presentDisabledCertificate() {
        self.viewController?.displayCommitButton(viewModel: .init(isEnabled: false))
    }
    
    func presentCertificateSuccess() {
        self.viewController?.displayToast(viewModel: .init(message: "오늘의 인증을 완료했습니다!"))
    }
    
    func presentCertificateError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "인증에 실패하였습니다. 다시 시도해주세요."))
    }
}
