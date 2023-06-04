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
