//
//  LoginSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol LoginScene: AnyObject, Scene {
    
}

public struct LoginConfiguration {
    
}

public final class LoginSceneFactory {
    
    public init() {}
    
    public func make(with configuration: LoginConfiguration) -> LoginScene {
        
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let worker = LoginWorker()
        let interactor = LoginInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = LoginViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
