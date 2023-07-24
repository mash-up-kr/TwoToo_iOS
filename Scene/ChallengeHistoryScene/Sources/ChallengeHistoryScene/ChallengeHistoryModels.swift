//
//  ChallengeHistoryModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChallengeHistory {
    
    // MARK: Entity
    
    enum Model {
        
        /// 챌린지
        struct Challenge: Equatable {
            /// 챌린지 ID
            var id: String
            /// 챌린지 이름
            var name: String
            /// 챌린지 추가 정보 문구
            var additionalInfo: String?
            /// 챌린지 시작일
            var startDate: Date
            /// 챌린지 종료일
            var endDate: Date
            /// 내 정보
            var myInfo: User
            /// 상대방 정보
            var partnerInfo: User
        }
        
        /// 유저
        struct User: Equatable {
            /// 유저 ID
            var id: String
            /// 닉네임
            var nickname: String
            /// 인증 리스트
            var certificates: [Certificate]
        }
        
        /// 인증
        struct Certificate: Equatable {
            /// 인증 ID
            var id: String
            /// 인증 사진
            var certificateImageUrl: String
            /// 인증 소감
            var certificateComment: String
            /// 입력 시간
            var certificateTime: Date
            /// 칭찬 문구
            var complimentComment: String?
        }
    }
    
    enum ViewModel {
        
        struct Toast {
            var message: String?
        }
    }
}
