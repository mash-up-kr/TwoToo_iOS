//
//  SplashSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol SplashScene: AnyObject, Scene {
    
}

public struct SplashConfiguration {
    
}

public final class SplashSceneFactory {
    
    public init() {}
    
    public func make(with configuration: SplashConfiguration) -> SplashScene {
        
        let presenter = SplashPresenter()
        let router = SplashRouter()
        let worker = SplashWorker()
        let interactor = SplashInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = SplashViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
