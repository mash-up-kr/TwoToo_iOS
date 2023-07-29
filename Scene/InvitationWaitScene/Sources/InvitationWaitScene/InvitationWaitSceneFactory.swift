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
    /// 홈 화면 이동 트리거
    public var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    /// 공유 링크 (optional)
    public var invitationLink: String?
    
    public init(
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>,
        invitationLink: String? = nil
    ) {
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
        self.invitationLink = invitationLink
    }
}

public final class InvitationWaitSceneFactory {
    
    public init() {}
    
    public func make(with configuration: InvitationWaitConfiguration) -> InvitationWaitScene {
        
        let localDataSource = LocalDataSource()
        let invitedUserLocalWorker = InvitedUserLocalWorker(localDataSource: localDataSource)
        let invitationLocalWorker = InvitationLocalWorker(localDataSource: localDataSource)
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        let partnerNetworkWorker = PartnerNetworkWorker()
        let nicknameNetworkWorker = NicknameNetworkWorker()
        
        let presenter = InvitationWaitPresenter()
        let router = InvitationWaitRouter()
        let worker = InvitationWaitWorker(
            invitedUserLocalWorker: invitedUserLocalWorker,
            invitationLocalWorker: invitationLocalWorker,
            meLocalWorker: meLocalWorker,
            partnerNetworkWorker: partnerNetworkWorker,
            nicknameNetworkWorker: nicknameNetworkWorker
        )
        let interactor = InvitationWaitInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene,
            invitationLink: configuration.invitationLink
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
