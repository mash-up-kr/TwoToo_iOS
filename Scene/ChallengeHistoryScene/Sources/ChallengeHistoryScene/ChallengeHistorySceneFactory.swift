//
//  ChallengeHistorySceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeHistoryScene: AnyObject, Scene {
    
}

public struct ChallengeHistoryConfiguration {
    
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
            worker: worker
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
