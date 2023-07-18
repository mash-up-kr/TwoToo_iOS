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

    public var didTriggerNextButton: PassthroughSubject<[String: String], Never>

    public init(didTriggerNextButton: PassthroughSubject<[String: String], Never>) {
        self.didTriggerNextButton = didTriggerNextButton
    }
}

public final class ChallengeEssentialInfoInputSceneFactory {

    public init() {}
    
    public func make(with configuration: ChallengeEssentialInfoInputConfiguration) -> ChallengeEssentialInfoInputScene {
        
        let presenter = ChallengeEssentialInfoInputPresenter()
        let router = ChallengeEssentialInfoInputRouter()
        let worker = ChallengeEssentialInfoInputWorker()
        let interactor = ChallengeEssentialInfoInputInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerNextButton: configuration.didTriggerNextButton
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
