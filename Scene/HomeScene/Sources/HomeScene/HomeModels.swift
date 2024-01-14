//
//  HomeModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

enum Home {
    
    // MARK: Entity
    
    enum Model {

        /// 홈 정보
        struct HomeInfo {
            /// 챌린지
            var challenge: Challenge
        }
        
        /// 챌린지
        struct Challenge: Equatable {
            /// 챌린지 ID
            var id: String?
            /// 챌린지 이름
            var name: String?
            /// 챌린지 시작일
            var startDate: Date?
            /// 챌린지 종료일
            var endDate: Date?
            /// 챌린지 순서 - n번째 챌린지
            var order: Int?
            /// 챌린지 상태
            var status: Status
            /// 내 정보
            var myInfo: User
            /// 상대방 정보
            var partnerInfo: User
            /// 찌르기 남은 횟수
            var stickRemaining: Int?
            /// 챌린지 설명
            var description: String?
        }

        /// 유저
        struct User: Equatable {
            /// 유저 ID
            var id: String
            /// 닉네임
            var nickname: String
            /// 인증 횟수
            var certCount: Int?
            /// 성장도
            var growStatus: GrowsStatus?
            /// 인증 정보
            var todayCert: Certificate?
            /// 꽃 타입
            var flower: Flower?
        }

        /// 인증
        struct Certificate: Equatable {
            /// 인증 ID
            var id: String
            /// 칭찬 문구
            var complimentComment: String?
            /// 인증 Image URL
            var imageURL: String
            /// 인증 시간
            var time: String
            /// 인증 내용
            var contents: String
        }

        /// 성장도
        typealias GrowsStatus = Worker.GrowsStatus
        
        /// 꽃
        typealias Flower = Worker.Flower

        /// 챌린지 상태
        enum Status: Equatable {
            /// 챌린지 생성전
            case created
            /// 챌린지 대기중
            case waiting
            /// 챌린지 시작전
            case beforeStart
            /// 챌린지 시작일 전
            case beforeStartDate
            /// 챌린지 시작일 초과
            case afterStartDate
            /// 챌린지 진행중
            case inProgress(InProgressStatus)
            /// 챌린지 완료
            case completed(CompletedStatus)
        }

        /// 챌진지 진행 상태
        enum InProgressStatus: Equatable {
            /// 둘다 인증전
            case bothUncertificated
            /// 상대방만 인증
            case onlyPartnerCertificated
            /// 나만 인증
            case onlyMeCertificated
            /// 둘다 인증
            case bothCertificated(BothCertificatedStatus)
        }

        /// 둘다 인증 상태
        enum BothCertificatedStatus: Equatable {
            /// 확인되지 않음
            case uncomfirmed
            /// 확인됨
            case comfirmed
        }

        /// 챌린지 완료 상태
        enum CompletedStatus: Equatable {
            /// 확인되지 않음
            case uncomfirmed
            /// 확인됨
            case comfirmed
        }

    }
    
    enum ViewModel {
        
        /// 챌린지 생성전
        struct ChallengeCreatedViewModel {
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 이름 텍스트
            var partnerNameText: String
        }

        /// 챌린지 대기 중
        struct ChallengeWaitingViewModel {
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 이름 텍스트
            var partnerNameText: String
        }

        /// 챌린지 시작 전
        struct ChallengeBeforeStartViewModel {
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 이름 텍스트
            var partnerNameText: String
            /// 타이틀
            var title: NSAttributedString
        }

        /// 챌린지 시작일 전
        struct ChallengeBeforeStartDateViewModel {
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 이름 텍스트
            var partnerNameText: String
        }

        /// 챌린지 시작일 초과
        struct ChallengeAfterStartDateViewModel {
            /// 내 이름 텍스트
            var myNameText: String
            /// 상대방 이름 텍스트
            var partnerNameText: String
        }

        /// 챌린지 진행중
        struct ChallengeInProgressViewModel {
            /// 챌린지 정보
            var challengeInfo: ChallengeInfoViewModel
            /// 프로그래스
            var progress: ProgressViewModel
            /// 순서
            var order: OrderViewModel
            /// 상대방 꽃
            var partnerFlower: PartnerFlowerViewModel
            /// 내 꽃
            var myFlower: MyFlowerViewModel
            /// 하트 히든 여부
            var isHeartHidden: Bool
            /// 찌르기 텍스트
            var stickText: String
            
