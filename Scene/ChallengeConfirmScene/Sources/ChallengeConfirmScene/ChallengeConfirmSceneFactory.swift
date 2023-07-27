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
    public init() {}
}

public final class ChallengeConfirmSceneFactory {
    /// 챌린지명
    let challengeName: String
    /// 챌린지 시작일
    let challengeStartDate: String
    /// 챌린지 마감일
    let challengeEndDate: String
    /// 챌린지 규칙
    let challegneRule: String?
    /// 진입점 상태
    let didEnterStatus: String

    public init(
        challengeName: String,
        challengeStartDate: String,
        challengeEndDate: String,
        challengeRule: String?,
        didEnterStatus: String
    ) {
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
        self.challegneRule = challengeRule
        self.didEnterStatus = didEnterStatus
    }
    
    public func make(with configuration: ChallengeConfirmConfiguration) -> ChallengeConfirmScene {
        
        let presenter = ChallengeConfirmPresenter()
        let router = ChallengeConfirmRouter()
        let worker = ChallengeConfirmWorker()
        let interactor = ChallengeConfirmInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            challengeName: challengeName,
            challengeStartDate: challengeStartDate,
            challengeEndDate: challengeEndDate,
            challengeRule: challegneRule,
            didEnterStatus: didEnterStatus
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
