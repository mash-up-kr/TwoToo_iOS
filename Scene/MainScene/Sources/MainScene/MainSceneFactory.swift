//
//  MainSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol MainScene: AnyObject, Scene {
    
}

public struct MainConfiguration {
    
}

public final class MainSceneFactory {
    
    public init() {}
    
    public func make(with configuration: MainConfiguration) -> MainScene {
        
        let presenter = MainPresenter()
        let router = MainRouter()
        let worker = MainWorker()
        let interactor = MainInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = MainViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
