//
//  ChallengeCertificateWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import AVFoundation
import Photos
import UIKit

protocol ChallengeCertificateWorkerProtocol {
    /// 카메라 권한 요청
    func requestCameraPermission() async throws -> Bool
    /// 사진 접근 권한 요청
    func requestPhotosPermission() async throws -> Bool
    /// 사진을 갤러리에 저장한다.
    func saveImage(image: ChallengeCertificate.Model.Image) async throws
    /// 인증하기 요청
    func requestCertificate(challengeID: String, certificateImage: ChallengeCertificate.Model.Image, certificateComment: String) async throws
}

final class ChallengeCertificateWorker: ChallengeCertificateWorkerProtocol {
    
    var commitNetworkWorker: CommitNetworkWorkerProtocol
    
    init(commitNetworkWorker: CommitNetworkWorkerProtocol) {
        self.commitNetworkWorker = commitNetworkWorker
    }
    
    func requestCameraPermission() async throws -> Bool {
        return await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video) { granted in
                continuation.resume(returning: granted)
            }
        }
    }
    
    func requestPhotosPermission() async throws -> Bool {
        return await withCheckedContinuation { continuation in
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    continuation.resume(returning: status == .authorized)
                }
            } else {
                PHPhotoLibrary.requestAuthorization { status in
                    continuation.resume(returning: status == .authorized)
                }
            }
        }
    }
    
    func saveImage(image: ChallengeCertificate.Model.Image) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            guard let data = image.jpegData(compressionQuality: 1.0) else {
                continuation.resume(
                    throwing: NSError(domain: "image_download", code: -1, userInfo: [NSLocalizedDescriptionKey: "Wrong Image Data"])
                )
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: data, options: nil)
            }, completionHandler: { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                else if success {
                    continuation.resume()
                }
            })
        }
    }
    
    func requestCertificate(challengeID: String, certificateImage: ChallengeCertificate.Model.Image, certificateComment: String) async throws {
        guard let challengeNo = Int(challengeID) else {
            throw NSError(domain: "not fount challenge", code: -1)
        }
        guard let img = self.compressImage(certificateImage) else {
            throw NSError(domain: "not fount img", code: -1)
        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let formattedDate = dateFormatter.string(from: date)
        
        _ = try await self.commitNetworkWorker.requestCommit(
            text: certificateComment,
            challengeNo: challengeNo,
            img: img,
            fileName: formattedDate
        )
    }
    
    private func compressImage(
        _ image: UIImage,
        quality: CGFloat = 1,
        maxWidth: CGFloat = 1920,
        maxHeight: CGFloat = 1920
    ) -> Data? {
        var actualHeight: CGFloat = image.size.height
        var actualWidth: CGFloat = image.size.width
        var imgRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = maxWidth / maxHeight

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        image.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage?.jpegData(compressionQuality: quality)
    }
}
