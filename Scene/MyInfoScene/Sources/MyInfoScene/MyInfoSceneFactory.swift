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
    
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    
    public init(didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>) {
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
    }
}

public final class MyInfoSceneFactory {
    
    public init() {}
    
    public func make(with configuration: MyInfoConfiguration) -> MyInfoScene {
        
        let localDataSource = LocalDataSource()
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        let meNetworkWorker = MeNetworkWorker()
        let appleLoginWorker = CommonAppleLoginWorker()
        let myInfoLocalWorker = MyInfoLocalWorker(localDataSource: localDataSource)
        
        let presenter = MyInfoPresenter()
        let router = MyInfoRouter()
        let worker = MyInfoWorker(
            meLocalWorker: meLocalWorker,
            meNetworkWorker: meNetworkWorker,
            appleLoginWorker: appleLoginWorker,
            myInfoLocalWorker: myInfoLocalWorker
        )
        let interactor = MyInfoInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToLoginScene: configuration.didTriggerRouteToLoginScene
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
