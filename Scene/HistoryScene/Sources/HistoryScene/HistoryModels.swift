//
//  HistoryModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import Worker

enum History {
    
    // MARK: Entity
        
    enum Model {
                        
        typealias ChallengeList = [Challenge]
        
        /// 챌린지
        struct Challenge {
            /// 챌린지 ID
            var id: String
            /// 챌린지 순서 - n번째 챌린지
            var order: Int
            /// 챌린지 이름
            var name: String
            /// 시작일
            var startDate: Date
            /// 종료일
            var endDate: Date
            /// 내 정보
            var myInfo: User
            /// 상대방 정보
            var partnerInfo: User
        }
        
        struct User: Equatable {
            /// 유저 ID
            var id: String
            /// 닉네임
            var nickname: String
            /// 꽃 이름
            var flower: Flower
            /// 챌린지 추가 정보 문구
            var additionalInfo: String?
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
        
        struct ErrorToast {
            static let message: String = "히스토리 챌린지 리스트를 불러오는 과정 중 오류가 발생하였습니다"
        }

    }
    
    enum ViewModel {
    
        typealias CellInfoList = [CellInfo]
            
        /// 히스토리 셀 정보
        struct CellInfo {
            /// 챌린지 순서 텍스트
            var orderText: String
            /// 챌린지 이름 텍스트
            var nameText: String
            /// 챌린지 날짜 정보 텍스트
            var dateText: String
            /// 상대 꽃 이미지
            var partnerFlowerImage: UIImage
            /// 내 꽃 이미지
            var myFlowerImage: UIImage
        }
        
        struct Toast {
            var message: String?
        }
    }
}
