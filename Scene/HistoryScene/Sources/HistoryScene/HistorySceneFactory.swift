//
//  HistorySceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol HistoryScene: AnyObject, Scene {
    
}

public struct HistoryConfiguration {
    
}

public final class HistorySceneFactory {
    
    public init() {}
    
    public func make(with configuration: HistoryConfiguration) -> HistoryScene {
        
        let presenter = HistoryPresenter()
        let router = HistoryRouter()
        let worker = HistoryWorker()
        let interactor = HistoryInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = HistoryViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
