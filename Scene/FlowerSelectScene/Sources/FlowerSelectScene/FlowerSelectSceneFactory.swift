//
//  FlowerSelectSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol FlowerSelectScene: AnyObject, Scene {
    
}

public struct FlowerSelectConfiguration {
    
}

public final class FlowerSelectSceneFactory {
    
    public init() {}
    
    public func make(with configuration: FlowerSelectConfiguration) -> FlowerSelectScene {
        
        let presenter = FlowerSelectPresenter()
        let router = FlowerSelectRouter()
        let worker = FlowerSelectWorker()
        let interactor = FlowerSelectInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = FlowerSelectViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
