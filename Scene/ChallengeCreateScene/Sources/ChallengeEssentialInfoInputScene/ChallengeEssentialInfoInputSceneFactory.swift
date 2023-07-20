//
//  ChallengeEssentialInfoInputSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChallengeEssentialInfoInputScene: AnyObject, Scene {
    
}

public struct ChallengeEssentialInfoInputConfiguration {

    public init() {}

}

// 이전화면에서 호출하는 곳
public final class ChallengeEssentialInfoInputSceneFactory {

    public init() {}
    
    public func make(with configuration: ChallengeEssentialInfoInputConfiguration) -> ChallengeEssentialInfoInputScene {
        
        let presenter = ChallengeEssentialInfoInputPresenter()
        let router = ChallengeEssentialInfoInputRouter()
        let worker = ChallengeEssentialInfoInputWorker()
        let interactor = ChallengeEssentialInfoInputInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ChallengeEssentialInfoInputViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
