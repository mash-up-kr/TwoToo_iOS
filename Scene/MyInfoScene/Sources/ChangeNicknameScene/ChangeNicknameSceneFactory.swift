//
//  ChangeNicknameSceneFactory.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol ChangeNicknameScene: AnyObject, Scene {
    
}

public struct ChangeNicknameConfiguration {
    public init() {}
}

public final class ChangeNicknameSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChangeNicknameConfiguration) -> ChangeNicknameScene {
        
        let localDataSource = LocalDataSource()
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        let changeNicknameNetworkWorker = ChangeNicknameNetworkWorker()
        let presenter = ChangeNicknamePresenter()
        let router = ChangeNicknameRouter()
        let worker = ChangeNicknameWorker(meLocalWorker: meLocalWorker, changeNicknameNetworkWorker: changeNicknameNetworkWorker)
        let interactor = ChangeNicknameInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ChangeNicknameViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
