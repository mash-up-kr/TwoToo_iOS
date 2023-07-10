//
//  ChallengeCertificateWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeCertificateWorkerProtocol {
    /// 카메라 권한 요청
    func requestCameraPermission() async throws -> Bool
    /// 사진 접근 권한 요청
    func requestPhotosPermission() async throws -> Bool
    /// 사진을 갤러리에 저장한다.
    func saveImage(image: ChallengeCertificate.Model.Image) async throws
    /// 인증하기 요청
    func requestCertificate(certificateImage: ChallengeCertificate.Model.Image, certificateComment: String) async throws
}

final class ChallengeCertificateWorker: ChallengeCertificateWorkerProtocol {
    
    func requestCameraPermission() async throws -> Bool {
        return false
    }
    
    func requestPhotosPermission() async throws -> Bool {
        return false
    }
    
    func saveImage(image: ChallengeCertificate.Model.Image) async throws {
        
    }
    
    func requestCertificate(certificateImage: ChallengeCertificate.Model.Image, certificateComment: String) async throws {
        
    }
}