            /// 챌린지 정보
            struct ChallengeInfoViewModel {
                /// 챌린지 이름 텍스트
                var challengeNameText: String
                /// 디데이 텍스트
                var dDayText: String
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
            
            /// 순서
            struct OrderViewModel {
                /// 챌린지 순서 텍스트
                var challengeOrderText: String
                /// 상대방 이름 텍스트
                var partenrNameText: String
                /// 내 이름 텍스트
                var myNameText: String
            }

            /// 상대방 꽃
            struct PartnerFlowerViewModel {
                /// 이미지
                var image: UIImage
                /// 꽃 상단 정보
                var topViewModel: TopViewModel
                /// 상대방 이름 텍스트
                var partnerNameText: String
                
                struct TopViewModel {
                    /// 인증 완료 히든 여부
                    var isCertificationCompleteHidden: Bool
                    /// 칭찬 문구 히든 여부
                    var isComplimentCommentHidden: Bool
                    /// 칭찬 문구 텍스트
                    var complimentCommentText: String
                }
            }

            /// 내 꽃
            struct MyFlowerViewModel {
                /// 이미지
                var image: UIImage
                /// 꽃 상단 정보
                var topViewModel: TopViewModel
                /// 내 이름 텍스트
                var myNameText: String
                
                struct TopViewModel {
                    /// 인증 유도 텍스트 히든 여부
                    var isHiddenCetificationGuideText: Bool
                    /// 인증 버튼 히든 여부
                    var isCertificationButtonHidden: Bool
                    /// 인증 안내 텍스트
                    var cetificationGuideText: String
                    /// 칭찬 문구 히든 여부
                    var isComplimentCommentHidden: Bool
                    /// 칭찬 문구 텍스트
                    var complimentCommentText: String
                }
            }
        }
        

        /// 챌린지 완료
        struct ChallengeCompletedViewModel {
            /// 챌린지 정보
            var challengeInfo: ChallengeInfoViewModel
            /// 프로그래스
            var progress: ProgressViewModel
            /// 순서
            var order: OrderViewModel
            /// 상대방 꽃
            var partnerFlower: PartnerFlowerViewModel
            /// 내 꽃
            var myFlower: MyFlowerViewModel
            
            /// 챌린지 정보
            struct ChallengeInfoViewModel {
                /// 챌린지 이름 텍스트
                var challengeNameText: String
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

            /// 순서
            struct OrderViewModel {
                /// 챌린지 순서 텍스트
                var challengeOrderText: String
                /// 상대방 이름 텍스트
                var partenrNameText: String
                /// 내 이름 텍스트
                var myNameText: String
            }

            /// 상대방 꽃
            struct PartnerFlowerViewModel {
                /// 이미지
                var image: UIImage
                /// 상대방 이름 텍스트
                var partnerNameText: String
                /// 꽃말 보기 히든 여부
                var isFlowerLanguageBubbleHidden: Bool
                /// 상대방 꽃말 팝업
                var flowerLanguagePopup: FlowerLanguageViewModel?

            }

            /// 내 꽃
            struct MyFlowerViewModel {
                /// 이미지
                var image: UIImage
                /// 내 이름 텍스트
                var myNameText: String
                /// 꽃말 보기 히든 여부
                var isFlowerLanguageBubbleHidden: Bool
                /// 내 꽃말 팝업
                var flowerLanguagePopup: FlowerLanguageViewModel?
            }
            
            /// 완료 팝업
            struct CompletedPopupViewModel {
                var show: (title: String, message: String, image: UIImage)?
                var dismiss: ()?
                
                /// 옵션
                static let optionText: String = "확인"
            }
            
            struct FlowerLanguageViewModel {
                /// 꽃 이름 텍스트
                var flowerNameText: String
                /// 꽃 말 텍스트
                var flowerDescText: String
                /// 꽃 이미지
                var flowerImage: UIImage
                /// 몇번째 꽃 텍스트
                var flowerOrderText: String
            }
            
            /// 꽃말 팝업
            struct FlowerLanguagePopupViewModel {
                var show: (FlowerLanguageViewModel)?
                var dismiss: ()?
            }
        }
        
        struct Toast {
            var message: String?
        }

    }
}
