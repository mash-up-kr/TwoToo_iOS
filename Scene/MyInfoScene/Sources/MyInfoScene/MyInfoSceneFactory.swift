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
        let invitationLocalWorker = InvitationLocalWorker(localDataSource: localDataSource)
        let invitedUserLocalWorker = InvitedUserLocalWorker(localDataSource: localDataSource)
        let meNetworkWorker = MeNetworkWorker()
        let signOutNetworkWorker = SignOutNetworkWorker()
        
        let presenter = MyInfoPresenter()
        let router = MyInfoRouter()
        let worker = MyInfoWorker(
            meLocalWorker: meLocalWorker,
            invitationLocalWorker: invitationLocalWorker,
            invitedUserLocalWorker: invitedUserLocalWorker,
            meNetworkWorker: meNetworkWorker,
            signOutNetworkWorker: signOutNetworkWorker
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
