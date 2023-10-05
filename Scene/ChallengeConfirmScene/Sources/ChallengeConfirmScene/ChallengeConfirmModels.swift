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
        /// 그만두기 팝업
        struct QuitPopup {
            /// 타이틀
            var title: String
            /// 그만두기 아이콘
            var iconImage: UIImage
            /// 설명
            var description: String
            /// 경고문구
            var warning: String
            /// 하단의 왼쪽, 오른쪽 버튼 타이틀
            var buttonTitles: [String]
        }
        
        struct Toast {
            var message: String?
        }
    }
}
