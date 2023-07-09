//
//  ChallengeCertificateModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChallengeCertificate {
    
    // MARK: Entity
    
    enum Model {
        
        typealias Image = UIImage
    }
    
    enum ViewModel {
        
        struct ImageAttachmentMethodPopup {
            static let cameraOptionText = "사진 촬영하기"
            static let albumOptionText = "앨범에서 가져오기"
            static let cancelOptionText = "취소"
        }
        
        struct CertificateCommentField {
            static let maxLength = 100
        }
        
        struct PermissionPopup {
            var title: String
            var desc: String = "설정에서 권한을 재설정해주세요."
            var buttonTitle: String = "확인"
        }
        
        struct Toast {
            var message: String?
        }
    }
}
