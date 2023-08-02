//
//  ChallengeConfirmSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeConfirmScene: AnyObject, Scene {
    
}

public struct ChallengeConfirmConfiguration {
    /// 챌린지명
    let challengeName: String
    /// 챌린지 시작일
    let challengeStartDate: String
    /// 챌린지 마감일
    let challengeEndDate: String
    /// 챌린지 규칙
    let challegneRule: String?
    /// 챌린지 ID
    let challengeID: String?
    /// 진입점 상태
    let didEnterStatus: String

    public init(
        challengeName: String,
        challengeStartDate: String,
        challengeEndDate: String,
        challengeRule: String?,
        challengeID: String?,
        didEnterStatus: String
    ) {
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
        self.challegneRule = challengeRule
        self.challengeID = challengeID
        self.didEnterStatus = didEnterStatus
    }
}

public final class ChallengeConfirmSceneFactory {

    public init() {}
    
    public func make(with configuration: ChallengeConfirmConfiguration) -> ChallengeConfirmScene {
        
        let presenter = ChallengeConfirmPresenter()
        let router = ChallengeConfirmRouter()
        let worker = ChallengeConfirmWorker()
        let interactor = ChallengeConfirmInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            challengeName: configuration.challengeName,
            challengeStartDate: configuration.challengeStartDate,
            challengeEndDate: configuration.challengeEndDate,
            challengeRule: configuration.challegneRule,
            challengeID: configuration.challengeID,
            didEnterStatus: configuration.didEnterStatus
        )
        let viewController = ChallengeConfirmViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
