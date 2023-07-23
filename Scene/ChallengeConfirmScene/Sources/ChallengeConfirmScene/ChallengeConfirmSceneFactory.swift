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
    let challengeName: String?
    let challengeStartDate: String?
    let challengeEndDate: String?
    let challegneRule: String?

    public init(
        challengeName: String?,
        challengeStartDate: String?,
        challengeEndDate: String?,
        challengeRule: String?
    ) {
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
        self.challegneRule = challengeRule
    }
    
    public func make(with configuration: ChallengeConfirmConfiguration) -> ChallengeConfirmScene {
        
        let presenter = ChallengeConfirmPresenter()
        let router = ChallengeConfirmRouter()
        let worker = ChallengeConfirmWorker()
        let interactor = ChallengeConfirmInteractor(
            presenter: presenter,
            router: router,
            worker: worker
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
