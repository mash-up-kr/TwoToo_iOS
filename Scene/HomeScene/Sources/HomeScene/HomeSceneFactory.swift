//
//  HomeSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol HomeScene: AnyObject, Scene {
    
}

public struct HomeConfiguration {
    
}

public final class HomeSceneFactory {
    
    public init() {}
    
    public func make(with configuration: HomeConfiguration) -> HomeScene {
        
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = HomeViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
