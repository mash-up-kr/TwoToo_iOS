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
    /// 대기 화면 이동 트리거
    /// - Parameters:
    ///     - 초대 링크 `String`
    public var didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>
    
    public init(didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>) {
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
    }
}

public final class InvitationSendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: InvitationSendConfiguration) -> InvitationSendScene {
        
        let localDataSource = LocalDataSource()
        let invitationLocalWorker = InvitationLocalWorker(localDataSource: localDataSource)
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        
        let presenter = InvitationSendPresenter()
        let router = InvitationSendRouter()
        let worker = InvitationSendWorker(
            invitationLocalWorker: invitationLocalWorker,
            meLocalWorker: meLocalWorker
        )
        let interactor = InvitationSendInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToInvitationWaitScene: configuration.didTriggerRouteToInvitationWaitScene
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
