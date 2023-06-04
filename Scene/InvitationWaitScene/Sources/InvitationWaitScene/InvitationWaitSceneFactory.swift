//
//  InvitationWaitSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol InvitationWaitScene: AnyObject, Scene {
    
}

public struct InvitationWaitConfiguration {
    
}

public final class InvitationWaitSceneFactory {
    
    public init() {}
    
    public func make(with configuration: InvitationWaitConfiguration) -> InvitationWaitScene {
        
        let presenter = InvitationWaitPresenter()
        let router = InvitationWaitRouter()
        let worker = InvitationWaitWorker()
        let interactor = InvitationWaitInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = InvitationWaitViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
