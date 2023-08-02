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
    /// 로그인 화면 이동 트리거
    public var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    
    public init(didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>) {
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
    }
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
            worker: worker,
            didTriggerRouteToLoginScene: configuration.didTriggerRouteToLoginScene
        )
        let viewController = MainTabBarController(
            interactor: interactor
        )
        presenter.tabBarController = viewController
        router.tabBarController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
