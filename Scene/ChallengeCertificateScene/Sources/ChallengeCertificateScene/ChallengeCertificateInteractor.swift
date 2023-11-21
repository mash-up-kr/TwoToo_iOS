//
//  ChallengeCertificateInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeCertificateBusinessLogic {
    /// 이미지 추가 버튼 클릭
    func didTapImageAdd() async
    /// 이미지 첨부 방식 팝업의 사진 촬영하기 버튼 클릭
    func didTapImageAttachmentMethodPopupCameraButton() async
    /// 이미지 첨부 방식 팝업의 앨범에서 가져오기 버튼 클릭
    func didTapImageAttachmentMethodPopupGalleryButton() async
    /// 사진 촬영
    func didTakePhoto(image: UIImage) async
    /// 이미지 피커에서 사진 선택
    func didSelectImagePickerImage(selectedImage: UIImage) async
    /// 이미지 크롭
    func didCropImage(image: UIImage) async
    /// 인증소감 문구 입력
    func didEnterCertificateComment(comment: String) async
    /// 인증 사진 데이터 업데이트 됨
    func didUpdateCertificateImage() async
    /// 인증 소감 데이터 업데이트 됨
    func didUpdateCertificateComment() async
    /// 인증 하기 버튼 클릭
    func didTapCertificate() async
}

protocol ChallengeCertificateDataStore: AnyObject {
    /// 챌린지 ID
    var challengeID: String { get }
    /// 인증 사진
    var certificateImage: ChallengeCertificate.Model.Image? { get set }
    /// 인증 소감
    var certificateComment: String { get set }
}

final class ChallengeCertificateInteractor: ChallengeCertificateDataStore, ChallengeCertificateBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeCertificatePresentationLogic
    var router: ChallengeCertificateRoutingLogic
    var worker: ChallengeCertificateWorkerProtocol
    
    init(
        presenter: ChallengeCertificatePresentationLogic,
        router: ChallengeCertificateRoutingLogic,
        worker: ChallengeCertificateWorkerProtocol,
        challengeID: String
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.challengeID = challengeID
    }
    
    // MARK: - DataStore
    
    var challengeID: String
    
    var certificateImage: ChallengeCertificate.Model.Image?
    
    var certificateComment: String = ""
    
    /// 인증 사진 데이터 업데이트
    private func updateCertificateImage(certificateImage: ChallengeCertificate.Model.Image?) async {
        self.certificateImage = certificateImage
        await self.didUpdateCertificateImage()
    }
    
    /// 인증 소감 데이터 업데이트
    private func updateCertificateComment(certificateComment: String) async {
        self.certificateComment = certificateComment
        await self.didUpdateCertificateComment()
    }
}

// MARK: - Interactive Business Logic

extension ChallengeCertificateInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (인증 이미지 첨부)

extension ChallengeCertificateInteractor {
    
    func didTapImageAdd() async {
        await self.presenter.presentImageAttachmentMethodPopup()
    }
    
    func didTapImageAttachmentMethodPopupCameraButton() async {
        do {
            let cameraPermissionAccepted = try? await self.worker.requestCameraPermission()
            let photosPermissionAccepted = try? await self.worker.requestPhotosPermission()
            
            if let cameraPermissionAccepted = cameraPermissionAccepted,
               let photosPermissionAccepted = photosPermissionAccepted {
                
                if cameraPermissionAccepted, photosPermissionAccepted {
                    await self.presenter.presentCamera()
                }
                else {
                    await self.presenter.presentCameraPermissionPopup()
                }
            }
        }
    }
    
    func didTapImageAttachmentMethodPopupGalleryButton() async {
        do {
            if let permissionAccepted = try? await self.worker.requestPhotosPermission(),
               permissionAccepted {
                await self.presenter.presentImagePicker()
            }
            else {
                await self.presenter.presentPhotosPermissionPopup()
            }
        }
    }
    
    func didTakePhoto(image: UIImage) async {
        await self.presenter.presentImageCropView(with: image)
    }
    
    func didSelectImagePickerImage(selectedImage: UIImage) async {
        await self.presenter.presentImageCropView(with: selectedImage)
    }
    
    func didCropImage(image: UIImage) async {
        await self.updateCertificateImage(certificateImage: image)
        await self.presenter.presentCertificateImage(image: image)
    }
}

// MARK: Feature (인증소감 문구 작성)

extension ChallengeCertificateInteractor {
    
    func didEnterCertificateComment(comment: String) async {
        await self.updateCertificateComment(certificateComment: comment)
    }
}

// MARK: Feature (인증하기)

extension ChallengeCertificateInteractor {
    
    func didUpdateCertificateImage() async {
        if self.certificateImage == nil || self.certificateComment.isEmpty {
            await self.presenter.presentDisabledCertificate()
        }
        else {
            await self.presenter.presentEnabledCertificate()
        }
    }
    
    func didUpdateCertificateComment() async {
        if self.certificateImage == nil || self.certificateComment.isEmpty {
            await self.presenter.presentDisabledCertificate()
        }
        else {
            await self.presenter.presentEnabledCertificate()
        }
    }
    
    func didTapCertificate() async {
        guard let certificateImage = self.certificateImage else {
            return
        }
        do {
            try await self.worker.requestCertificate(
                challengeID: self.challengeID,
                certificateImage: certificateImage,
                certificateComment: self.certificateComment
            )
            await self.presenter.presentCertificateSuccess()
            await self.router.dismiss()
        }
        catch {
            await self.presenter.presentCertificateError(error: error)
            await self.router.dismiss()
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeCertificateInteractor {
    
}
