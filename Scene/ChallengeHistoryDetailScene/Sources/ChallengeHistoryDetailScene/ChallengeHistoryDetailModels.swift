//
//  ChallengeHistoryDetailModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import SKPhotoBrowser

enum ChallengeHistoryDetail {
    
    // MARK: Entity
    
    enum Model {
        
        /// 챌린지 상세 정보
        struct ChallengeDetail: Equatable {
            /// 챌린지 ID
            var challengeID: String
            /// 인증 ID
            var id: String
            /// 챌린지 이름
            var challengeName: String
            /// 유저 닉네임
            var myNickname: String
            /// 인증 사진
            var certificateImageUrl: String
            /// 인증 소감
            var certificateComment: String?
            /// 입력 시간
            var certificateTime: Date
            /// 상대방 닉네임
            var partnerNickname: String
            /// 칭찬 문구
            var complicateComment: String?
            /// 내 챌린지 상세정보 여부
            var isMine: Bool
        }
    }
    
    enum ViewModel {
        /// 인증
        struct Challenge {
            /// 챌린지 이름
            var challengeName: String
            /// 인증 날짜
            var certificationDateText: String
            /// (유저 닉네임)의 기록
            var navigationTitle: String
            /// 인증 사진
            var certificationImageURL: URL?
            /// 인증 소감
            var certificationComment: String?
            /// 인증 시간
            var certificationTimeText: String
        }
        
        /// 칭찬
        struct Compliment {
            /// (상대방 닉네임)이 보낸 칭찬
            var complimentTitle: String
            /// 칭찬 문구
            var complimentComment: String?
            /// 내 히스토리 디테일 여부
            var isMyHitstoyDetail: Bool
        }
        
        /// 사진
        struct Photo {
            var images: [SKPhoto]
        }

        struct Toast {
            var message: String?
        }
    }
}
