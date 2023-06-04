//
//  InvitationSendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol InvitationSendScene: AnyObject, Scene {
    
}

public struct InvitationSendConfiguration {
    
}

public final class InvitationSendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: InvitationSendConfiguration) -> InvitationSendScene {
        
        let presenter = InvitationSendPresenter()
        let router = InvitationSendRouter()
        let worker = InvitationSendWorker()
        let interactor = InvitationSendInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = InvitationSendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
