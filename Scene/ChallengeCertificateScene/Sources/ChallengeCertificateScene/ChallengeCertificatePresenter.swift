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
    /// 사진 저장 실패 오류를 보여준다.
    func presentPhotoSaveError(error: Error)
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
        
    }
    
    func presentCameraPermissionPopup() {
        
    }
    
    func presentPhotosPermissionPopup() {
        
    }
    
    func presentCamera() {
        
    }
    
    func presentImagePicker() {
        
    }
    
    func presentImageCropView(with image: ChallengeCertificate.Model.Image) {
        
    }
    
    func presentPhotoSaveError(error: Error) {
        
    }
    
    func presentCertificateImage(image: ChallengeCertificate.Model.Image) {
        
    }
    
    func presentEnabledCertificate() {
        
    }
    
    func presentDisabledCertificate() {
        
    }
    
    func presentCertificateSuccess() {
        
    }
    
    func presentCertificateError(error: Error) {
        
    }
}
