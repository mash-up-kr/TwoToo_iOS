//
//  ChallengeConfirmModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChallengeConfirm {
    
    // MARK: Entity
    
    enum Model {
        enum ConfirmStatus {
            /// 챌린지 생성
            case create
            /// 챌린지 확인
            case confirm
            /// 챌린지 수락
            case accept
        }
        
        struct ChallengeInfo {
            /// 챌린지명
            var title: String
            /// 챌린지 시작일
            var startDate: String
            /// 챌린지 마감일
            var endDate: String
            /// 챌린지 규칙
            var rule: String?
        }
    }
    
    enum ViewModel {
        struct ChallengeInfo {
            /// 챌린지명
            var title: String
            /// 챌린지 시작일, 마감일
            var date: String
            /// 챌린지 규칙
            var rule: String?
        }
    }
}
