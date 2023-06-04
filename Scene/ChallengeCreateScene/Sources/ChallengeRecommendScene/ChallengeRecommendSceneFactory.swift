//
//  ChallengeRecommendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeRecommendScene: AnyObject, Scene {
    
}

public struct ChallengeRecommendConfiguration {
    
}

public final class ChallengeRecommendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeRecommendConfiguration) -> ChallengeRecommendScene {
        
        let presenter = ChallengeRecommendPresenter()
        let router = ChallengeRecommendRouter()
        let worker = ChallengeRecommendWorker()
        let interactor = ChallengeRecommendInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ChallengeRecommendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
