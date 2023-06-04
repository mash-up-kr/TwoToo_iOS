//
//  ChallengeHistoryDetailSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeHistoryDetailScene: AnyObject, Scene {
    
}

public struct ChallengeHistoryDetailConfiguration {
    
}

public final class ChallengeHistoryDetailSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeHistoryDetailConfiguration) -> ChallengeHistoryDetailScene {
        
        let presenter = ChallengeHistoryDetailPresenter()
        let router = ChallengeHistoryDetailRouter()
        let worker = ChallengeHistoryDetailWorker()
        let interactor = ChallengeHistoryDetailInteractor(
            presenter: presenter,
            router: router,
            worker: worker
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
