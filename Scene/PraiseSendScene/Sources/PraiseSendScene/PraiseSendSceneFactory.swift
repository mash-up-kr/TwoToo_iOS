//
//  PraiseSendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol PraiseSendScene: AnyObject, Scene {
    
}

public struct PraiseSendConfiguration {
    
    public init() {}
}

public final class PraiseSendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: PraiseSendConfiguration) -> PraiseSendScene {
        
        let presenter = PraiseSendPresenter()
        let router = PraiseSendRouter()
        let worker = PraiseSendWorker()
        let interactor = PraiseSendInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = PraiseSendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
