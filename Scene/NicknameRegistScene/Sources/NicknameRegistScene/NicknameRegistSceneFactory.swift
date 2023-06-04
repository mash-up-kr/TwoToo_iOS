//
//  NicknameRegistSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol NicknameRegistScene: AnyObject, Scene {
    
}

public struct NicknameRegistConfiguration {
    
}

public final class NicknameRegistSceneFactory {
    
    public init() {}
    
    public func make(with configuration: NicknameRegistConfiguration) -> NicknameRegistScene {
        
        let presenter = NicknameRegistPresenter()
        let router = NicknameRegistRouter()
        let worker = NicknameRegistWorker()
        let interactor = NicknameRegistInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = NicknameRegistViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
