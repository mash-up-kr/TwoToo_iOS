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
    /// 초대장 전송 화면 이동 트리거
    public var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    /// 홈 화면 이동 트리거
    public var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    public init(
        didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
}

public final class NicknameRegistSceneFactory {
    
    public init() {}
    
    public func make(with configuration: NicknameRegistConfiguration) -> NicknameRegistScene {
        let localDataSource = LocalDataSource()
        let invitedUserLocalWorker = InvitedUserLocalWorker(localDataSource: localDataSource)
        let presenter = NicknameRegistPresenter()
        let router = NicknameRegistRouter()
        let worker = NicknameRegistWorker(invitedUserLocalWorker: invitedUserLocalWorker)
        let interactor = NicknameRegistInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToInvitationSendScene: configuration.didTriggerRouteToInvitationSendScene,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene
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
