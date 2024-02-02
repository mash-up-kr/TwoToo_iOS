//
//  ChallengeHistoryModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
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
            /// 완료 여부
            var isFinished: Bool
        }
        
        /// 유저
        struct User: Equatable {
            /// 유저 ID
            var id: String
            /// 닉네임
            var nickname: String
            /// 인증 횟수
            var certCount: Int?
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
            /// 프로그래스
            var progress: ProgressViewModel
            /// 유저 닉네임
            var myNickname: String
            /// 상대방 닉네임
            var partnerNickname: String
            /// 셀 정보
            var cellInfo: CellInfoList
        }
        
        /// 프로그래스
        struct ProgressViewModel: TTProgressViewModelProtocol {
            /// 상대방 이름 텍스트
            var partnerNameText: String
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 퍼센테이지 텍스트
            var partnerPercentageText: String
            /// 내 퍼센테이지 텍스트
            var myPercentageText: String
            /// 상대방 퍼센테이지 넘버
            var partnerPercentageNumber: Double
            /// 내 퍼센테이지 넘버
            var myPercentageNumber: Double
        }
        
        /// 챌린지 테이블 셀 리스트
        typealias CellInfoList = [CellInfo]
        /// 챌린지 테이블 뷰 셀 정보
        struct CellInfo {
            /// 인증 날짜
            var dateText: String
            /// 오늘인지 여부
            var isToday: Bool
            /// 유저 인증 정보
            var my: CertificatePhotoViewModel?
            /// 상대방 인증 정보
            var partner: CertificatePhotoViewModel?
        }
        
        /// 챌린지 테이블 셀 인증 사진 리스트
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
            var photoURL: URL?
            /// 인증 시간
            var timeText: String
        }
    
        /// 그만두기 팝업
        struct QuitPopup {
            /// 타이틀
            var title: String
            /// 그만두기 아이콘
            var iconImage: UIImage
            /// 설명
            var description: String
            /// 경고 문구
            var warningText: String
            /// 하단의 왼쪽, 오른쪽 버튼 타이틀
            var buttonTitles: [String]
        }
        
        struct Toast {
            var message: String?
        }
    }
}
