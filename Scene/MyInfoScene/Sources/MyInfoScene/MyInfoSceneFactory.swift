//
//  MyInfoSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol MyInfoScene: AnyObject, Scene {
    
}

public struct MyInfoConfiguration {
    
}

public final class MyInfoSceneFactory {
    
    public init() {}
    
    public func make(with configuration: MyInfoConfiguration) -> MyInfoScene {
        
        let presenter = MyInfoPresenter()
        let router = MyInfoRouter()
        let worker = MyInfoWorker()
        let interactor = MyInfoInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = MyInfoViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
