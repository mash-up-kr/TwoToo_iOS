//
//  ChallengeAdditionalInfoInputSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeAdditionalInfoInputScene: AnyObject, Scene {
    
}

public struct ChallengeAdditionalInfoInputConfiguration {
    let challengeName: String
    let challengeStartDate: String
    let challengeEndDate: String

    public init(
        challengeName: String,
        challengeStartDate: String,
        challengeEndDate: String
    ) {
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
    }
}

public final class ChallengeAdditionalInfoInputSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeAdditionalInfoInputConfiguration) -> ChallengeAdditionalInfoInputScene {
        
        let presenter = ChallengeAdditionalInfoInputPresenter()
        let router = ChallengeAdditionalInfoInputRouter()
        let worker = ChallengeAdditionalInfoInputWorker()
        let interactor = ChallengeAdditionalInfoInputInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            nameDataSource: configuration.challengeName,
            startDateDataSource: configuration.challengeStartDate,
            endDateDataSource: configuration.challengeEndDate
        )
        let viewController = ChallengeAdditionalInfoInputViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
