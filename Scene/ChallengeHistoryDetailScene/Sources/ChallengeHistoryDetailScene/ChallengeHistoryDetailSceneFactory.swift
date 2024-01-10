//
//  ChallengeHistoryDetailSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

@MainActor
public protocol ChallengeHistoryDetailScene: AnyObject, Scene {
    
}

public struct ChallengeHistoryDetailConfiguration {
    
    public var detail: ChallengeDetail
    public var user: User
    
    public init(detail: ChallengeDetail,
                user: User) {
        self.detail = detail
        self.user = user
    }
    
    /// 챌린지 인증 상세 정보
    public struct ChallengeDetail {
        /// 챌린지 ID
        public var challengeID: String
        /// 인증 ID
        public var id: String
        /// 챌린지 이름
        public var challengeName: String
        /// 인증 사진
        public var certificateImageUrl: String
        /// 인증 소감
        public var certificateComment: String
        /// 입력 시간
        public var certificateTime: Date
        /// 칭찬 문구
        public var complimentComment: String?
        
        public init(challengeID: String,
                    id: String,
                    challengeName: String,
                    certificateImageUrl: String,
                    certificateComment: String,
                    certificateTime: Date,
                    complimentComment: String?) {
            self.challengeID = challengeID
            self.id = id
            self.challengeName = challengeName
            self.certificateImageUrl = certificateImageUrl
            self.certificateComment = certificateComment
            self.certificateTime = certificateTime
            self.complimentComment = complimentComment
        }
    }
    
    /// 유저 정보
    public struct User {
        /// 유저 닉네임
        public var myNickname: String
        /// 상대방 닉네임
        public var partnerNickname: String
        /// 본인여부 파악
        public var isMyHistoryDetail: Bool
      
        public init(
          myNickname: String,
          partnerNickname: String,
          isMyHistoryDetail: Bool
        ) {
            self.myNickname = myNickname
            self.partnerNickname = partnerNickname
            self.isMyHistoryDetail = isMyHistoryDetail
        }
    }
    
}

public final class ChallengeHistoryDetailSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeHistoryDetailConfiguration) -> ChallengeHistoryDetailScene {
        let meLocalWorker = MeLocalWorker(localDataSource: LocalDataSource())
        let challengeDetailNetworkWorker = ChallengeDetailNetworkWorker()

        let presenter = ChallengeHistoryDetailPresenter()
        let router = ChallengeHistoryDetailRouter()
        let worker = ChallengeHistoryDetailWorker(meLocalWorker: meLocalWorker, challengeDetailNetworkWorker: challengeDetailNetworkWorker)
        let interactor = ChallengeHistoryDetailInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            detail: .init(challengeID: configuration.detail.challengeID,
                          id: configuration.detail.id,
                          challengeName: configuration.detail.challengeName,
                          myNickname: configuration.user.myNickname,
                          certificateImageUrl: configuration.detail.certificateImageUrl,
                          certificateComment: configuration.detail.certificateComment,
                          certificateTime: configuration.detail.certificateTime,
                          partnerNickname: configuration.user.partnerNickname,
                          complicateComment: configuration.detail.complimentComment,
                          isMyHistoryDetail: configuration.user.isMyHistoryDetail)
        )
        let viewController = ChallengeHistoryDetailViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
