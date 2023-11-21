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
            // 챌린지 진행 상태
            var viewState: String
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
            var myFlower: Flower?
            /// 상대방 정보
            var partnerFlower: Flower?
        }
        
        struct ErrorToast {
            static let message: String = "히스토리 챌린지 리스트를 불러오는 과정 중 오류가 발생하였습니다"
        }

    }
    
    enum ViewModel {
    
        typealias CellInfoList = [CellInfo]
            
        /// 히스토리 셀 정보
        struct CellInfo {
            /// 챌린지 진행 상태
            var isFinished: Bool
            /// 챌린지 순서
            var order: Int
            /// 챌린지 이름 텍스트
            var nameText: String
            /// 챌린지 날짜 정보 텍스트
            var dateText: String
            /// 상대 꽃 이미지
            var partnerFlowerImage: UIImage?
            /// 내 꽃 이미지
            var myFlowerImage: UIImage?
        }
        
        struct Toast {
            var message: String?
        }
    }
}
