//
//  ChallengeHistorySceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

@MainActor
public protocol ChallengeHistoryScene: AnyObject, Scene {
    
}

public struct ChallengeHistoryConfiguration {
    /// 챌린지 상세
    public var challenge: Challenge
    
    public init(challenge: Challenge) {
        self.challenge = challenge
    }
    
    /// 챌린지
    public struct Challenge {
        /// 챌린지 ID
        public var id: String
        /// 챌린지 이름
        public var name: String
        /// 챌린지 추가 정보 문구
        public var additionalInfo: String?
        /// 챌린지 시작일
        public var startDate: Date
        /// 챌린지 종료일
        public var endDate: Date
        /// 내 정보
        public var myInfo: User
        /// 상대방 정보
        public var partnerInfo: User
        
        public init(id: String, name: String, additionalInfo: String? = nil, startDate: Date, endDate: Date, myInfo: User, partnerInfo: User) {
            self.id = id
            self.name = name
            self.additionalInfo = additionalInfo
            self.startDate = startDate
            self.endDate = endDate
            self.myInfo = myInfo
            self.partnerInfo = partnerInfo
        }
    }
    
    /// 유저
    public struct User {
        /// 유저 ID
        public var id: String
        /// 닉네임
        public var nickname: String
        /// 인증 리스트
        public var certificates: [Certificate]
        
        public init(id: String, nickname: String, certificates: [Certificate]) {
            self.id = id
            self.nickname = nickname
            self.certificates = certificates
        }
    }
    
    /// 인증
    public struct Certificate {
        /// 인증 ID
        public var id: String
        /// 인증 사진
        public var certificateImageUrl: String
        /// 인증 소감
        public var certificateComment: String
        /// 입력 시간
        public var certificateTime: Date
        /// 칭찬 문구
        public var complimentComment: String?
        
        public init(id: String, certificateImageUrl: String, certificateComment: String, certificateTime: Date, complimentComment: String? = nil) {
            self.id = id
            self.certificateImageUrl = certificateImageUrl
            self.certificateComment = certificateComment
            self.certificateTime = certificateTime
            self.complimentComment = complimentComment
        }
    }
}

public final class ChallengeHistorySceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeHistoryConfiguration) -> ChallengeHistoryScene {
        
        let presenter = ChallengeHistoryPresenter()
        let router = ChallengeHistoryRouter()
        let worker = ChallengeHistoryWorker()
        let interactor = ChallengeHistoryInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            challenge: .init(
                id: configuration.challenge.id,
                name: configuration.challenge.name,
                additionalInfo: configuration.challenge.additionalInfo,
                startDate: configuration.challenge.startDate,
                endDate: configuration.challenge.endDate,
                myInfo: .init(
                    id: configuration.challenge.myInfo.id,
                    nickname: configuration.challenge.myInfo.nickname,
                    certificates: configuration.challenge.myInfo.certificates.map {
                        .init(
                            id: $0.id,
                            certificateImageUrl: $0.certificateImageUrl,
                            certificateComment: $0.certificateComment,
                            certificateTime: $0.certificateTime,
                            complimentComment: $0.complimentComment
                        )
                    }
                ),
                partnerInfo: .init(
                    id: configuration.challenge.partnerInfo.id,
                    nickname: configuration.challenge.partnerInfo.nickname,
                    certificates: configuration.challenge.partnerInfo.certificates.map {
                        .init(
                            id: $0.id,
                            certificateImageUrl: $0.certificateImageUrl,
                            certificateComment: $0.certificateComment,
                            certificateTime: $0.certificateTime,
                            complimentComment: $0.complimentComment
                        )
                    }
                )
            )
        )
        let viewController = ChallengeHistoryViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
