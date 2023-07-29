//
//  ChallengeCreateFinishSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeCreateFinishScene: AnyObject, Scene {
    
}

public struct ChallengeCreateFinishConfiguration {
    public init() {}
}

public final class ChallengeCreateFinishSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeCreateFinishConfiguration) -> ChallengeCreateFinishScene {
        
        let presenter = ChallengeCreateFinishPresenter()
        let router = ChallengeCreateFinishRouter()
        let worker = ChallengeCreateFinishWorker()
        let interactor = ChallengeCreateFinishInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ChallengeCreateFinishViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
