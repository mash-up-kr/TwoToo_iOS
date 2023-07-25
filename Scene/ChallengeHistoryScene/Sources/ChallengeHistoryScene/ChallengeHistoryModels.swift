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
        
        typealias CertificateList = [Certificate]
        
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
        
        /// 챌린지
        struct Challenge {
            /// 챌린지 ID
            var id: String
            /// 챌린지 이름
            var name: String
            /// 챌린지 디데이
            var dDayText: String
            /// 챌린지 추가 정보 문구
            var additionalInfo: String?
            /// 유저 닉네임
            var myNickname: String
            /// 상대방 닉네임
            var partnerNickname: String
            /// 셀 정보
            var cellInfo: CellInfoList
        }
        
        /// 테이블 뷰 셀 리스트
        typealias CellInfoList = [CellInfo]
        /// 테이블 뷰 셀 정보
        struct CellInfo {
            /// 인증 날짜
            var dateText: String
            /// 유저 인증 정보
            var my: CertificatePhotoViewModel
            /// 상대방 인증 정보
            var partner: CertificatePhotoViewModel
        }
        
        /// 테이블 뷰 셀 인증 사진 리스트
        typealias CertificateList = [CertificatePhotoViewModel]
        
        /// 유저 타입
        enum UserType {
            case user
            case partner
        }
        
        /// 테이블 뷰 셀 인증 사진 정보
        struct CertificatePhotoViewModel {
            /// 인증 ID
            var certificateID: String
            /// 유저 ID
            var user: UserType
            /// 인증 사진
            var photoURL: URL
            /// 인증 시간
            var timeText: String
        }
        
        struct Toast {
            var message: String?
        }
    }
}
